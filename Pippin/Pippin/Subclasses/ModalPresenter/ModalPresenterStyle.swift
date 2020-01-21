//
//  ModalPresenterStyle.swift
//  Pippin
//
//  Created by Will Brandin on 1/21/20.
//  Copyright © 2020 SchoolConnect. All rights reserved.
//

import UIKit

public enum ModalPosition {
    case top
    case center
    case bottom
}

/// The style of the Modal Presenter. Controls the presenters interaction and animation style.
public class ModalPresenterStyle {
    
    public init() {}
    public var type: ModalPosition = .center
    public var scrimColor: UIColor?
    public var showBlur: Bool = true
}

public extension ModalPresenterStyle {
    /// Standard Style
    static var standardStyle: ModalPresenterStyle {
        return ModalPresenterStyle()
    }
    
    /// Bottom Style
    static var bottomStyle: ModalPresenterStyle {
        let style = ModalPresenterStyle()
        style.type = .bottom
        style.showBlur = false
        style.scrimColor = UIColor.black.withAlphaComponent(0.3)
        return style
    }
    
    /// Bottom Style
    static var topStyle: ModalPresenterStyle {
        let style = ModalPresenterStyle()
        style.type = .top
        style.showBlur = false
        return style
    }
}
