//
//  ImageCache.swift
//  GithubUsers
//
//  Created by Vikas Kumar on 01/07/25.
//

import UIKit

/// This class handles caching mechanism for images fetched from network resource
final class ImageCache {
    
    static let shared = ImageCache()
    private init() {}
    
    private var imageCache = NSCache<NSString, UIImage>()
    
    /// This method fetch image from cache memory
    /// - Parameter url: parameter for cached image key
    /// - Returns: image from cache memory
    func getImage(for url: String) -> Any? {
        return imageCache.object(forKey: url as NSString)
    }
    
    /// This method save image into cache memory
    /// - Parameters:
    ///   - image: image for cache memory
    ///   - url: parameter for cached image key
    func setImage(_ image: Any, for url: String) {
        if let uiImage = image as? UIImage {
            imageCache.setObject(uiImage, forKey: url as NSString)
        }
    }
}
