//
//  UIViewController+ErrorLabel.swift
//  GithubUsers
//
//  Created by Vikas Kumar on 02/07/25.
//

import UIKit

// MARK: - Error Label Extenstion
extension UIViewController {
    
    // Private Tag for Loading Indicator
    fileprivate struct ErrorTag {
        static let ErrorLabel = 4444
    }
    
    /// This method shows a error message label on center of screen
    func showErrorLabel(with text: String) {
        let errorLabel           = UILabel()
        errorLabel.text          = text
        errorLabel.textAlignment = .center
        errorLabel.numberOfLines = 0
        errorLabel.font          = .boldSystemFont(ofSize: 17)
        errorLabel.tag           = ErrorTag.ErrorLabel
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(errorLabel)
        view.bringSubviewToFront(errorLabel)
        
        // Setup constraints for the error label
        NSLayoutConstraint.activate([
            errorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            errorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            
            errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    /// This method hides and removes error label from screen
    func hideErrorLabel() {
        if let errorLabel = view.viewWithTag(ErrorTag.ErrorLabel) {
            errorLabel.removeFromSuperview()
        }
    }
}
