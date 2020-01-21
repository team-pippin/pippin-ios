//
//  EventsViewController.swift
//  Pippin
//
//  Created by Will Brandin on 1/21/20.
//  Copyright © 2020 SchoolConnect. All rights reserved.
//

import UIKit

protocol EventsViewControllerProtocol: Presentable {
    
}

class EventsViewController: UIViewController, EventsViewControllerProtocol, NetworkingFailableView {
    
    // MARK: - Properties
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Events"
        view.backgroundColor = .blue
    }
    
}
