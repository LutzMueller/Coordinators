//
//  InitCoordinator.swift
//  coordinators
//
//  Created by Lutz Müller on 31.12.16.
//  Copyright © 2016 Cubinea. All rights reserved.
//

import UIKit

/// Constants for this coordinator.
private enum Constants {
    static let viewControllerName = "InitViewController"
}

/// Delegate for result of init request.
protocol InitCoordinatorDelegate: class {

    /// Called, when the user has been found.
    ///
    /// - parameter sender: The sender
    func userExists(sender: InitCoordinator)
    
    /// Called, when there is no user.
    ///
    /// - parameter sender: The sender
    func userNotFound(sender: InitCoordinator)
    
}

/// This class handles the initialization process. During initialization a loading view is shown.
final class InitCoordinator: NSObject {

    weak var delegate: InitCoordinatorDelegate?
    
    let presentationController: PresentationController
    
    /// Initializer for this coordinator.
    ///
    /// - parameter presentationController: The presentation controller
    init(presentationController: PresentationController) {
        self.presentationController = presentationController
    }
    
    deinit {
        NSLog("InitCoordinator deinit")
    }
    
    /// Starts the initialization workflow.
    func start() {
        presentView()
        
        requestUserInfo()
    }
    
    private func presentView() {
        let storyboard = UIStoryboard(name: Constants.viewControllerName)
        guard let viewController = storyboard.instantiateInitialViewController() as? InitViewController else {
            fatalError("Could not instantiate InitViewController from Storyboard")
        }

        presentationController.presentDefaultNavigation(withViewController: viewController)
    }
    
    private func requestUserInfo() {
        // Normally you would create a plain swift class `UserService` which fires the request and returns the result in a completion block.
        // Then you would call f.e. the services method `requestUser`and call the delegates methods accordingly.

        // For simplicity we will call the delegates methods from here with a delay of 3 seconds to simulate a backend call.
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
            if Bool.random() {
                self.delegate?.userExists(sender: self)
            } else {
                self.delegate?.userNotFound(sender: self)
            }
        })
    }
    
}
