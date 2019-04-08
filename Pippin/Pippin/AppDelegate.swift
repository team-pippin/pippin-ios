//
//  AppDelegate.swift
//  Pippin
//
//  Created by Will Brandin on 3/29/19.
//  Copyright © 2019 SchoolConnect. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var applicationCoordinator: ApplicationCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        configureNetworkEnvironment()
        styleNavigationBar()
        
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        
        applicationCoordinator = ApplicationCoordinator()
        applicationCoordinator?.start(with: .push, animated: false)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = applicationCoordinator?.navigationController
        window?.makeKeyAndVisible()
        
        return true
    }
}
