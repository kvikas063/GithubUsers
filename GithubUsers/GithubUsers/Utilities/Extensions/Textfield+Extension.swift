//
//  Textfield+Extension.swift
//  GithubUsers
//
//  Created by Vikas Kumar on 02/07/25.
//

import UIKit

// MARK: - TextField Extension Methods
extension UITextField {
    
    /// Add `Done` button on keyboard toolbar to dismiss keyboard
    func addDoneButtonOnKeyboard() {
        guard inputAccessoryView == nil else { return }
        
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 45))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
    
    @objc func dismissAction() {
        self.resignFirstResponder()
    }
}

extension UITextField {
    /// Returns non-nil text
    var nonEmptyText: String {
        text ?? ""
    }
}
