//
//  DashboardCoordinator.swift
//  coordinators
//
//  Created by Lutz Müller on 02.01.17.
//  Copyright © 2017 Cubinea. All rights reserved.
//

import UIKit

/// Constants for this coordinator.
private enum Constants {
    static let dashboardViewControllerName = "DashboardViewController"
}

/// Handles the app flow for the dashboard. This is the default start screen of the app, when the user is logged in.
final class DashboardCoordinator: NSObject {

    let presentationController: PresentationController
    
    /// Initializer for this coordinator.
    ///
    /// - parameter presentationController: The presentation controller
    init(presentationController: PresentationController) {
        self.presentationController = presentationController
    }
    
    deinit {
        NSLog("DashboardCoordinator deinit")
    }
    
    /// Starts the dashboard workflow.
    func start() {
        presentDashboardView()
    }

    private func presentDashboardView() {
        let storyboard = UIStoryboard(name: Constants.dashboardViewControllerName)
        guard let viewController = storyboard.instantiateInitialViewController() as? DashboardViewController else {
            fatalError("Could not instantiate DashboardViewController from Storyboard")
        }
        
        presentationController.presentDefaultNavigation(withViewController: viewController)
    }
    
}
