//
//  TabBarCoordinator.swift
//  Pippin
//
//  Created by Will Brandin on 4/1/19.
//  Copyright © 2019 SchoolConnect. All rights reserved.
//

import UIKit

final class TabBarCoordinator: NavigationFlowCoordinator {
    
    // MARK: - Properties
    
    private var tabBarController = UITabBarController()
    private var homeCoordinator = HomeCoordinator()
    private var settingsCoordinator = SettingsCoordinator()
    
    // MARK: - Methods
    
    override func createMainViewController() -> UIViewController? {
        setupCoordinators()
        return tabBarController
    }
    
    // MARK: - Private Methods
    
    private func setupCoordinators() {
        setupHomeCoordinator()
        setupSettingsCoordinator()
    }
    
    private func setupHomeCoordinator() {
        homeCoordinator.start()
        guard let controller = homeCoordinator.tabNavigationController else { return }
        tabBarController.viewControllers = [controller]
    }
    
    private func setupSettingsCoordinator() {
        settingsCoordinator.start()
        guard let controller = settingsCoordinator.tabNavigationController else { return }
        tabBarController.viewControllers?.append(controller)
    }
}
