//
//  ApplicationCoordinator.swift
//  Pippin
//
//  Created by Will Brandin on 4/1/19.
//  Copyright © 2019 SchoolConnect. All rights reserved.
//

import UIKit

final class ApplicationCoordinator: NavigationFlowCoordinator {
    
    override func createMainViewController() -> UIViewController? {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .red
        return viewController
    }
    
}
