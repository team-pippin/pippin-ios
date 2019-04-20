//
//  CustomButton.swift
//  Pippin
//
//  Created by Will Brandin on 4/1/19.
//  Copyright © 2019 SchoolConnect. All rights reserved.
//

import UIKit

// MARK: - CustomButton

/// A styled button with enabled, highlighted, and loading states
public class CustomButton: UIButton {
    
    // MARK: Public
    public var actionHandler: CustomButtonContent.ActionHandler? = nil
    
    /// The Title of the button
    public var title: String {
        get {
            return title(for: .normal) ?? ""
        }
        set {
            var newTitle: String
            switch titleCaseMutator {
            case .none:
                newTitle = newValue
            case .lowerCase:
                newTitle = newValue.lowercased()
            case .upperCase:
                newTitle = newValue.uppercased()
            }
            setTitle(newTitle, for: .normal)
            sizeToFit()
        }
    }
    
    public var titleCaseMutator: TextCaseMutator {
        didSet {
            let theTitle = title
            self.title = theTitle
        }
    }
    
    public func setContent(content: CustomButtonContent) {
        title = content.title
        isLoading = content.isLoading
        actionHandler = content.actionHandler
        setColorForState()
    }
    
    public func setStyle(style: CustomButtonStyle) {
        buttonColor = style.buttonColor
        highlightColor = style.tintColor
        disabledColor = style.disabledBackgroundColor
        layer.borderColor = style.borderColor.cgColor
        
        tintView.layer.cornerRadius = style.cornerRadius
        layer.cornerRadius = style.cornerRadius
        layer.borderWidth = style.borderWidth
        
        titleLabel?.font = style.titleFont
        setTitleColor(style.titleColor, for: .normal)
        setTitleColor(style.disabledTitleColor, for: .disabled)
        contentEdgeInsets = style.titleInsets
        
        if let shadow = style.shadow {
            self.setShadow(shadow: shadow)
        }
        
        if let widthConstraint = widthConstraint {
            widthConstraint.isActive = false
            removeConstraint(widthConstraint)
        }
        
        if style.type == .pill {
            let insets = UIEdgeInsets(top: style.titleInsets.top, left: 0, bottom: style.titleInsets.bottom, right: 0)
            contentEdgeInsets = insets
            widthConstraint = widthAnchor.constraint(greaterThanOrEqualTo: heightAnchor)
            widthConstraint?.isActive = true
        } else if style.type == .circular {
            let insets = UIEdgeInsets(top: style.titleInsets.top, left: 0, bottom: style.titleInsets.bottom, right: 0)
            contentEdgeInsets = insets
            widthConstraint = widthAnchor.constraint(equalTo: heightAnchor)
            widthConstraint?.isActive = true
        }
        
        loadingIndicator.style = style.loadingStyle
        setColorForState()
    }
    
    /**
     Sets the loading state of the button.
     
     Loading state hides the title and displays a loading indicator.
     */
    public var isLoading: Bool = false {
        didSet {
            DispatchQueue.main.async {
                if self.isLoading {
                    self.loadingIndicator.isHidden = false
                    self.loadingIndicator.startAnimating()
                    self.titleLabel?.alpha = 0
                } else {
                    self.loadingIndicator.isHidden = true
                    self.loadingIndicator.stopAnimating()
                    self.titleLabel?.alpha = 1
                }
            }
        }
    }
    
    /// Sets the highlighted or "tapped" color
    public var highlightColor: UIColor? {
        get {
            return tintView.backgroundColor
        }
        set {
            tintView.backgroundColor = newValue
        }
    }
    
    /// Sets the disabled Color
    public var disabledColor: UIColor? {
        didSet {
            if isEnabled == false {
                backgroundColor = disabledColor
            }
        }
    }
    
    /// Sets the default button color
    public var buttonColor: UIColor? {
        didSet {
            if isEnabled == true {
                backgroundColor = buttonColor
            }
        }
    }
    
    public override var isHighlighted: Bool {
        didSet {
            setColorForState()
        }
    }
    
    public override var isEnabled: Bool {
        didSet {
            setColorForState()
        }
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        if let widthConstraint = widthConstraint, widthConstraint.isActive {
            layer.cornerRadius = bounds.size.height * 0.5
        }
    }
    
    // MARK: Initializers
    
