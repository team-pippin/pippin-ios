//
//  UIView+Shadow.swift
//  Pippin
//
//  Created by Will Brandin on 4/1/19.
//  Copyright © 2019 SchoolConnect. All rights reserved.
//

import UIKit

/// A struct that wraps shadow styles.
public struct LayerShadow: Equatable {
    
    // MARK: - Properties
    
    public let shadowColor: UIColor
    public let shadowOpacity: Float
    public let shadowRadius: CGFloat
    public let shadowOffset: CGSize
    
    // MARK: - Init
    
    public init(shadowColor: UIColor,
                shadowOpacity: Float,
                shadowRadius: CGFloat,
                shadowOffset: CGSize) {
        self.shadowColor = shadowColor
        self.shadowOpacity = shadowOpacity
        self.shadowRadius = shadowRadius
        self.shadowOffset = shadowOffset
    }
}

public extension UIView {
    
    // MARK: - Methods
    
    func setShadow(shadow: LayerShadow) {
        layer.shadowColor = shadow.shadowColor.cgColor
        layer.shadowOffset = shadow.shadowOffset
        layer.shadowRadius = shadow.shadowRadius
        layer.shadowOpacity = shadow.shadowOpacity
    }
}
