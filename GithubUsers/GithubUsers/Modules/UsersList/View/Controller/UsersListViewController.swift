//
//  UsersListViewController.swift
//  GithubUsers
//
//  Created by Vikas Kumar on 01/07/25.
//

import UIKit

class UsersListViewController: UIViewController {

    // MARK: - Private UI Properties
    let searchTextField: UITextField = {
        let textField                    = UITextField()
        textField.placeholder            = Constant.SearchPlaceholder
        textField.textColor              = AppColor.mainLabel
        textField.backgroundColor        = AppColor.SearchBackground
        textField.borderStyle            = .roundedRect
        textField.returnKeyType          = .search
        textField.autocapitalizationType = .none
        textField.autocorrectionType     = .no
        textField.spellCheckingType      = .no
        textField.clearButtonMode        = .unlessEditing
        if #available(iOS 17.0, *) {
            textField.inlinePredictionType = .no
        }
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addDoneButtonOnKeyboard()
        textField.applyRoundedCorner(of: 8)
        textField.applyBorder(width: 1, color: .lightGray)
        return textField
    }()

    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<SectionType, UserModel>!
    
    // MARK: - Private Properties
    private enum SectionType: Int {
        case user
    }
    
    private var isLoading = false
    private var isSearching = false
    private var searchWorkItem: DispatchWorkItem?
    
    private let userListViewModel: UserListViewModel
    
    // MARK: - Custom Init Method
    init(with viewModel: UserListViewModel) {
        userListViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Controller LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColor.background
        title = Constant.UserListTitle
        
        setupNavigationBar(canReload: true)
        showLogoutButton()

        setupSearchTextField()
        configureCollectionView()
        configureDataSource()
        
        fetchUsers()
    }
    
    override func reloadTapped() {
        isSearching = false
        searchTextField.text = Constant.EmptyString
        hideErrorLabel()
        userListViewModel.resetPage()
        applySnapshot(items: [])
        fetchUsers()
    }
}
// MARK: - Private Setup UI Methods
private extension UsersListViewController {

    func setupSearchTextField() {
        view.addSubview(searchTextField)
        searchTextField.delegate = self
        
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            searchTextField.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    // MARK: - Layout Methods
    func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.delegate = self
        collectionView.backgroundColor = AppColor.background
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(UserListCell.self, forCellWithReuseIdentifier: UserListCell.reuseID)
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 16),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        let provider: UICollectionViewCompositionalLayoutSectionProvider = { [weak self] section, _ in
            return self?.cellLayout()
        }
        return UICollectionViewCompositionalLayout(sectionProvider: provider)
    }
    
    func cellLayout() -> NSCollectionLayoutSection {
        // Item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.33),
                                              heightDimension: .estimated(150))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // Group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .estimated(150))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(16)
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 16
        section.contentInsets = .init(top: 0, leading: 16, bottom: 10, trailing: 16)
        return section
    }
    
    // MARK: - DataSource Methods
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<SectionType, UserModel>(collectionView: collectionView) { collectionView, indexPath, model in
            let cell: UserListCell = collectionView.dequeueReusableCell(withReuseIdentifier: UserListCell.reuseID, for: indexPath) as! UserListCell
            cell.updateCell(with: model.avatarURL, and: model.login)
            return cell
        }
    }
    
    func applySnapshot(items: [UserModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<SectionType, UserModel>()
        snapshot.appendSections([.user])
        snapshot.appendItems(items)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

private extension UsersListViewController {
    
    // MARK: - Show Logout Button
    func showLogoutButton() {
        let barButton = UIBarButtonItem(title: Constant.LogoutButton, style: .plain, target: self, action: #selector(didTapLogout))
        navigationItem.leftBarButtonItem = barButton
    }
    
    @objc func didTapLogout() {
        TokenManager.shared.clearToken()
        NavigationRouter.shared.showLoginScreen()
    }
    
    // MARK: - Fetch Users
    func fetchUsers() {
        guard NetworkMonitor.shared.isConnected else {
            showAlert(with: Constant.NetworkStatusOffline)
            return
        }
        
        guard !isLoading else { return }
        
        isLoading = true
        showLoader()
        
        Task {
            let hasResult: Bool = await userListViewModel.fetchUsers()
            
            isLoading = false
            hideLoader()
            
            if hasResult {
                applySnapshot(items: userListViewModel.users)
            } else {
                showErrorLabel(with: Constant.NoUsersAvailable)
            }
        }
    }
    
    // MARK: - Search Users
    func searchUsers(with query: String) {
        if query.isEmpty {
            isSearching = false
            applySnapshot(items: userListViewModel.users)
        } else {
            guard NetworkMonitor.shared.isConnected else {
                showAlert(with: Constant.NetworkStatusOffline)
                return
            }
            applySnapshot(items: [])
            isSearching = true
            showLoader()
            
            Task {
                await userListViewModel.searchUsers(with: query)
                
                hideLoader()
                applySnapshot(items: userListViewModel.searchedUsers)
                
                if userListViewModel.searchedUsers.isEmpty {
                    showErrorLabel(with: Constant.NoUsersFound)
                } else {
                    hideErrorLabel()
                }
            }
        }
    }
    
    func applySearch(with query: String) {
        searchWorkItem?.cancel()
        
        let requestWorkItem = DispatchWorkItem { [weak self] in
            guard let self = self else { return }
            self.searchUsers(with: query)
        }
        
        searchWorkItem = requestWorkItem
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: requestWorkItem)
    }
    
    // MARK: - Navigate to Detail Screen
    func showDetailScreen(model: UserModel) {
        let networkService = NetworkManager(token: TokenManager.shared.token)
        let userDetailViewModel = UserDetailViewModel(
            networkService: networkService,
            id: model.login
        )
        let userDetailVC = UserDetailViewController(with: userDetailViewModel)
        push(userDetailVC)
    }
}

// MARK: - Search TextField Delegate Methods
extension UsersListViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let searchText = textField.text, searchText.count < 3 {
            return false
        }
        applySearch(with: textField.nonEmptyText)
        textField.resignFirstResponder()
        return true
    }
    
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        if string.isEmpty { return true }
        
        // Regex: Accepts only letters and numbers
        let allowedCharacters = CharacterSet.alphanumerics
        return string.rangeOfCharacter(from: allowedCharacters.inverted) == nil
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        applySearch(with: textField.nonEmptyText)
    }
}

// MARK: - CollectionView Pagination and Delegate Methods
extension UsersListViewController: UICollectionViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isSearching { return }
        
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        // Trigger pagination when the user scrolls near the bottom
        if offsetY > contentHeight - height {
            userListViewModel.updateNextPage()
            fetchUsers()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let users = isSearching ? userListViewModel.searchedUsers : userListViewModel.users
        guard let userModel = users[safe: indexPath.item] else { return }
        
        searchTextField.resignFirstResponder()
        showDetailScreen(model: userModel)
    }
}
