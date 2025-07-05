//
//  ImageLoader.swift
//  GithubUsers
//
//  Created by Vikas Kumar on 01/07/25.
//

import UIKit

extension UIImageView {
    
    /// This method fetch image from external resource using network
    /// - Parameter urlString: image url parameter
    /// - Returns:`URLSessionDataTask` to handle discardable result
    @discardableResult
    func loadImage(
        from urlString: String,
        placeholder: String = Constant.Placeholder
    ) -> URLSessionDataTask? {
        
        self.image = UIImage(named: placeholder)
        
        guard let url = URL(string: urlString)
        else { return nil }
        
        if let image = ImageCache.shared.getImage(for: urlString) as? UIImage {
            self.image = image
            return nil
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            DispatchQueue.main.async {
                if let data = data,
                   let downloadedImage = UIImage(data: data)
                {
                    self?.animateImage(with: downloadedImage)
                    ImageCache.shared.setImage(downloadedImage, for: urlString)
                }
            }
        }
        task.resume()
        return task
    }
    
    /// This method animate and displays image in a image view.
    /// - Parameter image: parameter for image view
    func animateImage(with image: UIImage) {
        UIView.transition(
            with: self,
            duration: 0.2,
            options: .transitionCrossDissolve,
            animations: {
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        )
    }
}
