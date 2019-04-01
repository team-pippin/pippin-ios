//
//  FlowCoordinator.swift
//  RickyBobby
//
//  Created by Eyal Zohar on 8/6/18.
//  Copyright © 2018 Tide University Laundry. All rights reserved.
//

import UIKit

/// Basic implementation of flow coordinator, indtended to subclass
open class FlowCoordinator: NSObject {
    
    /// parent coordinator that started this coordinator as a child coordinator
    weak var parentCoordinator: FlowCoordinator?
    
    /// object intended to automatically track coordinator reference
    /// when nil the reference needs to be kept explicitly
    var coordinatorsTracker: CoordinatorsTracker? {
        return nil
    }
    
    /// starts child coordinator
    ///
    /// - Parameter childCoordinator: child coordinator
    open func start(childCoordinator: FlowCoordinator, with presentationStyle: NavigationStyle, animated: Bool = true) {
        childCoordinator.parentCoordinator = self
        childCoordinator.start(with: presentationStyle, animated: animated)
        coordinatorsTracker?.track(coordinator: childCoordinator)
    }
    
    /// function intended to be overriden by subclasses that are interested in handling any FlowEvent
    ///
    /// - Parameter flowEvent: flow event object
    /// - Returns: true when event is handled, false otherwise giving an oportunity to handle the event by parent coordinator
    open func handle(flowEvent: FlowEvent) -> Bool {
        return false
    }
    
    /// sends specific flow event
    ///
    /// - Parameter flowEvent: flow event to be sent
    public func send(flowEvent: FlowEvent) {
        handleInternally(flowEvent: flowEvent)
    }
    
    private func handleInternally(flowEvent: FlowEvent) {
        if !handle(flowEvent: flowEvent) {
            parentCoordinator?.handleInternally(flowEvent: flowEvent)
        }
    }
}

extension FlowCoordinator: Coordinator {
    @objc open func start() {
        fatalError("start() method has to be overriden by FlowCoordinator subclass")
    }
    
    @objc open func start(with presentationStyle: NavigationStyle, animated: Bool) {
        fatalError("start() method has to be overriden by FlowCoordinator subclass")
    }
    
    @objc open func finish() { }
}
