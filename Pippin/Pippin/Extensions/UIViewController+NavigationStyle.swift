//
//  UIViewController+NavigationStyle.swift
//  Pippin
//
//  Created by Will Brandin on 4/2/19.
//  Copyright © 2019 SchoolConnect. All rights reserved.
//

import UIKit

class NavigationTitleView: UIView {
    let titleLabel: UILabel = UILabel(font: Style.Font.navigationTitle, textColor: Style.Color.primaryTextDark)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        titleLabel.pinToSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

public extension UIViewController {
    
    /// Sets a styled title header view in navigation bar.
    func setNavigationTitle(title: String?) {
        if let title = title {
            let header = NavigationTitleView(frame: .zero)
            header.titleLabel.text = title
            navigationItem.titleView = header
        } else {
            navigationItem.titleView = nil
        }
    }
    
    func addRightNavigationLink(title: String, target: Any?, action: Selector?) {
        let button = UIBarButtonItem(title: title, style: .plain, target: target, action: action)
        button.setTitleTextAttributes([NSAttributedString.Key.font : Style.Font.navigationButton], for: .normal)
        button.setTitleTextAttributes([NSAttributedString.Key.font : Style.Font.navigationButton], for: .selected)
        button.setTitleTextAttributes([NSAttributedString.Key.font : Style.Font.navigationButton], for: .highlighted)
        button.tintColor = Style.Color.navigationAction
        navigationItem.rightBarButtonItem = button
    }
    
    func addLeftNavigationLink(title: String, target: Any?, action: Selector?) {
        let button = UIBarButtonItem(title: title, style: .plain, target: target, action: action)
        button.setTitleTextAttributes([NSAttributedString.Key.font : Style.Font.navigationButton], for: .normal)
        button.setTitleTextAttributes([NSAttributedString.Key.font : Style.Font.navigationButton], for: .selected)
        button.setTitleTextAttributes([NSAttributedString.Key.font : Style.Font.navigationButton], for: .highlighted)
        button.tintColor = Style.Color.navigationAction
        navigationItem.leftBarButtonItem = button
    }
}
