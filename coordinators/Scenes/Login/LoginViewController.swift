//
//  LoginViewController.swift
//  coordinators
//
//  Created by Lutz Müller on 02.01.17.
//  Copyright © 2017 Cubinea. All rights reserved.
//

import UIKit

/// This delegate propagates all user interactions to the corresponding coordinator, which leads to another step in the app workflow.
/// User interactions which just have a local impact are only handled inside this view controller.
protocol LoginViewControllerDelegate: class {
    
    /// Called, when the user presssed the login button.
    ///
    /// - parameter loginViewModel: The login view model containing an email address and a password
    /// - parameter sender: The sender
    func loginButtonPressed(loginViewModel: LoginViewModel, sender: LoginViewController)
    
    /// Called, when user pressed signup button.
    ///
    /// - parameter sender: The sender
    func signupButtonPressed(sender: LoginViewController)
}

/// This controller shows a login view. 
final class LoginViewController: UIViewController {

    /// The view model
    var loginViewModel = LoginViewModel()

    weak var delegate: LoginViewControllerDelegate?
   
    
    // MARK: - Outlets
    
    @IBOutlet weak var emailTextField: UITextField! {
        didSet {
            emailTextField.addTarget(self, action: #selector(LoginViewController.textFieldChanged(sender:)), for: .editingChanged)
        }
    }

    @IBOutlet weak var passwordTextField: UITextField! {
        didSet {
            passwordTextField.addTarget(self, action: #selector(LoginViewController.textFieldChanged(sender:)), for: .editingChanged)
        }
    }
    
    @IBOutlet weak var loginButton: UIButton!
    
    deinit {
        NSLog("LoginViewController deinit")
    }
    
    // MARK: - Actions
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        dismissKeyboard()

        delegate?.loginButtonPressed(loginViewModel: loginViewModel, sender: self)
    }
    
    @IBAction func signupButtonTapped(_ sender: Any) {
        dismissKeyboard()
        
        delegate?.signupButtonPressed(sender: self)
    }
    
    // MARK: - Public
    
    func showLoginFailed() {
        emailTextField.text = ""
        passwordTextField.text = ""
        
        loginViewModel = LoginViewModel()
        loginButton.isEnabled = loginViewModel.isValid()
        
        showLoginErrorAlert()
    }

    // MARK - Private
    
    private func showLoginErrorAlert() {
        self.showAlert(title: "Error", message: "Oops, Login failed!")
    }
    
    @objc private func textFieldChanged(sender: UITextField) {
        if sender === emailTextField {
            loginViewModel.emailAddress = emailTextField.text ?? ""
        } else if sender === passwordTextField {
            loginViewModel.password = passwordTextField.text ?? ""
        }
        
        loginButton.isEnabled = loginViewModel.isValid()
    }
    
}
