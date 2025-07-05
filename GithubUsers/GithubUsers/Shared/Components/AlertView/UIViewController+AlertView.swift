//
//  UIViewController+AlertView.swift
//  GithubUsers
//
//  Created by Vikas Kumar on 04/07/25.
//

import UIKit

// MARK: - AlertView Extension
extension UIViewController {
    
    /// This method show alert with default dismiss button `OK`
    /// - Parameter message: parameter to show alert message
    func showAlert(with message: String) {
        showAlert(with: message) {}
    }
    
    /// This method show alert with default dismiss button `OK`
    /// - Parameters:
    ///   - message: parameter to show alert message
    ///   - onDismiss: callback event after alert is dismissed from screen
    func showAlert(with message: String, onDismiss: @escaping () -> Void) {
        let alert = UIAlertController(
            title: Constant.AlertTitleText,
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: Constant.DismissButtonText, style: .default, handler: { _ in
            onDismiss()
        }))
        self.present(alert, animated: true)
    }
}
