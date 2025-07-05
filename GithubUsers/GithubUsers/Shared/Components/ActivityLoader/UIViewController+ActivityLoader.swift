//
//  UIViewController+ActivityLoader.swift
//  GithubUsers
//
//  Created by Vikas Kumar on 02/07/25.
//

import UIKit

// MARK: - Activity Indicator Extension
extension UIViewController {
    
    // Private Tag for Loading Indicator
    fileprivate struct ActivityTag {
        static let Indicator     = 1111
        static let BackView      = 2222
        static let ContainerView = 3333
    }
    
    /// This method shows a medium style activity indicator on center of screen
    func showLoader() {
        // Create the activity indicator
        let activityIndicator: UIActivityIndicatorView = .init(frame: .zero)
        activityIndicator.tag                          = ActivityTag.Indicator
        activityIndicator.style                        = .medium
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        let backView = UIView(frame: .zero)
        backView.tag = ActivityTag.BackView
        backView.alpha = 0
        backView.backgroundColor = .black.withAlphaComponent(0.3)
        backView.translatesAutoresizingMaskIntoConstraints = false
        
        // Create a container view
        let containerView: UIView     = .init(frame: .zero)
        containerView.tag             = ActivityTag.ContainerView
        containerView.backgroundColor = AppColor.background
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        backView.addSubview(containerView)
        
        // Add the activity indicator to the container
        containerView.addSubview(activityIndicator)
        
        // Apply Corner radius and shadow to the container
        containerView.applyRoundedCorner(of: 8)
        
        // Set up constraints for the activity indicator
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
        
        // Add the container view to the presenting controller
        view.addSubview(backView)
        view.bringSubviewToFront(backView)
        
        // Set up constraints for the container view
        NSLayoutConstraint.activate([
            containerView.widthAnchor.constraint(equalToConstant: 60),
            containerView.heightAnchor.constraint(equalToConstant: 60),
            
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            backView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backView.topAnchor.constraint(equalTo: view.topAnchor),
            backView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        UIView.animate(withDuration: 0.3) {
            backView.alpha = 1.0
            activityIndicator.startAnimating()
        }
    }
    
    /// This method hides and removes activity indicator from screen
    func hideLoader() {
        if let containerView = view.viewWithTag(ActivityTag.BackView) {
            if let indicatorView = view.viewWithTag(ActivityTag.Indicator) as? UIActivityIndicatorView {
                indicatorView.stopAnimating()
            }
            containerView.removeFromSuperview()
        }
    }
}
