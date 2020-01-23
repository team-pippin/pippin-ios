//
//  NewsCoordinator.swift
//  Pippin
//
//  Created by Will Brandin on 1/21/20.
//  Copyright © 2020 SchoolConnect. All rights reserved.
//

import UIKit

final class NewsCoordinator: NavigationFlowCoordinator, TabCoordinatable {
    
    // MARK: - Properties
    
    var tabBarItem: UITabBarItem {
        return UITabBarItem(title: "News", image: #imageLiteral(resourceName: "news"), tag: 0)
    }
    
    var tabNavigationController: UIViewController? {
        return mainViewController?.navigationController
    }
    
    private var newsViewController: NewsListViewControllerProtocol?
    
    // MARK: - Methods
    
    override func createMainViewController() -> UIViewController? {
        return createNewsListViewController()
    }
    
    // MARK: - Private Methods
    
    private func createNewsListViewController() -> UIViewController? {
        guard let viewModel = NewsListViewModel() else {
            print("Could not initialize NewsListViewModel")
            return nil
        }
        
        newsViewController = NewsListViewController(viewModel: viewModel)
        
        newsViewController?.onSelectArticle = { [weak self] articleId in
            self?.showNewsViewController(for: articleId)
        }
        
        guard let controller = newsViewController?.toPresent() else { return nil }
        controller.tabBarItem = tabBarItem
        return controller
    }
    
    private func showNewsViewController(for articleId: String) {
        
    }
}
