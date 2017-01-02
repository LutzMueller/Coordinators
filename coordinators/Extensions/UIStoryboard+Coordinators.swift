//
//  UIStoryboard+Coordinators.swift
//  coordinators
//
//  Created by Lutz Müller on 31.12.16.
//  Copyright © 2016 Cubinea. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    /// Convenience initializer which omits the bundle name. Loads the storyboard from the main bundle.
    ///
    /// - parameter name: the storyboard name
    ///
    /// - returns: the new storyboard instance
    convenience init(name: String) {
        self.init(name: name, bundle: nil)
    }
    
}
