//
//  RemoteConfig.swift
//  Pippin
//
//  Created by Will Brandin on 1/17/20.
//  Copyright © 2020 SchoolConnect. All rights reserved.
//

import Foundation

public struct RemoteConfig: Codable {
    let defaultImageUrl: String
    let primaryColor: String
    let secondaryColor: String
    let features: [SchoolFeature]
}