    public required init(content: CustomButtonContent? = nil, style: CustomButtonStyle = .defaultPrimary) {
        self.titleCaseMutator = style.titleCaseMutator
        super.init(frame: .zero)
        addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        addSubview(tintView)
        tintView.pinToSuperview()
        tintView.isHidden = true
        tintView.layer.zPosition = 1000
        
        addSubview(loadingIndicator)
        loadingIndicator.pinToCenter()
        loadingIndicator.layer.zPosition = 1001
        loadingIndicator.isHidden = true
        
        setStyle(style: style)
        if let content = content {
            setContent(content: content)
        }
    }
    
    public required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private
    
    fileprivate let tintView = UIView(frame: .zero)
    fileprivate let loadingIndicator = UIActivityIndicatorView(style: .white)
    fileprivate var widthConstraint: NSLayoutConstraint?
    
    fileprivate func setColorForState() {
        switch (isHighlighted, isEnabled) {
        case (true, false):
            backgroundColor = disabledColor
            tintView.isHidden = false
        case (true, true):
            backgroundColor = buttonColor
            tintView.isHidden = false
        case (false, true):
            backgroundColor = buttonColor
            tintView.isHidden = true
        case (false, false):
            backgroundColor = disabledColor
            tintView.isHidden = true
        }
    }
    
    @objc func handleTap() {
        if let handler = actionHandler {
            handler()
        }
    }
}

// MARK: - CustomButtonContent

/**
 Content for a CustomButton
 
 Created with a Title stirng and an optional loading state.
 */
public class CustomButtonContent {
    
    public typealias ActionHandler = () -> Void
    
    public let title: String
    
    public let isLoading: Bool
    
    public let actionHandler: CustomButtonContent.ActionHandler?
    
    public init(title: String,
                isLoading: Bool = false,
                actionHandler: CustomButtonContent.ActionHandler? = nil) {
        self.title = title
        self.isLoading = isLoading
        self.actionHandler = actionHandler
    }
    
}

// MARK: - CustomButtonStyle
public enum ButtonSizingType {
    case normal
    case pill
    case circular
}

public enum TextCaseMutator {
    case none
    case lowerCase
    case upperCase
}

open class CustomButtonStyle {
    
    public init() {}
    
    public var buttonColor: UIColor = Style.Color.action
    public var disabledBackgroundColor: UIColor = Style.Color.secondaryTextLight
    public var borderColor: UIColor = UIColor.clear
    public var tintColor: UIColor = Style.Color.interactiveTint
    
    public var cornerRadius: CGFloat =  8.0
    public var borderWidth: CGFloat = CGFloat(0)
    
    public var titleFont: UIFont = Style.Font.button
    public var titleColor: UIColor = Style.Color.actionableText
    public var disabledTitleColor: UIColor = Style.Color.primaryTextDark
    public var titleInsets: UIEdgeInsets = UIEdgeInsets(top: 18, left: 23, bottom: 18, right: 23)
    
    public var shadow: LayerShadow? = LayerShadow(shadowColor: UIColor.black, shadowOpacity: 0.2, shadowRadius: 4, shadowOffset: CGSize(width: 0, height: 2))
    
    public var loadingStyle: UIActivityIndicatorView.Style = .white
    
    public var type: ButtonSizingType = .normal
    
    public var titleCaseMutator: TextCaseMutator = .none
    
}

public extension CustomButtonStyle {
    /// Primary Style
    public static var defaultPrimary: CustomButtonStyle {
        return CustomButtonStyle()
    }
    
    public static var formDefaultPrimary: CustomButtonStyle {
        let style = CustomButtonStyle()
        style.cornerRadius = 0
        return style
    }
    
    /// Secondary Style
    public static var defaultSecondary: CustomButtonStyle {
        let style = CustomButtonStyle()
        
        style.buttonColor = Style.Color.secondaryAction
        style.disabledBackgroundColor = Style.Color.secondaryTextLight
        
        style.titleColor = Style.Color.primaryTextDark
        
        return style
    }
    
    /// Dark Pill Style
    public static var defaultPill: CustomButtonStyle {
        let style = CustomButtonStyle()
        style.type = .pill
        style.buttonColor = Style.Color.secondaryAction
        style.titleColor = Style.Color.primaryTextLight
        style.titleInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        style.cornerRadius = 18.0
        return style
    }
    
    public static var clear: CustomButtonStyle {
        let style = CustomButtonStyle()
        style.buttonColor = UIColor.clear
        style.shadow = nil
        
        return style
    }
    
}
