//
//  String+Coordinators.swift
//  coordinators
//
//  Created by Lutz Müller on 02.01.17.
//  Copyright © 2017 Cubinea. All rights reserved.
//

import Foundation

extension String {
    
    /// Returns `true`, if the string is a valid email address, otherwise `false`.
    ///
    /// - returns: `True`, if the string is a valid email address, otherwise `false`
    func isValidEmail() -> Bool {
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let test = NSPredicate(format:"SELF MATCHES %@", regEx)
        return test.evaluate(with: self)
    }
    
}
