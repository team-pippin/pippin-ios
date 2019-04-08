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
    
    private var signUpViewController: SignUpViewControllerProtocol?
    
    // MARK: - Methods
    
    override func createMainViewController() -> UIViewController? {
        return showSignUpViewController()
    }
    
    // MARK: - Private Methods
    
    private func showSignUpViewController() -> UIViewController? {
        signUpViewController = SignUpViewController()
        signUpViewController?.onSignUpSuccessful = {
            print("SIGNED UP")
        }
        return signUpViewController?.toPresent()
    }
    
    private func showSchoolSearchViewController() {
        
    }
    
    private func showSchoolConfirmationViewController() {
        
    }
}

