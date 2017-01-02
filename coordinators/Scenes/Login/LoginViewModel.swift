//
//  LoginViewModel.swift
//  coordinators
//
//  Created by Lutz Müller on 02.01.17.
//  Copyright © 2017 Cubinea. All rights reserved.
//

import Foundation

/// Login view model
struct LoginViewModel {
    
    var emailAddress = ""
    var password = ""
    
    /// Validates the login details
    ///
    /// - returns: `true`, if the login details are valid, otherwise `false`
    func isValid() -> Bool {
        guard !emailAddress.isEmpty && !password.isEmpty else {
            return false
        }
        
        return emailAddress.isValidEmail()
    }
    
}
