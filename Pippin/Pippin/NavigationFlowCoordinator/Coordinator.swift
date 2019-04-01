//
//  Coordinator.swift
//  Pippin
//
//  Created by Will Brandin on 4/1/19.
//  Copyright © 2019 SchoolConnect. All rights reserved.
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
