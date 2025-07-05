//
//  NavigationRouter.swift
//  GithubUsers
//
//  Created by Vikas Kumar on 01/07/25.
//

import UIKit

/// This class handles app navigation
final class NavigationRouter {
    
    /// Singleton instance
    static let shared = NavigationRouter()
    private init() {}
    
    private var window: UIWindow?
    
    // MARK: - Navigation Methods
    
    /// This method set window to handle app navigation
    /// - Parameter window: app window parameter
    func setWindow(window: UIWindow?) {
        self.window = window
    }
    
    /// This method present view controller
    /// - Parameter vc: view controller parameter to present
    func present(_ vc: UIViewController) {
        guard let window else { return }
        window.rootViewController?.present(vc, animated: true)
    }
    
    /// This method update the root view controller of the app window
    /// - Parameter vc: set root view controller to app window
    func setWindowRoot(_ vc: UIViewController) {
        guard let window else { return }
        UIView.transition(
            with: window,
            duration: 0.3,
            options: .transitionCrossDissolve,
        ) {
            window.rootViewController = vc
            window.makeKeyAndVisible()
        }
    }
    
    /// This method makes `LoginViewController` as root view controller to app window
    func showLoginScreen() {
        let logicVC = LoginViewController()
        setWindowRoot(logicVC)
    }
    
    /// This method makes `UsersListViewController` as root view controller to app window
    func showUsersScreen() {
        let networkService = NetworkManager(token: TokenManager.shared.token)
        let userViewModel = UserListViewModel(networkService: networkService)
        let userListVC = UsersListViewController(with: userViewModel)
        let navigationVC = UINavigationController(rootViewController: userListVC)
        setWindowRoot(navigationVC)
    }
}
