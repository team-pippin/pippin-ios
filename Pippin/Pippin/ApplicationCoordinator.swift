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
    
    override func handle(flowEvent: FlowEvent) -> Bool {
        guard let event = flowEvent as? FlowEventType else { return false }
        
        switch event {
        case .didSignIn:
            determineRootCoordinator()
            return true
        case .didLogout:
            UserDefaultsManager.selectedUserSchoolId = nil
            UserDefaultsManager.signedInUserToken = nil
            determineRootCoordinator()
            return true
        }
    }
    
    // MARK: - Private Methods
    
    private func determineRootCoordinator() {
        if UserDefaultsManager.signedInUserToken != nil {
            if UserDefaultsManager.selectedUserSchoolId != nil {
                startHomeCoordinator(animated: false)
            } else {
                startOnBoardingCoordinator()
            }
        } else {
            startLandingCoordinator(animated: false)
        }
    }
    
    private func startLandingCoordinator(animated: Bool = true) {
        start(childCoordinator: LandingCoordinator(), with: .pushAndMakeRoot, animated: animated)
    }
    
    private func startHomeCoordinator(animated: Bool = true) {
        
    }
    
    private func startOnBoardingCoordinator(animated: Bool = true) {
        start(childCoordinator: SubscribeToSchoolCoordinator(), with: .pushAndMakeRoot, animated: animated)
    }
}
