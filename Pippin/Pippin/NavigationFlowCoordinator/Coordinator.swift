//
//  Coordinator.swift
//  RickyBobby
//
//  Created by Eyal Zohar on 8/6/18.
//  Copyright © 2018 Tide University Laundry. All rights reserved.
//

import Foundation

@objc public enum NavigationStyle: Int {
    case present
    case push
    case pushAndMakeRoot
}

public protocol Coordinator: class {
    /// starts coordinator flow
    func start()
    func start(with presentationStyle: NavigationStyle, animated: Bool)

    /// finish coordinator flow
    func finish()
}
