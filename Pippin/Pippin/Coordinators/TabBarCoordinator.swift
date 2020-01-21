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
    private var newsCoordinator = NewsCoordinator()
    private var eventsCoordinator = EventsCoordinator()
    private var settingsCoordinator = SettingsCoordinator()
    
    // MARK: - Methods
    
    override func createMainViewController() -> UIViewController? {
        setupCoordinators()
        return tabBarController
    }
    
    // MARK: - Private Methods
    
    private func setupCoordinators() {
        setupHomeCoordinator()
        setupNewsCoordinator()
        setupEventsCoordinator()
        setupSettingsCoordinator()
    }
    
    private func setupHomeCoordinator() {
        homeCoordinator.start()
        guard let controller = homeCoordinator.tabNavigationController else { return }
        tabBarController.viewControllers = [controller]
    }
    
    private func setupNewsCoordinator() {
        newsCoordinator.start()
        guard let controller = newsCoordinator.tabNavigationController else { return }
        tabBarController.viewControllers?.append(controller)
    }
    
    private func setupEventsCoordinator() {
        eventsCoordinator.start()
        guard let controller = eventsCoordinator.tabNavigationController else { return }
        tabBarController.viewControllers?.append(controller)
    }
    
    private func setupSettingsCoordinator() {
        settingsCoordinator.start()
        guard let controller = settingsCoordinator.tabNavigationController else { return }
        tabBarController.viewControllers?.append(controller)
    }
}
