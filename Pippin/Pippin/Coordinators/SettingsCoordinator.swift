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
    private var accountSchoolViewController: AccountSchoolViewControllerProtocol?
    
    // MARK: - Methods
    
    override func createMainViewController() -> UIViewController? {
        return createSettingsViewController()
    }
    
    override func handle(flowEvent: FlowEvent) -> Bool {
        guard let event = flowEvent as? FlowEventType else { return false }
        
        switch event {
        case .didSubscribeToSchool:
            popToNavigationRoot()
            return true
            
        default:
            return false
        }
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
        case .schoolPicker:
            showSchoolPicker()
            
        case .logout:
            showLogoutAlert()
            
        case .accountInfo:
            print(UserDefaultsManager.currentAccount)
            
        default:
            break
        }
    }
    
    private func showSchoolPicker() {
        accountSchoolViewController = AccountSchoolViewController()
        
        accountSchoolViewController?.onDidSelectSchool = { [weak self] _ in
            self?.popToNavigationRoot()
        }
        
        accountSchoolViewController?.onTapAddNew = { [weak self] in
            self?.start(childCoordinator: SubscribeToSchoolCoordinator(), with: .push, animated: true)
        }
        
        guard let controller = accountSchoolViewController?.toPresent() else { return }
        push(viewController: controller)
    }
    
    private func showLogoutAlert() {
        let alert = UIAlertController(title: "Sign Out", message: "Are you sure you want to sign out of your account?", preferredStyle: .alert)

        let handler: (UIAlertAction) -> Void = { [weak self] _ in
            self?.handleLogout()
        }
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: handler))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))

        navigationController.topViewController?.present(alert, animated: true, completion: nil)
    }
    
    private func handleLogout() {
        NotificationCenter.default.post(name: .logout, object: nil)
    }
}
