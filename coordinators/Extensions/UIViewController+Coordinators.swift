//
//  UIViewController+Coordinators.swift
//  coordinators
//
//  Created by Lutz Müller on 02.01.17.
//  Copyright © 2017 Cubinea. All rights reserved.
//

import UIKit

private enum Constants {
    static let defaultButtonTitle = "OK"
}

extension UIViewController {

    /// Convenience method which dismisses the keyboard.
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    /// Shows an alert with an `OK` button.
    ///
    /// - parameter title: The title
    /// - parameter message: The message
    /// - parameter buttonTitle: The title of the button
    func showAlert(title: String, message: String, buttonTitle: String = Constants.defaultButtonTitle) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: nil))
        present(alert, animated: true)
    }
    
}
