//
//  ApplicationCoordinator.swift
//  Pippin
//
//  Created by Will Brandin on 4/1/19.
//  Copyright © 2019 SchoolConnect. All rights reserved.
//

import UIKit

final class ApplicationCoordinator: NavigationFlowCoordinator {
    
    // MARK: - Methods
    
    override func createMainViewController() -> UIViewController? {
        determineRootCoordinator()
        return nil
    }
    
    // MARK: - Private Methods
    
    private func determineRootCoordinator() {
        if UserDefaultsManager.signedInUserToken != nil && UserDefaultsManager.selectedUserSchoolId != nil {
            startHomeCoordinator(animated: false)
        } else {
            startLandingCoordinator(animated: false)
        }
    }
    
    private func startLandingCoordinator(animated: Bool = true) {
        start(childCoordinator: LandingCoordinator(), with: .pushAndMakeRoot, animated: animated)
    }
    
    private func startHomeCoordinator(animated: Bool = true) {
        
    }
    
}
