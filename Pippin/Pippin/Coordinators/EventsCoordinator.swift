//
//  EventsCoordinator.swift
//  Pippin
//
//  Created by Will Brandin on 1/21/20.
//  Copyright © 2020 SchoolConnect. All rights reserved.
//

import UIKit

final class EventsCoordinator: NavigationFlowCoordinator, TabCoordinatable {
    
    // MARK: - Properties
    
    var tabBarItem: UITabBarItem {
        return UITabBarItem(title: "Events", image: #imageLiteral(resourceName: "calendar"), tag: 0)
    }
    
    var tabNavigationController: UIViewController? {
        return mainViewController?.navigationController
    }
    
    private var eventsViewController: EventListViewControllerProtocol?
    
    // MARK: - Methods
    
    override func createMainViewController() -> UIViewController? {
        return createHomeViewController()
    }
    
    // MARK: - Private Methods
    
    private func createHomeViewController() -> UIViewController? {
        guard let viewModel = EventListViewModel() else {
            print("Could not initialize EventListViewModel")
            return nil
        }
        
        eventsViewController = EventListViewController(viewModel: viewModel)
        
        eventsViewController?.onSelectEvent = { [weak self] eventId in
            self?.showEventViewController(for: eventId)
        }
        
        guard let controller = eventsViewController?.toPresent() else { return nil }
        controller.tabBarItem = tabBarItem
        return controller
    }
    
    private func showEventViewController(for eventId: String) {
        
    }
}
