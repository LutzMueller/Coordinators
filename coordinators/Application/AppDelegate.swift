//
//  AppDelegate.swift
//  coordinators
//
//  Created by Lutz Müller on 31.12.16.
//  Copyright © 2016 Cubinea. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var presentationController: PresentationController?
    var appCoordinator: AppCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        presentationController = PresentationController(window: window!)
        
        appCoordinator = AppCoordinator(presentationController: presentationController!)
        appCoordinator?.start()
        
        return true
    }

}

