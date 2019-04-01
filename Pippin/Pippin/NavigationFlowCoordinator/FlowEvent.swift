//
//  FlowEvent.swift
//  RickyBobby
//
//  Created by Eyal Zohar on 8/6/18.
//  Copyright © 2018 Tide University Laundry. All rights reserved.
//

import Foundation

/// protocol that any specific flow event class needs to conform
/// to make possible to send the object of the class using flow events mechanism
public protocol FlowEvent {

}

public enum FlowEventType: FlowEvent {
    case didSelectSchool
}
