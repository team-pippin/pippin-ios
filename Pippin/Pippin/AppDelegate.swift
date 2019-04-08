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

    private func styleNavigationBar() {
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.barTintColor = .white
        navBarAppearance.isTranslucent = false
        navBarAppearance.setBackgroundImage(UIImage(), for: .default)
        navBarAppearance.tintColor = Style.Color.primaryTextDark
        navBarAppearance.shadowImage = UIImage()
        navBarAppearance.titleTextAttributes = [NSAttributedString.Key.font: Style.Font.navigationTitle, NSAttributedString.Key.foregroundColor: Style.Color.secondaryTextDark]
        let myImage = #imageLiteral(resourceName: "icon-back")
        let stretched = myImage.stretchableImage(withLeftCapWidth: Int(myImage.size.width - 1), topCapHeight: Int(myImage.size.height - 1))
        navBarAppearance.backIndicatorImage = stretched
        navBarAppearance.backIndicatorTransitionMaskImage = stretched
        
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffset(horizontal: -7000, vertical: 0), for: .default)
        
    }
}
