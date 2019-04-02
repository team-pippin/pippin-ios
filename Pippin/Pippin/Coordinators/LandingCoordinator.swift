//
//  OnboardingCoordinator.swift
//  Pippin
//
//  Created by Will Brandin on 4/1/19.
//  Copyright © 2019 SchoolConnect. All rights reserved.
//

import UIKit

final class LandingCoordinator: NavigationFlowCoordinator {
    
    // MARK: - Properties
    
    private var landingViewController: LandingViewControllerProtocol?
    
    // MARK: - Methods
    
    override func createMainViewController() -> UIViewController? {
        return createLandingViewController()
    }
    
    // MARK: - Private Methods
    
    private func createLandingViewController() -> UIViewController? {
        landingViewController = LandingViewController()
        landingViewController?.onDidTapSignUp = { [weak self] in
            self?.startOnboardingCoordinator()
        }
        
        landingViewController?.onDidTapLogin = { [weak self] in
            self?.showLoginViewController()
        }
        
        return landingViewController?.toPresent()
    }
    
    private func showLoginViewController() {
        
    }
    
    private func startOnboardingCoordinator() {
        start(childCoordinator: OnboardingCoordinator(), with: .pushAndMakeRoot)
    }
}
