//
//  ApplicationCoordinator.swift
//  Pippin
//
//  Created by Will Brandin on 4/1/19.
//  Copyright © 2019 SchoolConnect. All rights reserved.
//

import UIKit

final class ApplicationCoordinator: NavigationFlowCoordinator {
    
    // MARK: - Init
    
    override init() {
        super.init()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleUnauthorized), name: .unauthorized, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleLogout), name: .logout, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .unauthorized, object: nil)
        NotificationCenter.default.removeObserver(self, name: .logout, object: nil)
    }
    
    // MARK: - Methods
    
    override func createMainViewController() -> UIViewController? {
        determineRootCoordinator(animated: false)
        return nil
    }
    
    override func handle(flowEvent: FlowEvent) -> Bool {
        guard let event = flowEvent as? FlowEventType else { return false }
        
        switch event {
        case .didSignIn:
            DispatchQueue.main.async { [weak self] in
                self?.determineRootCoordinator(animated: true)
            }
            
            return true
            
        case .didLogout:
            UserDefaultsManager.currentAccount = nil
            UserDefaultsManager.signedInAccountToken = nil
            determineRootCoordinator(animated: true)
            return true
            
        case .didSubscribeToSchool:
            DispatchQueue.main.async { [weak self] in
                self?.startHomeCoordinator()
            }
            
            return true
        }
    }
    
    // MARK: - Private Methods
    
    private func determineRootCoordinator(animated: Bool) {
        if UserDefaultsManager.signedInAccountToken != nil {
            if let account = UserDefaultsManager.currentAccount, !(account.roles?.isEmpty ?? true) {
                startHomeCoordinator(animated: animated)
            } else {
                startOnBoardingCoordinator(animated: animated)
            }
        } else {
            startLandingCoordinator(animated: animated)
        }
    }
    
    private func startLandingCoordinator(animated: Bool = true) {
        navigationController.setNavigationBarHidden(false, animated: false)
        start(childCoordinator: LandingCoordinator(), with: .pushAndMakeRoot, animated: animated)
    }
    
    private func startHomeCoordinator(animated: Bool = true) {
        navigationController.setNavigationBarHidden(true, animated: false)
        start(childCoordinator: TabBarCoordinator(), with: .pushAndMakeRoot, animated: animated)
    }
    
    private func startOnBoardingCoordinator(animated: Bool = true) {
        navigationController.setNavigationBarHidden(false, animated: false)
        start(childCoordinator: SubscribeToSchoolCoordinator(), with: .pushAndMakeRoot, animated: animated)
    }
    
    // MARK: - Notifications
    
    @objc private func handleUnauthorized() {
        DispatchQueue.main.async { [weak self] in
            UserDefaultsManager.clear()
            self?.startLandingCoordinator(animated: false)
        }
    }
    
    @objc private func handleLogout() {
        DispatchQueue.main.async { [weak self] in
            UserDefaultsManager.currentAccount = nil
            UserDefaultsManager.signedInAccountToken = nil
            self?.startLandingCoordinator()
        }
    }
}
