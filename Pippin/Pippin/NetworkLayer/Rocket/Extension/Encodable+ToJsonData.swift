//
//  Encodable+ToJsonData.swift
//  RocketNetworking
//
//  Created by Will Brandin on 1/26/19.
//  Copyright © 2019 williambrandin. All rights reserved.
//

import Foundation

extension Encodable {
    func toJSONData() -> Data? {
        return try? JSONEncoder().encode(self)
    }
}
