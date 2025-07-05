//
//  UICollectionView+Extensions.swift
//  GithubUsers
//
//  Created by Vikas Kumar on 01/07/25.
//

import UIKit

protocol Reusable {
    static var reuseID: String { get }
}

extension Reusable {
    static var reuseID: String {
        String(describing: self)
    }
}

// MARK: - CollectionView Extension Methods
extension UICollectionViewCell: Reusable {}

extension UICollectionView {
    /// Registers a `UICollectionViewCell` from a supplied type
    /// The identifier is used from the reuseIdentifier parameter
    /// - Parameter type: A generic cell type
    func register<Cell: UICollectionViewCell>(_ type: Cell.Type) {
        register(type, forCellWithReuseIdentifier: type.reuseID)
    }
    
    /// Dequeues a `UICollectionViewCell` cell with a generic type and indexPath
    /// - Parameters:
    ///   - type: A generic cell type
    ///   - indexPath: The indexPath of the row in the UITableView
    /// - Returns: A cell from the type passed through
    func dequeueReusableCell<Cell: UICollectionViewCell>(with type: Cell.Type, for indexPath: IndexPath, reuseIdentifier: String? = nil) -> Cell {
        dequeueReusableCell(withReuseIdentifier: reuseIdentifier ?? type.reuseID, for: indexPath) as! Cell
    }
}

extension Collection {
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
