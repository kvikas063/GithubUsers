//
//  UserDetailViewController.swift
//  GithubUsers
//
//  Created by Vikas Kumar on 02/07/25.
//

import UIKit

class UserDetailViewController: UIViewController {
    
    // MARK: - Private UI Properties
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<SectionType, Item>!
    
    // MARK: - Private Properties
    fileprivate enum SectionType: Int, CaseIterable {
        case userDetail
        case repoList
    }
    fileprivate enum Item: Hashable {
        case user(UserDetailModel)
        case repo(UserRepositoryModel)
    }
    
    private let userDetailViewModel: UserDetailViewModel
    
    // MARK: - Custom Init Method
    init(with viewModel: UserDetailViewModel) {
        userDetailViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Controller LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColor.background
        title = Constant.UserNavTitle + userDetailViewModel.userID
        setupNavigationBar(showBack: true)

        configureCollectionView()
        configureDataSource()
        
        fetchUserDetail()
    }
}

// MARK: - Private Setup UI Methods
private extension UserDetailViewController {
    
    // MARK: - Layout Methods
    func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.delegate = self
        collectionView.backgroundColor = AppColor.background
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(UserDetailCell.self, forCellWithReuseIdentifier: UserDetailCell.reuseID)
        collectionView.register(RepoListCell.self, forCellWithReuseIdentifier: RepoListCell.reuseID)
        
        collectionView.register(UICollectionReusableView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: "HeaderView")
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        let provider: UICollectionViewCompositionalLayoutSectionProvider = { [weak self] section, _ in
            guard let sectionType = SectionType(rawValue: section) else { return nil }
            return self?.layout(for: sectionType)
        }
        return UICollectionViewCompositionalLayout(sectionProvider: provider)
    }
    
    func layout(for section: SectionType) -> NSCollectionLayoutSection {
        switch section {
            case .userDetail:
                return userDetailLayout()
            case .repoList:
                return repoListLayout()
        }
    }
    
    func userDetailLayout() -> NSCollectionLayoutSection {
        // Item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .estimated(180))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // Group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .estimated(180))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 10, leading: 20, bottom: 10, trailing: 20)
        return section
    }
    
    func repoListLayout() -> NSCollectionLayoutSection {
        // Item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .estimated(100))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // Group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .estimated(100))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        // Header
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                heightDimension: .absolute(44))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [sectionHeader]
        section.contentInsets = .init(top: 10, leading: 20, bottom: 10, trailing: 20)
        return section
    }
    
    // MARK: - Data Source
    func configureDataSource() {
        configureCells()
        configureHeader()
    }
    
    func configureCells() {
        dataSource = UICollectionViewDiffableDataSource<SectionType, Item>(collectionView: collectionView) { collectionView, indexPath, model in
            switch model {
                case .user(let userDetail):
                    let cell: UserDetailCell = collectionView.dequeueReusableCell(withReuseIdentifier: UserDetailCell.reuseID, for: indexPath) as! UserDetailCell
                    cell.updateCell(
                        with: userDetail.avatarURL,
                        userName: userDetail.login,
                        fullName: userDetail.name ?? userDetail.login,
                        followers: userDetail.followers,
                        following: userDetail.following,
                        bio: userDetail.bio
                    )
                    return cell
                case .repo(let repo):
                    let cell: RepoListCell = collectionView.dequeueReusableCell(withReuseIdentifier: RepoListCell.reuseID, for: indexPath) as! RepoListCell
                    cell.updateCell(
                        with: repo.name,
                        language: repo.language,
                        stars: repo.stargazersCount,
                        description: repo.description
                    )
                    return cell
            }
        }
    }
    
    func configureHeader() {
        dataSource.supplementaryViewProvider = { (collectionView, kind, indexPath) in
            guard kind == UICollectionView.elementKindSectionHeader else { return nil }
            
            let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "HeaderView",
                for: indexPath
            )
            
            if headerView.subviews.isEmpty {
                let label = UILabel(frame: headerView.bounds)
                label.tag = 100
                label.font = UIFont.boldSystemFont(ofSize: 20)
                headerView.addSubview(label)
            }
            
            if let label = headerView.viewWithTag(100) as? UILabel {
                label.text = Constant.RepositoriesTitle
            }
            
            return headerView
        }
    }
    
    func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<SectionType, Item>()
        snapshot.appendSections(SectionType.allCases)
        
        if let detailModel = userDetailViewModel.userDetailModel {
            snapshot.appendItems([.user(detailModel)], toSection: .userDetail)
        }
        snapshot.appendItems(userDetailViewModel.userRepos.map { .repo($0) }, toSection: .repoList)
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

// MARK: - Private Helper Methods
extension UserDetailViewController {
    
    func fetchUserDetail() {
        guard NetworkMonitor.shared.isConnected else {
            showAlert(with: Constant.NetworkStatusOffline)
            return
        }
        showLoader()
        Task {
            await userDetailViewModel.fetchUserDetails()
            hideLoader()
            applySnapshot()
            
            if userDetailViewModel.userRepos.isEmpty {
                showErrorLabel(with: Constant.NoReposAvailable)
            }
        }
    }
    
    // MARK: - Navigate to WebView Screen
    func showWebViewScreen(with url: URL) {
        let webviewVC = WebViewController(with: url)
        push(webviewVC)
    }
}

// MARK: - CollectionView Delegate Methods
extension UserDetailViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let sectionType = SectionType(rawValue: indexPath.section),
              sectionType == .repoList else { return }
        
        guard let repoModel = userDetailViewModel.userRepos[safe: indexPath.item] else { return }
        guard let url = URL(string: repoModel.htmlURL) else { return }
        
        showWebViewScreen(with: url)
    }
}
