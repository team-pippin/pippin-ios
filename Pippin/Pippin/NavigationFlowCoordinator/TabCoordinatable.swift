//
//  TabCoordinatable.swift
//  Pippin
//
//  Created by Will Brandin on 4/1/19.
//  Copyright © 2019 SchoolConnect. All rights reserved.
//

import UIKit

protocol TabCoordinatable: class {
    var tabBarItem: UITabBarItem { get }
    var tabNavigationController: UIViewController? { get }
}
