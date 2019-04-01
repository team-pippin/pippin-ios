//
//  CoordinatorsTracker.swift
//  RickyBobby
//
//  Created by Eyal Zohar on 8/6/18.
//  Copyright © 2018 Tide University Laundry. All rights reserved.
//

import Foundation

public protocol CoordinatorsTracker {
    /// gives a chance to track the coordinator reference in a custom way
    ///
    /// - Parameter coordinator: coordinator to track
    func track(coordinator: Coordinator)
}
