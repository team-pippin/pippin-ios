//
//  AlertView.swift
//  Pippin
//
//  Created by Will Brandin on 1/21/20.
//  Copyright © 2020 SchoolConnect. All rights reserved.
//

import Foundation
import UIKit

// MARK: - AlertView

class AlertView: ModalPresentable {
    
    // MARK: Public
    
    // MARK: Initializers
    
    required init(content: AlertViewContent, style: AlertViewStyle = .standardStyle) {
        
        super.init(style: .alertStyle, presenterStyle: .topStyle)
        
        backgroundColor = style.backgroundColor
        layer.cornerRadius = style.cornerRadius
        setShadow(shadow: style.shadow)
        
        let alert = UILabel(font: style.font, textColor: style.fontColor)
        alert.numberOfLines = 0
        alert.text = content.alert
        addSubview(alert)
        alert.pinToTop(constant: style.margins.top)
        alert.pinToLeading(constant: style.margins.left)
        alert.pinToTrailing(constant: style.margins.right)
        alert.pinToBottom(constant: style.margins.bottom)
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(style: ModalPresntableStyle, presenterStyle: ModalPresenterStyle) {
        fatalError("init(style:presenterStyle:) has not been implemented")
    }
    
    // MARK: Private
    
}

// MARK: - AlertViewContent

class AlertViewContent {
    
    init(alert: String) {
        self.alert = alert
    }
    
    let alert: String
}

// MARK: - AlertViewStyle

class AlertViewStyle {
    
    init() {}
    
    var backgroundColor: UIColor = Style.Color.action
    var font: UIFont = Style.Font.button
    var fontColor: UIColor = .white
    var cornerRadius: CGFloat = 10
    var shadow: LayerShadow = LayerShadow(shadowColor: UIColor.black, shadowOpacity: 0.2, shadowRadius: 12, shadowOffset: CGSize(width: 0, height: 2))
    var margins = UIEdgeInsets(top: 15, left: 20, bottom: 30, right: 20)
    
}

extension AlertViewStyle {
    /// Standard Style
    static var standardStyle: AlertViewStyle {
        return AlertViewStyle()
    }
    
    static var successStyle: AlertViewStyle {
        let style = AlertViewStyle()
        style.backgroundColor = Style.Color.action
        return style
    }
    
    static var utilityStyle: AlertViewStyle {
        let style = AlertViewStyle()
        style.backgroundColor = .darkGray
        return style
    }
}

extension ModalPresntableStyle {
    static var alertStyle: ModalPresntableStyle {
        let style = ModalPresntableStyle()
        style.handleVisible = true
        style.handleColor = UIColor.white.withAlphaComponent(0.3)
        return style
    }
}
