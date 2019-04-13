//
//  HomeCoordinator.swift
//  Pippin
//
//  Created by Will Brandin on 4/14/19.
//  Copyright © 2019 SchoolConnect. All rights reserved.
//

import UIKit

final class HomeCoordinator: NavigationFlowCoordinator {
    
    // MARK: - Properties
    
    // MARK: - Methods
    
    override func createMainViewController() -> UIViewController? {
        return createHomeViewController()
    }
    
    // MARK: - Private Methods
    
    private func createHomeViewController() -> UIViewController? {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .red
        return viewController
    }
}
