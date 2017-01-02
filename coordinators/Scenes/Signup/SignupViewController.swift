//
//  SignupViewController.swift
//  coordinators
//
//  Created by Lutz Müller on 02.01.17.
//  Copyright © 2017 Cubinea. All rights reserved.
//

import UIKit

/// This delegate propagates all user interactions to the corresponding coordinator, which lead to another step in the app workflow.
/// User interactions which just have a local impact are only handled inside this view controller.
protocol SignupViewControllerDelegate: class {
    
    /// Called, when the user presssed the cancel button.
    ///
    /// - parameter sender: The sender
    func canelButtonPressed(sender: SignupViewController)
}

final class SignupViewController: UIViewController {

    weak var delegate: SignupViewControllerDelegate?
    
    deinit {
        NSLog("SignupViewController deinit")
    }
    
    // MARK: - User Interaction
    
    @IBAction func cancelTapped(_ sender: Any) {
        delegate?.canelButtonPressed(sender: self)
    }

}
