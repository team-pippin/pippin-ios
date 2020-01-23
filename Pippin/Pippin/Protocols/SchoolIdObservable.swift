//
//  SchoolIdObservable.swift
//  Pippin
//
//  Created by Will Brandin on 1/22/20.
//  Copyright © 2020 SchoolConnect. All rights reserved.
//

import Foundation

public protocol SchoolIdObservable {
    var schoolId: String { get set }
    func didChangeSchool()
}
