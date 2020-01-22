//
//  EventsViewController.swift
//  Pippin
//
//  Created by Will Brandin on 1/21/20.
//  Copyright © 2020 SchoolConnect. All rights reserved.
//

import UIKit

protocol EventListViewControllerProtocol: Presentable, LoadingView, NetworkingFailableView {
    var onSelectEvent: ((String) -> Void)? { get set }
}

class EventListViewController: UIViewController, EventListViewControllerProtocol {
    
    // MARK: - Properties
    
    var onSelectEvent: ((String) -> Void)?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Events"
        view.backgroundColor = .blue
    }
    
}
