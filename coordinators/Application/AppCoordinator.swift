//
//  AppCoordinator.swift
//  coordinators
//
//  Created by Lutz Müller on 31.12.16.
//  Copyright © 2016 Cubinea. All rights reserved.
//

import UIKit

/// The AppCoordinator is the top most coordinator that is in charge of initializing and directing to child coordinators.
final class AppCoordinator: NSObject {
    
    let presentationController: PresentationController
    let childCoordinators: NSMutableArray
    
    // MARK: Init
    
    init(presentationController: PresentationController) {
        self.childCoordinators = NSMutableArray()
        
        self.presentationController = presentationController
    }
    
    deinit {
        NSLog("AppCoordinator deinit")
    }
    
    // MARK: Public
    
    /// Starts the coordinator.
    func start() {
        // In this example we need to verify if a user exists. This is done by a backend request. During the request we need to have a kind of a loading view.
        // The InitCoordinator shows a loading view and handles the backend request.
        // The init view is always the top most view, when the app starts.
        let initCoordinator = InitCoordinator(presentationController: presentationController)
        initCoordinator.delegate = self
        
        // We should assume that every coordinator may eventually maintain an array of child coordinators, which allows us to nest them and ensure that everything stays retained as long as it needs to be.
        childCoordinators.add(initCoordinator)
        initCoordinator.start()
    }
    
    fileprivate func presentDashboard() {
        let dashboardCoordinator = DashboardCoordinator(presentationController: presentationController)
        childCoordinators.add(dashboardCoordinator)
        dashboardCoordinator.start()
    }
    
    fileprivate func presentLogin() {
        let loginCoordinator = LoginCoordinator(presentationController: presentationController)
        loginCoordinator.delegate = self
        childCoordinators.add(loginCoordinator)
        loginCoordinator.start()
    }
    
    fileprivate func presentSignup() {
        let signupCoordinator = SignupCoordinator(presentationController: presentationController)
        signupCoordinator.delegate = self
        childCoordinators.add(signupCoordinator)
        signupCoordinator.start()
    }
    
}

extension AppCoordinator: InitCoordinatorDelegate {
    
    func userExists(sender: InitCoordinator) {
        // We do not need this child coordinator anymore
        childCoordinators.remove(sender)
        
        presentDashboard()
    }

    func userNotFound(sender: InitCoordinator) {
        // We do not need this child coordinator anymore
        childCoordinators.remove(sender)
        
        // show signup/login
        presentLogin()
    }
    
}

extension AppCoordinator: LoginCoordinatorDelegate {

    func loginSuccessful(sender: LoginCoordinator) {
        // We do not need this child coordinator anymore
        childCoordinators.remove(sender)
        
        presentDashboard()
    }

    func signupRequested(sender: LoginCoordinator) {
        // We keep the login coordinator in case the user wants to return via back navigation
        
        // start signup
        presentSignup()
    }
    
}

extension AppCoordinator: SignupCoordinatorDelegate {
    
    func cancel(sender: SignupCoordinator) {
        // We do not need this child coordinator anymore
        childCoordinators.remove(sender)

        // Closing the view controller of the SignupCoordinator is done inside SignupCoordinator.
    }
    
}
