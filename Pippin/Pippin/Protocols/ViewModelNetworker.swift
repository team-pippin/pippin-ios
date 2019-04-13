//
//  ViewModelNetworker.swift
//  Pippin
//
//  Created by Will Brandin on 4/8/19.
//  Copyright © 2019 SchoolConnect. All rights reserved.
//

import Foundation

protocol ViewModelNetworker: class {
    var onIsLoading: ((Bool) -> Void)? { get set }
    var onNetworkingFailed: (() -> Void)? { get set }
    var onNetworkingSuccess: (() -> Void)? { get set }
}

extension ViewModelNetworker {
    func handleUnauthorized() {
        NotificationCenter.default.post(name: .unauthorized, object: nil)
    }
}
