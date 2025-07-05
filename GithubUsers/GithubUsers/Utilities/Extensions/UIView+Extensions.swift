//
//  UIView+Extensions.swift
//  GithubUsers
//
//  Created by Vikas Kumar on 01/07/25.
//

import UIKit

// MARK: - View Extension Methods
extension UIView {
    
    func applyRoundedCorner(of radius: CGFloat) {
        clipsToBounds = true
        layer.cornerRadius = radius
    }
    
    func applyBorder(width: CGFloat, color: UIColor) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
    }
    
    func topCornerRadius(of radius: CGFloat) {
        clipsToBounds = true
        layer.cornerRadius = radius
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    func applyShadow(
        radius: CGFloat = 3,
        opacity: Float = 0.3,
        color: UIColor = .black,
        offset: CGSize = .init(width: 0, height: 0)
    ) {
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.masksToBounds = false
    }
}

extension UIStackView {
    
    func addArrangeSub(views: [UIView]) {
        views.forEach { addArrangedSubview($0) }
    }
}
