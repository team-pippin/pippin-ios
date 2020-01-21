//
//  UIView+Constraints.swift
//  Pippin
//
//  Created by Will Brandin on 4/1/19.
//  Copyright © 2019 SchoolConnect. All rights reserved.
//

import UIKit

public extension UIView {
    
    // MARK: Pinning to Superview
    
    /// Pin view to its superview.
    func pinToSuperview(padding: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: padding).isActive = true
            trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -padding).isActive = true
            topAnchor.constraint(equalTo: superview.topAnchor, constant: padding).isActive = true
            bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -padding).isActive = true
        }
    }
    
    /// Pin view to superview margins
    func pinToMargins(padding: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            leadingAnchor.constraint(equalTo: superview.layoutMarginsGuide.leadingAnchor, constant: padding).isActive = true
            trailingAnchor.constraint(equalTo: superview.layoutMarginsGuide.trailingAnchor, constant: -padding).isActive = true
            topAnchor.constraint(equalTo: superview.layoutMarginsGuide.topAnchor, constant: padding).isActive = true
            bottomAnchor.constraint(equalTo: superview.layoutMarginsGuide.bottomAnchor, constant: -padding).isActive = true
        }
    }
    
    /// Pin view to Safe Area
    func pinToSafeArea() {
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            if #available(iOS 11.0, *) {
                leadingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leadingAnchor).isActive = true
                trailingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.trailingAnchor).isActive = true
                topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor).isActive = true
                bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor).isActive = true
            } else {
                leadingAnchor.constraint(equalTo: superview.layoutMarginsGuide.leadingAnchor).isActive = true
                trailingAnchor.constraint(equalTo: superview.layoutMarginsGuide.trailingAnchor).isActive = true
                topAnchor.constraint(equalTo: superview.layoutMarginsGuide.topAnchor).isActive = true
                bottomAnchor.constraint(equalTo: superview.layoutMarginsGuide.bottomAnchor).isActive = true
            }
        }
    }
    
    func pinToBottomSafeArea() {
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            if #available(iOS 11.0, *) {
                bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor).isActive = true
            } else {
                bottomAnchor.constraint(equalTo: superview.layoutMarginsGuide.bottomAnchor).isActive = true
            }
        }
    }
    
    /// Pin view to superview center
    func pinToCenter() {
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            centerXAnchor.constraint(equalTo: superview.centerXAnchor).isActive = true
            centerYAnchor.constraint(equalTo: superview.centerYAnchor).isActive = true
        }
    }
    
    @discardableResult func pinToHorizontalCenter(constant: CGFloat = 0) -> NSLayoutConstraint? {
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            return alignHorizontalCenterToView(view: superview, constant: constant)
        }
        return nil
    }
    
    @discardableResult func pinToVerticalCenter(constant: CGFloat = 0) -> NSLayoutConstraint? {
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            return alignVerticalCenterToView(view: superview, constant: constant)
        }
        return nil
    }
    
    /// Pins the view to the vertical center if superview is taller than view, else it sets the size of superview
    func pinToVerticalCenterOrFill() {
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            alignVerticalCenterToView(view: superview)
            topAnchor.constraint(greaterThanOrEqualTo: superview.topAnchor).isActive = true
            bottomAnchor.constraint(lessThanOrEqualTo: superview.bottomAnchor).isActive = true
        }
    }
    
    /// Pin leading and trailing to superview margins
    func pinToLeadingAndTrailingMargins(constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            leadingAnchor.constraint(equalTo: superview.layoutMarginsGuide.leadingAnchor, constant: constant).isActive = true
            trailingAnchor.constraint(equalTo: superview.layoutMarginsGuide.trailingAnchor, constant: -constant).isActive = true
        }
    }
    
    /// Pin leading and trailing to superview
    func pinToLeadingAndTrailing(constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: constant).isActive = true
            trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -constant).isActive = true
        }
    }
    
    /// Pin leading and trailing to superview
    func pinMinimumToLeadingAndTrailing(constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            leadingAnchor.constraint(greaterThanOrEqualTo: superview.leadingAnchor, constant: constant).isActive = true
            trailingAnchor.constraint(lessThanOrEqualTo: superview.trailingAnchor, constant: -constant).isActive = true
        }
    }
    
    /// Pin leading to superview leading
    @discardableResult func pinToLeading(constant: CGFloat = 0) -> NSLayoutConstraint? {
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            return alignLeadingToView(view: superview, constant: constant)
        }
        return nil
    }
    
    /// Pin trailing to superview trailing
    @discardableResult func pinToTrailing(constant: CGFloat = 0) -> NSLayoutConstraint? {
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            return alignTrailingToView(view: superview, constant: constant)
        }
        return nil
    }
    
    /// Pin leading to superview leading margin
    @discardableResult func pinToLeadingMargin(constant: CGFloat = 0) -> NSLayoutConstraint? {
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            let constraint = leadingAnchor.constraint(equalTo: superview.layoutMarginsGuide.leadingAnchor, constant: constant)
            constraint.isActive = true
            return constraint
        }
        return nil
    }
    
    /// Pin trailing to superview trailing margin
    @discardableResult func pinToTrailingMargin(constant: CGFloat = 0) -> NSLayoutConstraint? {
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            let constraint = trailingAnchor.constraint(equalTo: superview.layoutMarginsGuide.trailingAnchor, constant: constant)
            constraint.isActive = true
            return constraint
        }
        return nil
    }
    
    /// Pin view to top of superview
    @discardableResult func pinToTop(constant: CGFloat = 0) -> NSLayoutConstraint? {
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            return alignTopToView(view: superview, constant: constant)
        }
        return nil
    }
    
    /// Pin view to bottom of superview
    @discardableResult func pinToBottom(constant: CGFloat = 0) -> NSLayoutConstraint? {
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            return alignBottomToView(view: superview, constant: constant)
        }
        return nil
    }
    
    // MARK: Pinning to views
    
    /// Pin reciever to target views horizontal center
    @discardableResult func alignHorizontalCenterToView(view: UIView, constant: CGFloat = 0) -> NSLayoutConstraint? {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: constant)
        constraint.isActive = true
        return constraint
    }
    
    /// Pin reciever to target views vertical center
    @discardableResult func alignVerticalCenterToView(view: UIView, constant: CGFloat = 0) -> NSLayoutConstraint? {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant)
        constraint.isActive = true
        return constraint
    }
    
    /// Pin top of view to another view
    @discardableResult func alignTopToView(view: UIView, constant: CGFloat = 0) -> NSLayoutConstraint? {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = topAnchor.constraint(equalTo: view.topAnchor, constant: constant)
        constraint.isActive = true
        return constraint
    }
    
    /// Pin view below another view
    @discardableResult func pinBelowView(view: UIView, constant: CGFloat = 0) -> NSLayoutConstraint? {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = topAnchor.constraint(equalTo: view.bottomAnchor, constant: constant)
        constraint.isActive = true
        return constraint
    }
    
    /// Pin bottom of view to another view
    @discardableResult func alignBottomToView(view: UIView, constant: CGFloat = 0) -> NSLayoutConstraint? {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -constant)
        constraint.isActive = true
        return constraint
    }
    
    /// Pin view above another view
    @discardableResult func pinAboveView(view: UIView, constant: CGFloat = 0) -> NSLayoutConstraint? {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = bottomAnchor.constraint(equalTo: view.topAnchor, constant: -constant)
        constraint.isActive = true
        return constraint
    }
    
    /// Align leading to another view
    @discardableResult func alignLeadingToView(view: UIView, constant: CGFloat = 0) -> NSLayoutConstraint? {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constant)
        constraint.isActive = true
        return constraint
    }
    
    /// Pin leading to another view's trailing anchor
    @discardableResult func pinLeadingToView(view: UIView, constant: CGFloat = 0) -> NSLayoutConstraint? {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = leadingAnchor.constraint(equalTo: view.trailingAnchor, constant: constant)
        constraint.isActive = true
        return constraint
    }
    
    /// Pin leading to another view's trailing anchor
    @discardableResult func pinMinLeadingToView(view: UIView, constant: CGFloat = 0) -> NSLayoutConstraint? {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = leadingAnchor.constraint(greaterThanOrEqualTo: view.trailingAnchor, constant: constant)
        constraint.isActive = true
        return constraint
    }
    
    /// Align trailing to another view
    @discardableResult func alignTrailingToView(view: UIView, constant: CGFloat = 0) -> NSLayoutConstraint? {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -constant)
        constraint.isActive = true
        return constraint
    }
    
    /// Pin trailing to another view's leading
    @discardableResult func pinTrailingToView(view: UIView, constant: CGFloat = 0) -> NSLayoutConstraint? {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = trailingAnchor.constraint(equalTo: view.leadingAnchor, constant: -constant)
        constraint.isActive = true
        return constraint
    }
    
    /// Pin trailing to another view's leading
    @discardableResult func pinMaxTrailingToView(view: UIView, constant: CGFloat = 0) -> NSLayoutConstraint? {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = trailingAnchor.constraint(lessThanOrEqualTo: view.leadingAnchor, constant: -constant)
        constraint.isActive = true
        return constraint
    }
    
    //----------------------------------------
    
    @discardableResult func pinToBottomMargin(constant: CGFloat = 0) -> NSLayoutConstraint? {
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            let bottomConstraint = bottomAnchor.constraint(equalTo: superview.layoutMarginsGuide.bottomAnchor, constant: constant)
            bottomConstraint.isActive = true
            return bottomConstraint
        }
        return nil
    }
    
    @discardableResult func pinToTopMargin(constant: CGFloat = 0) -> NSLayoutConstraint? {
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            let topconstraint = topAnchor.constraint(equalTo: superview.layoutMarginsGuide.topAnchor, constant: constant)
            topconstraint.isActive = true
            return topconstraint
        }
        return nil
    }
    
    func setMargins(top: CGFloat = 0, leading: CGFloat = 0, bottom: CGFloat = 0, trailing: CGFloat = 0) {
        if #available(iOS 11.0, *) {
            // Running iOS 11 OR NEWER
            directionalLayoutMargins = NSDirectionalEdgeInsets(top: top, leading: leading, bottom: bottom, trailing: trailing)
        } else {
            // Earlier version of iOS
            layoutMargins = UIEdgeInsets(top: top, left: leading, bottom: bottom, right: trailing)
        }
    }
}

public extension UIViewController {
    func setSafeAreaInsets(insets: UIEdgeInsets) {
        if #available(iOS 11.0, *) {
            self.additionalSafeAreaInsets = insets
        }
    }
}
