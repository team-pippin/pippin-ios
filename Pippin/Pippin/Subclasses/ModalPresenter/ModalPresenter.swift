//
//  ModalPresenter.swift
//  Pippin
//
//  Created by Will Brandin on 1/21/20.
//  Copyright © 2020 SchoolConnect. All rights reserved.
//

import Foundation
import UIKit

/// Used internally to the Modal Presenter
protocol PresentableDelegate: class {
    func didTapDismiss(didCancel: Bool)
}

// MARK: - ModalPresenter

public class ModalPresenter: UIView {
    
    // MARK: Public
    /// Shows the modal with a slight bounce animation.
    func show() {
        self.superview?.layoutIfNeeded()
        contentVisibleConstraint?.isActive = true
        contentHiddenConstraint?.isActive = false
        
        UIView.animate(withDuration: 0.4,
                       delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0.1,
                       options: [.curveEaseOut],
                       animations: {
                        self.blurEffectView.alpha = 1
                        self.scrimView.alpha = 1
                        self.superview?.layoutIfNeeded()
        },
                       completion: nil)
    }
    /// Dismisses the modal
    func dismiss(didCancel: Bool) {
        self.superview?.layoutIfNeeded()
        contentVisibleConstraint?.isActive = false
        if didCancel {
            contentDismissConstraint?.isActive = true
        } else {
            contentHiddenConstraint?.isActive = true
        }
        
        UIView.animate(withDuration: 0.4,
                       delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0.1,
                       options: [.curveEaseIn],
                       animations: {
                        self.blurEffectView.alpha = 0
                        self.scrimView.alpha = 0
                        self.superview?.layoutIfNeeded()
        }, completion: { (_) in
            self.didDismiss()
        })
    }
    
    // MARK: Initializers
    
    required public init(view: ModalPresentable, allowUserToDismiss: Bool = true) {
        self.style = view.presenterStyle
        
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        if style.showBlur {
            addSubview(blurEffectView)
            blurEffectView.pinToSuperview()
            blurEffectView.alpha = 0
        } else if let scrimColor = style.scrimColor {
            scrimView.backgroundColor = scrimColor
            addSubview(scrimView)
            scrimView.pinToSuperview()
            scrimView.alpha = 0
        }
        
        // Setup Blur View
        if allowUserToDismiss {
            let dismissButton = UIButton(type: .custom)
            dismissButton.addTarget(self, action: #selector(didTapBackground), for: .touchUpInside)
            addSubview(dismissButton)
            dismissButton.pinToSuperview()
        }
        
        let contentBackgroundView = UIView()
        contentBackgroundView.backgroundColor = view.presentableStyle.contentBackgroundColor
        addSubview(contentBackgroundView)
        contentBackgroundView.pinToLeadingAndTrailing(constant: view.presentableStyle.contentOuterMargins)
        
        // Setup Content View
        addSubview(contentView)
        contentView.pinToLeadingAndTrailing(constant: view.presentableStyle.contentOuterMargins)
        
        switch style.type {
        case .bottom:
            contentBackgroundView.pinToBottom()
            contentBackgroundView.alignTopToView(view: contentView)
            contentVisibleConstraint = contentView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor)
            contentDismissConstraint = contentView.topAnchor.constraint(equalTo: bottomAnchor)
            contentHiddenConstraint = contentView.topAnchor.constraint(equalTo: bottomAnchor)
            contentHiddenConstraint?.isActive = true
        case .center:
            contentBackgroundView.alignTopToView(view: contentView)
            contentBackgroundView.alignBottomToView(view: contentView)
            contentVisibleConstraint = contentView.centerYAnchor.constraint(equalTo: centerYAnchor)
            contentDismissConstraint = contentView.topAnchor.constraint(equalTo: bottomAnchor)
            contentHiddenConstraint = contentView.bottomAnchor.constraint(equalTo: topAnchor)
            contentHiddenConstraint?.isActive = true
        case .top:
            contentBackgroundView.pinToTop()
            contentBackgroundView.alignBottomToView(view: contentView)
            contentVisibleConstraint = contentView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor)
            contentDismissConstraint = contentView.bottomAnchor.constraint(equalTo: topAnchor)
            contentHiddenConstraint = contentView.bottomAnchor.constraint(equalTo: topAnchor)
            contentHiddenConstraint?.isActive = true
        }
        
