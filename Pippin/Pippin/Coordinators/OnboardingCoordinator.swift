//
//  OnboardingCoordinator.swift
//  Pippin
//
//  Created by Will Brandin on 4/1/19.
//  Copyright © 2019 SchoolConnect. All rights reserved.
//

import UIKit

final class OnboardingCoordinator: NavigationFlowCoordinator {
    
    // MARK: - Properties
    
    // MARK: - Methods
    
    override func createMainViewController() -> UIViewController? {
        return showSignUpViewController()
    }
    
    // MARK: - Private Methods
    
    private func showSignUpViewController() -> UIViewController? {
        return UIViewController()
    }
    
    private func showSchoolSearchViewController() {
        
    }
    
    private func showSchoolConfirmationViewController() {
        
    }
}

