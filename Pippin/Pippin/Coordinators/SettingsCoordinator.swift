//
//  SettingsCoordinator.swift
//  Pippin
//
//  Created by Will Brandin on 4/18/19.
//  Copyright © 2019 SchoolConnect. All rights reserved.
//

import UIKit

final class SettingsCoordinator: NavigationFlowCoordinator, TabCoordinatable {
    
    // MARK: - Properties
    
    var tabBarItem: UITabBarItem {
        return UITabBarItem(title: "Settings", image: #imageLiteral(resourceName: "settings"), tag: 0)
    }
    
    var tabNavigationController: UIViewController? {
        return mainViewController?.navigationController
    }
    
    private var settingsViewController: SettingsViewControllerProtocol?
    
    // MARK: - Methods
    
    override func createMainViewController() -> UIViewController? {
        return createSettingsViewController()
    }
    
    // MARK: - Private Methods
    
    private func createSettingsViewController() -> UIViewController? {
        settingsViewController = SettingsViewController()
        
        settingsViewController?.onSelected = { [weak self] option in
            self?.handleSelected(option)
        }
        
        guard let controller = settingsViewController?.toPresent() else { return nil }
        controller.tabBarItem = tabBarItem
        return controller
    }
    
    private func handleSelected(_ settingsOption: SettingsOption) {
        switch settingsOption {
        case .logout:
            handleLogout()
        }
    }
    
    private func handleLogout() {
        NotificationCenter.default.post(name: .logout, object: nil)
    }
}
