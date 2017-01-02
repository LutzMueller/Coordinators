//
//  LoginCoordinator.swift
//  coordinators
//
//  Created by Lutz Müller on 02.01.17.
//  Copyright © 2017 Cubinea. All rights reserved.
//

import UIKit

/// Constants for this coordinator.
private enum Constants {
    static let loginViewControllerName = "LoginViewController"
}

/// Delegate for result of login process.
protocol LoginCoordinatorDelegate: class {
    
    /// Called, when login was successful.
    ///
    /// - parameter sender: The sender
    func loginSuccessful(sender: LoginCoordinator)
    
    /// Called, when user pressed signup button.
    ///
    /// - parameter sender: The sender
    func signupRequested(sender: LoginCoordinator)
}

/// This class handles the login procees. It also includes the handling of the signup.
final class LoginCoordinator: NSObject {

    weak var delegate: LoginCoordinatorDelegate?
    var loginViewController: LoginViewController?
    
    let presentationController: PresentationController
    
    // Helper variable to simulate the first login call as failed. The next call will be successful.
    var loginFailedOnce = false
    
    /// Initializer for this coordinator.
    ///
    /// - parameter presentationController: The presentation controller
    init(presentationController: PresentationController) {
        self.presentationController = presentationController
    }
    
    deinit {
        NSLog("LoginCoordinator deinit")
    }
    
    /// Starts the login workflow.
    func start() {
        presentLoginView()
    }

    private func presentLoginView() {
        let storyboard = UIStoryboard(name: Constants.loginViewControllerName)
        guard let viewController = storyboard.instantiateInitialViewController() as? LoginViewController else {
            fatalError("Could not instantiate LoginViewController from Storyboard")
        }
        
        viewController.delegate = self
        
        loginViewController = viewController

        presentationController.presentDefaultNavigation(withViewController: viewController)
    }
    
}

extension LoginCoordinator: LoginViewControllerDelegate {

    func loginButtonPressed(loginViewModel: LoginViewModel, sender: LoginViewController) {
        // Normally you would create a plain swift class `UserService` which fires the request (with given login details from login view model) and returns the result in a completion block.
        // Note: The class `UserService` should be a member of the coordinator, not the ViewController!
        // Then you would call f.e. the services method `loginUser`and call the delegates methods accordingly.
        
        // For simplicity we will call the delegates methods from here with a delay of 3 seconds to simulate a backend call.
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
            if self.loginFailedOnce {
                self.delegate?.loginSuccessful(sender: self)
            } else {
                self.loginViewController?.showLoginFailed()
                self.loginFailedOnce = true
            }
        })
    }

    func signupButtonPressed(sender: LoginViewController) {
        delegate?.signupRequested(sender: self)
    }
    
}
