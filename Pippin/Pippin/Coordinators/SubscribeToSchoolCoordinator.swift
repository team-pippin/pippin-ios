//
//  OnboardingCoordinator.swift
//  Pippin
//
//  Created by Will Brandin on 4/1/19.
//  Copyright © 2019 SchoolConnect. All rights reserved.
//

import UIKit

final class SubscribeToSchoolCoordinator: NavigationFlowCoordinator {
    
    // MARK: - Properties
    
    private var schoolSearchViewController: SchoolSearchViewControllerProtocol?
    private var subscribeToSchoolViewController: ConfirmSubscribeViewControllerProtocol?
    
    // MARK: - Methods
    
    override func createMainViewController() -> UIViewController? {
        return createSchoolSearchViewController()
    }
    
    // MARK: - Private Methods
    
    private func createSchoolSearchViewController() -> UIViewController? {
        schoolSearchViewController = SchoolSearchViewController()
        
        schoolSearchViewController?.onDidSelectSchool = { [weak self] selectedSchool in
            self?.showSchoolConfirmationViewController(for: selectedSchool)
        }
        
        return schoolSearchViewController?.toPresent()
    }
    
    private func showSchoolConfirmationViewController(for school: SchoolSearch) {
        let viewModel = ConfirmSubscribeViewModel(school: school)
        subscribeToSchoolViewController = ConfirmSubscribeViewController(viewModel: viewModel)
        
        subscribeToSchoolViewController?.onDidSubscribeToSchool = {
            self.send(flowEvent: FlowEventType.didSubscribeToSchool)
        }
        
        if let controller = subscribeToSchoolViewController?.toPresent() {
            push(viewController: controller)
        }
    }
}
