//
//  CoordinatorsTracker.swift
//  Pippin
//
//  Created by Will Brandin on 4/1/19.
//  Copyright © 2019 SchoolConnect. All rights reserved.
//

import Foundation

public protocol CoordinatorsTracker {
    /// gives a chance to track the coordinator reference in a custom way
    ///
    /// - Parameter coordinator: coordinator to track
    func track(coordinator: Coordinator)
}
