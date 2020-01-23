//
//  HomeCoordinator.swift
//  Pippin
//
//  Created by Will Brandin on 4/14/19.
//  Copyright © 2019 SchoolConnect. All rights reserved.
//

import UIKit

final class HomeCoordinator: NavigationFlowCoordinator, TabCoordinatable {
    
    // MARK: - Properties
    
    var tabBarItem: UITabBarItem {
        return UITabBarItem(title: "Home", image: #imageLiteral(resourceName: "home"), tag: 0)
    }
    
    var tabNavigationController: UIViewController? {
        return mainViewController?.navigationController
    }
    
    private var homeViewController: HomeViewControllerProtocol?
    
    // MARK: - Methods
    
    override func createMainViewController() -> UIViewController? {
        return createHomeViewController()
    }
    
    // MARK: - Private Methods
    
    private func createHomeViewController() -> UIViewController? {
        guard let viewModel = HomeViewModel() else {
            print("Could not initialize HomeViewModel")
            return nil
        }
        
        homeViewController = HomeViewController(viewModel: viewModel)
        guard let controller = homeViewController?.toPresent() else { return nil }
        controller.tabBarItem = tabBarItem
        return controller
    }
}
