//
//  UIViewController+Ext.swift
//  GithubUsers
//
//  Created by Vikas Kumar on 03/07/25.
//

import UIKit

// MARK: - NavigationBar Extension Methods
extension UIViewController {
    
    /// This method shows customised navigation bar
    /// - Parameters:
    ///   - showBack: show back button if `true`
    ///   - canReload: show reload button if `true`
    func setupNavigationBar(showBack: Bool = false, canReload: Bool = false) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = AppColor.background

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance

        // Apply shadow to navigation bar
        if let navigationBar = navigationController?.navigationBar {
            navigationBar.applyShadow(
                radius: 4,
                opacity: 0.1,
                color: .black,
                offset: .init(width: 0, height: 2)
            )
        }
        
        if showBack { showBackButton() }
        
        if canReload { showReloadButton() }
    }
    
    func showBackButton() {
        let backButton = UIBarButtonItem(image: UIImage(systemName: "arrow.backward"), style: .plain, target: self, action: #selector(backTapped))
        navigationItem.leftBarButtonItem = backButton
    }
    
    func showReloadButton() {
        let reloadButton = UIBarButtonItem(image: UIImage(systemName: "arrow.counterclockwise"), style: .plain, target: self, action: #selector(reloadTapped))
        navigationItem.rightBarButtonItem = reloadButton
    }
    
    @objc func backTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func reloadTapped() { }
    
    func push(_ vc: UIViewController, animated: Bool = true) {
        navigationController?.pushViewController(vc, animated: animated)
    }
}
