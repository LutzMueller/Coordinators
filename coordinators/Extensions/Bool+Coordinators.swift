//
//  Bool+Coordinators.swift
//  coordinators
//
//  Created by Lutz Müller on 02.01.17.
//  Copyright © 2017 Cubinea. All rights reserved.
//

import Foundation

extension Bool {
    
    /// Returns a random bool value.
    ///
    /// - returns: A random bool value
    static func random() -> Bool {
        return arc4random_uniform(2) == 0
    }
    
}
