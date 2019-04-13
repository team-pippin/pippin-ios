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
    private var signUpViewController: SignUpViewControllerProtocol?
    private var signInViewController: SignInViewControllerProtocol?
    
    // MARK: - Methods
    
    override func createMainViewController() -> UIViewController? {
        return createLandingViewController()
    }
    
    // MARK: - Private Methods
    
    private func createLandingViewController() -> UIViewController? {
        landingViewController = LandingViewController()
        landingViewController?.onDidTapSignUp = { [weak self] in
            self?.showSignUpViewController()
        }
        
        landingViewController?.onDidTapLogin = { [weak self] in
            self?.showLoginViewController()
        }
        
        return landingViewController?.toPresent()
    }
    
    private func showSignUpViewController() {
        signUpViewController = SignUpViewController()
        signUpViewController?.onSignUpSuccessful = { [weak self] in
            DispatchQueue.main.async {
                self?.startOnboardingCoordinator()
            }
        }
        
        if let controller = signUpViewController?.toPresent() {
            push(viewController: controller)
        }
    }
    
    private func showLoginViewController() {
        signInViewController = SignInViewController()
        signInViewController?.onSignInSuccessful = { [weak self] in
            self?.send(flowEvent: FlowEventType.didSignIn)
        }
        
        if let controller = signInViewController?.toPresent() {
            push(viewController: controller)
        }
    }
    
    private func startOnboardingCoordinator() {
        start(childCoordinator: SubscribeToSchoolCoordinator(), with: .push)
    }
}
