//
//  AppDelegate+Configuration.swift
//  Pippin
//
//  Created by Will Brandin on 4/8/19.
//  Copyright © 2019 SchoolConnect. All rights reserved.
//

import UIKit

extension AppDelegate {
    
    // MARK: - Methods
    
    func configureNetworkEnvironment() {
        guard let buildModeString = Bundle.main.infoDictionary!["BUILD_ENVIRONMENT"] as? String,
            let buildMode = Int(buildModeString),
            let environment = NetworkEnvironment(rawValue: buildMode) else {
                print("Networking Layer could not be configured.")
                return
        }
        
        print("Network Environment: - \(environment.name)")
        configureNetworkManager(in: environment)
    }
    
    func styleNavigationBar() {
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.barTintColor = .white
        navBarAppearance.isTranslucent = false
        navBarAppearance.setBackgroundImage(UIImage(), for: .default)
        navBarAppearance.tintColor = Style.Color.primaryTextDark
        navBarAppearance.shadowImage = UIImage()
        navBarAppearance.titleTextAttributes = [NSAttributedString.Key.font: Style.Font.navigationTitle,
                                                NSAttributedString.Key.foregroundColor: Style.Color.primaryTextDark]
        let myImage = #imageLiteral(resourceName: "icon-back")
        let stretched = myImage.stretchableImage(withLeftCapWidth: Int(myImage.size.width - 1), topCapHeight: Int(myImage.size.height - 1))
        navBarAppearance.backIndicatorImage = stretched
        navBarAppearance.backIndicatorTransitionMaskImage = stretched
        
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffset(horizontal: -7000, vertical: 0), for: .default)
    }
    
    // MARK: - Private Methods
    
    private func configureNetworkManager(in environment: NetworkEnvironment) {
        NetworkManager.setEnvironment(for: environment)
    }
}
