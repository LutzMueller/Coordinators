//
//  SignupCoordinator.swift
//  coordinators
//
//  Created by Lutz Müller on 02.01.17.
//  Copyright © 2017 Cubinea. All rights reserved.
//

import UIKit

/// Constants for this coordinator.
private enum Constants {
    static let signupViewControllerName = "SignupViewController"
}

/// Delegate for result of sign process.
protocol SignupCoordinatorDelegate: class {
    
    /// Called, when user canceled signup.
    ///
    /// - parameter sender: The sender
    func cancel(sender: SignupCoordinator)
}

/// This class handles the signup process.
final class SignupCoordinator: NSObject {

    weak var delegate: SignupCoordinatorDelegate?
    var viewController: UIViewController?
    
    let presentationController: PresentationController
    
    /// Initializer for this coordinator.
    ///
    /// - parameter presentationController: The presentation controller
    init(presentationController: PresentationController) {
        self.presentationController = presentationController
    }
    
    deinit {
        presentationController.dismiss(viewController!)
        NSLog("SignupCoordinator deinit")
    }
    
    /// Starts the signup workflow.
    func start() {
        presentSignupView()
    }
    
    private func presentSignupView() {
        let storyboard = UIStoryboard(name: Constants.signupViewControllerName)
        guard let signupViewController = storyboard.instantiateInitialViewController() as? SignupViewController else {
            fatalError("Could not instantiate SignupViewController from Storyboard")
        }
        viewController = signupViewController
        
        signupViewController.delegate = self
        presentationController.presentModally(viewController: signupViewController)
    }
    
}

extension SignupCoordinator: SignupViewControllerDelegate {

    func canelButtonPressed(sender: SignupViewController) {
        delegate?.cancel(sender: self)
    }
    
}
