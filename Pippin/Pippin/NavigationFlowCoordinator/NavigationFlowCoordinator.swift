//
//  NavigationFlowCoordinator.swift
//  RickyBobby
//
//  Created by Eyal Zohar on 8/6/18.
//  Copyright © 2018 Tide University Laundry. All rights reserved.
//

import UIKit

open class NavigationFlowCoordinator: FlowCoordinator {
    
    private var navigationCoordinatorsTracker: NavigationControllerCoordinatorsTracker!

    /// UINavigationController instance being used to present view controllers hosted by coordinator
    open var navigationController: UINavigationController {
        return navigationCoordinatorsTracker.navigationController
    }
    
    /// mainViewController is view controller instace created as a result of createMainViewController() call
    /// and presented as very first VC in coordinator flow
    private(set) var mainViewController: UIViewController?
    
    /// creates view controller that is used then as mainViewController
    /// called during coordinator start
    ///
    /// - Returns: view controller being set as mainViewController and presented as very first VC in coordinator flow
    open func createMainViewController() -> UIViewController? {
        return nil
    }
    
    /// Force tracking status update.
    /// Updating tracking status bases on navigationController delegate "willShow viewController" method.
    /// This method might be not called in same cases, i.e. when coordinator mainViewController is is instantly replaced with other view controller (i.e by starting other child coordinator without animation)
    /// In this case the caller might force updating tracking status so that coordinator object gets released
    public func forceUpdateTrackingStatus() {
        navigationCoordinatorsTracker.updateTrackingStatus()
    }
    
    // MARK: FlowCoordinator overrides
    
    override open var coordinatorsTracker: CoordinatorsTracker? {
        return navigationCoordinatorsTracker
    }
    
    open override func start() {
        if navigationCoordinatorsTracker == nil {
            navigationCoordinatorsTracker = NavigationControllerCoordinatorsTracker()
        }
        
        if let viewController = createMainViewController() {
            mainViewController = viewController
            navigationController.viewControllers = [viewController]
        } else {
            print("failed to create a main view controller")
        }
    }
    
    open override func start(with presentationStyle: NavigationStyle, animated: Bool) {
        if navigationCoordinatorsTracker == nil {
            navigationCoordinatorsTracker = NavigationControllerCoordinatorsTracker()
        }

        if let viewController = createMainViewController() {
            mainViewController = viewController
            switch presentationStyle {
            case .present:
                presentMainViewController(animated: animated)
            case .push:
                pushMainViewController(animated: animated)
            case .pushAndMakeRoot:
                pushMainAndMakeRoot(animated: animated)
            }
        }
    }
    
    override open func finish() {
        popAllRelatedViewControllers()
    }
    
    override open func start(childCoordinator: FlowCoordinator, with presentationStyle: NavigationStyle, animated: Bool = true) {
        let childNavigationFlowCoordinator = childCoordinator as? NavigationFlowCoordinator
        
        childNavigationFlowCoordinator?.navigationCoordinatorsTracker = self.navigationCoordinatorsTracker
        
        super.start(childCoordinator: childCoordinator, with: presentationStyle, animated: animated)
    }
    
    // MARK: Navigation controller related flow
    
    /// push viewController onto navigation controller
    ///
    /// - Parameters:
    ///   - viewController: view controller to be pushed
    ///   - animated: is transition animated
    public func push(viewController: UIViewController, animated: Bool = true) {
        navigationController.pushViewController(viewController, animated: animated)
    }
    
    public func pushAndMakeRoot(viewController: UIViewController, animated: Bool = true) {
        navigationController.setViewControllers([viewController], animated: animated)
        forceUpdateTrackingStatus()
    }
    
    /// pops all related view controllers including main one
    ///
    /// - Parameter animated: is transition animated
    public func popAllRelatedViewControllers(animated: Bool = true) {
        assert(mainViewController != nil, "mainViewController can not be nil in context of: \(#function)")
        
        guard let mainViewController = mainViewController, let index = navigationController.viewControllers.index(of: mainViewController) else {
            return
        }
        
        if index > 0 {
            navigationController.popToViewController(navigationController.viewControllers[index - 1], animated: animated)
        } else {
            clearNavigationControllerStack()
            self.mainViewController = nil
        }
    }
    
    /// pops last view controller from navigation controller
    ///
    /// - Parameter animated: is transition animated
    public func popLastViewController(animated: Bool = true) {
        _ = navigationController.popViewController(animated: animated)
    }
    
    /// pops view controllers until main one is on top of navigation controller
    ///
    /// - Parameter animated: is transition animated
    public func popToMainViewController(animated: Bool = true) {
        assert(mainViewController != nil, "mainViewController can not be nil in context of: \(#function)")
        
        if let mainViewController = mainViewController {
            _ = navigationController.popToViewController(mainViewController, animated: animated)
        }
    }
    
    /// pops view controllers until viewController is on top of navigation controller
    ///
    /// - Parameters:
    ///   - viewController: viewController to be popped to
    ///   - animated: is transition animated
    public func pop(toViewController viewController: UIViewController, animated: Bool = true) {
        _ = navigationController.popToViewController(viewController, animated: animated)
    }
    
    /// pops view controllers until the main view controller of root coordinator is on top
    /// it will result in all child coordinators will be finished the only one left started will be root coordinator (the one withou parent coordinator)
    public func popToNavigationRoot() {
        var rootCoordinator: NavigationFlowCoordinator = self
        
        while rootCoordinator.parentCoordinator as? NavigationFlowCoordinator != nil {
            rootCoordinator = rootCoordinator.parentCoordinator as! NavigationFlowCoordinator
        }
        
        rootCoordinator.popToMainViewController()
    }
    
    /// instantly removes all view controllers from navigation controller
    public func clearNavigationControllerStack() {
        navigationController.viewControllers = []
        forceUpdateTrackingStatus()
    }
    
    // MARK: Modal VCs
    
    /// present view controller modally over navigation controller
    ///
    /// - Parameters:
    ///   - viewController: view controller to be presented
    ///   - animated: is transition animated
    ///   - completion: closure called when transition is finished
    public func present(viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        navigationController.present(viewController, animated: true, completion: completion)
    }
    
    /// dismiss specific view controller
    ///
    /// - Parameters:
    ///   - viewController: view controller to be dismissed
    ///   - animated: is transition animated
    public func dismiss(viewController: UIViewController, animated: Bool = true) {
        viewController.dismiss(animated: animated, completion: nil)
    }
    
    /// dismiss last modal view controller
    ///
    /// - Parameters:
    ///   - animated: is transition animated
    ///   - completion: closure called when transition is finished
    public func dismissLastViewController(animated: Bool = true, completion: (() -> Void)? = nil) {
        navigationController.dismiss(animated: animated, completion: completion)
    }
    
    // MARK: private methods
    
    private func pushMainViewController(animated: Bool = true) {
        assert(mainViewController != nil, "mainViewController can not be nil in context of: \(#function)")
        
        if let mainViewController = mainViewController {
            push(viewController: mainViewController, animated: animated)
        }
    }
    
    private func pushMainAndMakeRoot(animated: Bool = true) {
        assert(mainViewController != nil, "mainViewController can not be nil in context of: \(#function)")
        
        if let mainViewController = mainViewController {
            pushAndMakeRoot(viewController: mainViewController, animated: animated)
        }
    }
    
    private func presentMainViewController(animated: Bool = true) {
        assert(mainViewController != nil, "mainViewController can not be nil in context of: \(#function)")
        
        if let mainViewController = mainViewController {
            present(viewController: mainViewController, animated: animated)
        }
    }
}
