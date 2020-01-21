//
//  ModalPresentable.swift
//  Pippin
//
//  Created by Will Brandin on 1/21/20.
//  Copyright © 2020 SchoolConnect. All rights reserved.
//

import Foundation
import UIKit

/// A base class for Modal Views to be presented with Modal Presenter
open class ModalPresentable: UIView {
    
    weak var modalDelegate: PresentableDelegate?
    
    public func dismiss(didCancel: Bool = false) {
        modalDelegate?.didTapDismiss(didCancel: didCancel)
    }
    
    public let presentableStyle: ModalPresntableStyle
    public let presenterStyle: ModalPresenterStyle
    
    required public init(style: ModalPresntableStyle, presenterStyle: ModalPresenterStyle) {
        self.presentableStyle = style
        self.presenterStyle = presenterStyle
        super.init(frame: .zero)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

public class ModalPresntableStyle {
    
    public init() {}
    
    public var handleVisible: Bool = false
    public var handleSize: CGSize = CGSize(width: 30, height: 4)
    public var handleColor: UIColor = .darkGray
    public var handleInset: CGFloat = CGFloat(10)
    public var contentOuterMargins: CGFloat = Style.Layout.marginXL
    /// The color of the underlay that stretched under the top or bottom bar and is fitted in size to the content view.
    public var contentBackgroundColor: UIColor = UIColor.clear
}

public extension ModalPresntableStyle {
    
    /// Standard Modal Style - The ModalPresentable determins background color and no handle is shown.
    static var standardStyle: ModalPresntableStyle {
        return ModalPresntableStyle()
    }
    
    /// Handle Style - The Content View has a Light Background and a handle is displayed for dismissing is user dismall is allowed.
    static var handleStyle: ModalPresntableStyle {
        let style = ModalPresntableStyle()
        style.handleVisible = true
        style.contentOuterMargins = 0
        style.contentBackgroundColor = .white
        return style
    }
    
    /// Handle Style - The Content View has no background color and a handle is displayed for dismissing is user dismall is allowed.
    static var floatingHandleStyle: ModalPresntableStyle {
        let style = ModalPresntableStyle()
        style.handleVisible = true
        style.contentOuterMargins = 0
        return style
    }
}