        // Setup Dismiss Handle
        if allowUserToDismiss && view.presentableStyle.handleVisible {
            addSubview(dismissHandle)
            let handleUI = UIView()
            handleUI.backgroundColor = view.presentableStyle.handleColor
            handleUI.layer.cornerRadius = view.presentableStyle.handleSize.height * 0.5
            dismissHandle.addSubview(handleUI)
            handleUI.pinToTop(constant: view.presentableStyle.handleInset)
            handleUI.pinToBottom(constant: view.presentableStyle.handleInset)
            handleUI.pinToHorizontalCenter()
            handleUI.widthAnchor.constraint(equalToConstant: view.presentableStyle.handleSize.width).isActive = true
            handleUI.heightAnchor.constraint(equalToConstant: view.presentableStyle.handleSize.height).isActive = true
            dismissHandle.pinToLeadingAndTrailing()
            if style.type == .bottom {
                dismissHandle.alignTopToView(view: contentView)
            } else if style.type == .top {
                dismissHandle.alignBottomToView(view: contentView)
            }
            let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(gesture:)))
            dismissHandle.addGestureRecognizer(panGesture)
        }
        
        contentView.addSubview(view)
        view.pinToLeadingAndTrailing()
        contentViewHeightConstraint = contentView.heightAnchor.constraint(equalTo: view.heightAnchor)
        contentViewHeightConstraint?.isActive = true
        switch style.type {
        case .bottom:
            view.pinToTop()
        case .center:
            view.pinToTop()
            view.pinToBottom()
        case .top:
            view.pinToBottom()
        }
        
        view.modalDelegate = self
    }
    
    required public init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private
    fileprivate let contentView: UIView = UIView(frame: .zero)
    fileprivate let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    fileprivate let scrimView = UIView()
    fileprivate var contentVisibleConstraint: NSLayoutConstraint?
    fileprivate var contentHiddenConstraint: NSLayoutConstraint?
    fileprivate var contentDismissConstraint: NSLayoutConstraint?
    fileprivate var contentViewHeightConstraint: NSLayoutConstraint?
    fileprivate let dismissHandle: UIView = UIView()
    fileprivate let style: ModalPresenterStyle
    
    fileprivate func didDismiss() {
        removeFromSuperview()
    }
}

// MARK: - Action Handlers

extension ModalPresenter {
    @objc func didTapBackground() {
        dismiss(didCancel: true)
    }
    
    @objc func handlePanGesture(gesture: UIPanGestureRecognizer) {
        var offset = gesture.translation(in: self).y
        if gesture.state == .changed {
            if style.type == .top {
                offset = offset > 0 ? offset * 0.5 : offset
            } else if style.type == .bottom {
                offset = offset < 0 ? offset * -0.5 : offset * -1
            }
            contentViewHeightConstraint?.constant = offset
            self.layoutIfNeeded()
        }
        if gesture.state == .ended {
            let didCancel = (style.type == .top) ? offset < 0 : offset > 0
            if didCancel {
                dismiss(didCancel: true)
            } else {
                contentViewHeightConstraint?.constant = 0
                UIView.animate(withDuration: 0.4,
                               delay: 0,
                               usingSpringWithDamping: 0.8,
                               initialSpringVelocity: 0.1,
                               options: [.curveEaseOut],
                               animations: {
                                self.layoutIfNeeded()
                },
                               completion: nil)
            }
        }
    }
}

// MARK: - PresentableDelegate

extension ModalPresenter: PresentableDelegate {
    public func didTapDismiss(didCancel: Bool) {
        dismiss(didCancel: didCancel)
    }
}
