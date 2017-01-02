//
//  PresentationController.swift
//  coordinators
//
//  Created by Lutz Müller on 02.01.17.
//  Copyright © 2017 Cubinea. All rights reserved.
//

import UIKit

/// The presentation controller is responsible for presenting view controllers. This class handles HOW view controllers are presented.
class PresentationController: NSObject {

    let window: UIWindow
    
    lazy private var defaultNavigationController: UINavigationController = { [unowned self] in
        let navigationController = UINavigationController()
        return navigationController
    }()
    
    /// Initializer for this coordinator.
    ///
    /// - parameter window: The window
    init(window: UIWindow) {
        self.window = window
    }
    
    // MARK: - Public
    
    /// Presents a view controller with default navigation.
    ///
    /// - parameter viewController: a view controller
    func presentDefaultNavigation(withViewController viewController: UIViewController) {
        defaultNavigationController.viewControllers = [viewController]
        window.rootViewController = defaultNavigationController
    }
    
    /// Presents a view controller modally.
    ///
    /// - parameter viewController: a view controller
    func presentModally(viewController: UIViewController) {
        let modalNavigationController = UINavigationController()
        modalNavigationController.viewControllers = [viewController]
        
        let presentingViewController = viewControllerForModalPresentation()
        presentingViewController.present(modalNavigationController, animated: true)
    }
    
    /// Dismisses the given view controller. Finds the proper way of dimissing
    /// the view by doing the following steps in this order:
    ///
    /// 1. If the view controller is **part of a navigation stack** and if it is
    /// not the root view controller of the stack, it and all view controllers
    /// above it are popped off the stack.
    /// 2. If the view controller is being **presented**, his presenting view
    /// controller is asked to dismiss.
    ///
    /// Otherwise, the method does nothing.
    ///
    /// - parameter viewController: a view controller
    /// - parameter animated: If `true`, the dismissal is animated, otherwise `false`. Default is `true`.
    func dismiss(_ viewController: UIViewController, animated: Bool = true) {
        if let navigationController = viewController.navigationController, navigationController.viewControllers.first !== viewController {
            navigationController.popToViewController(viewController, animated: false)
            navigationController.popViewController(animated: animated)
        } else if let presentingViewController = viewController.presentingViewController {
            presentingViewController.dismiss(animated: animated)
        } else {
            assertionFailure("View controller cannot be dismissed")
        }
    }
    
    // MARK: - Private
    
    private func viewControllerForModalPresentation() -> UIViewController {
        return topMostPresentingViewController()
    }
    
    /// Finds the top-most view controller in the hierarchy of the main navigation controller which is currently presenting another view controller
    ///
    /// - returns: The found view controller or the main navigation controller
    private func topMostPresentingViewController() -> UIViewController {
        guard let topMost = window.rootViewController?.presentedViewController else {
            return window.rootViewController!
        }
        
        return topMost
    }
    
}
