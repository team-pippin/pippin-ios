//
//  FlowEvent.swift
//  Pippin
//
//  Created by Will Brandin on 4/1/19.
//  Copyright © 2019 SchoolConnect. All rights reserved.
//

import Foundation

/// protocol that any specific flow event class needs to conform
/// to make possible to send the object of the class using flow events mechanism
public protocol FlowEvent {

}

public enum FlowEventType: FlowEvent {
    case didSignIn
    case didLogout
    case didSubscribeToSchool
}
