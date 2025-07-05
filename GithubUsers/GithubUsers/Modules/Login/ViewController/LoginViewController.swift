//
//  LoginViewController.swift
//  GithubUsers
//
//  Created by Vikas Kumar on 02/07/25.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - Private UI Properties
    private let titleLabel: UILabel = {
        let label           = UILabel()
        label.text          = Constant.WelcomeTitle
        label.font          = AppFont.WelcomeTitle
        label.textAlignment = .center
        return label
    }()
    
    private let loginButton: UIButton = {
        var configuration                 = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = AppColor.systemBlue
        configuration.baseForegroundColor = AppColor.white
        
        var attributedTitle               = AttributedString(Constant.TokenButtonTitle)
        attributedTitle.font              = AppFont.MainLabel
        configuration.attributedTitle     = attributedTitle
        
        let button = UIButton(configuration: configuration)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let guestButton: UIButton = {
        var configuration                 = UIButton.Configuration.plain()
        configuration.baseForegroundColor = AppColor.systemBlue
        configuration.title               = Constant.GuestButtonTitle
                
        let button = UIButton(configuration: configuration)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColor.background
        setupUI()
        addVersionLabel()
        addButtonTarget()
    }
    
    // MARK: - Setup UI Methods
    private func setupUI() {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, loginButton, guestButton])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.setCustomSpacing(240, after: titleLabel)
        
        let parentStackView = UIStackView(arrangedSubviews: [stackView])
        parentStackView.axis = .horizontal
        parentStackView.alignment = .center
        parentStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(parentStackView)
        
        NSLayoutConstraint.activate([
            parentStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            parentStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            parentStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            parentStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80),
            
            loginButton.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    func addVersionLabel() {
        let label           = UILabel()
        label.text          = Constant.AppVersion
        label.font          = AppFont.NormalLabel
        label.textColor     = AppColor.secondaryLabel
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func addButtonTarget() {
        loginButton.addTarget(self, action: #selector(didLoginButtonTap), for: .touchUpInside)
        guestButton.addTarget(self, action: #selector(didGuestButtonTap), for: .touchUpInside)
    }
    
    // MARK: - Action Methods
    @objc func didLoginButtonTap() {
        showLoader()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.hideLoader()
            if NetworkMonitor.shared.isConnected {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    TokenManager.shared.updateToken(with: Constant.Token)
                    NavigationRouter.shared.showUsersScreen()
                }
            } else {
                self.showAlert(with: Constant.NetworkStatusOffline)
            }
        }
    }
    
    @objc func didGuestButtonTap() {
        TokenManager.shared.updateToken(with: nil)
        NavigationRouter.shared.showUsersScreen()
    }
}
