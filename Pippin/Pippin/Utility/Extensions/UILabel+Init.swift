//
//  UILabel+Init.swift
//  Pippin
//
//  Created by Will Brandin on 4/2/19.
//  Copyright © 2019 SchoolConnect. All rights reserved.
//

import UIKit

extension UILabel {
    public convenience init(font: UIFont, textColor: UIColor) {
        self.init(frame: .zero)
        
        self.font = font
        self.textColor = textColor
    }
}

extension UIButton {
    public convenience init(target: Any?, action: Selector) {
        self.init(frame: .zero)
        
        addTarget(target, action: action, for: .touchUpInside)
    }
}
