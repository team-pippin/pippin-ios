//
//  UIFont+CustomFonts.swift
//  Pippin
//
//  Created by Will Brandin on 4/1/19.
//  Copyright © 2019 SchoolConnect. All rights reserved.
//

import Foundation
import UIKit

extension UIFont { // swiftlint:disable nesting
    
    /**
     Initializes a font using the given `CustomFont` and `textStyle`. Preserving the
     point size of the `UIFontTextStyle` passed.
     
     - parameters:
     - customFont: The font to be generated, includes styling.
     - textStyle: The `UIFontTextStyle` from which the font's
     `pointSize` is to be derived.
     
     ````
     let font = UIFont(.GothamNarrowSSm(.Book), withSizeOf: .body)
     ````
     */
    convenience init?(customFont: CustomFont, size fontSize: StandardSize) {
        
        self.init(name: customFont.name, size: CGFloat(fontSize.rawValue))
    }
    
    /**
     Initializes a font using the given font `family` and attempts to preserve
     the font attributes for preferred font descriptor of the `UIFontTextStyle` passed.
     
     - parameters:
     - family: The target font family for the generated font.
     - textStyle: The text style from which to copy font descriptor attributes.
     See `UIFontTextStyle` for valid values.
     
     ````
     let font = UIFont(family: CustomFont.GothamNarrowSSm(.Book).family, withAttributesOf: .body)
     ````
     */
    //    convenience init?(family: String, withAttributesOf textStyle: UIFontTextStyle) {
    //
    //        let styleDescriptor  = UIFontDescriptor.preferredFontDescriptor(withTextStyle: textStyle)
    //        var attributes       = styleDescriptor.fontAttributes
    //
    //        attributes.removeValue(forKey: UIFontDescriptor.AttributeName(rawValue: "NSCTFontUIUsageAttribute"))
    //
    //        let familyDescriptor = UIFontDescriptor(fontAttributes: attributes).withFamily(family)
    //
    //        self.init(descriptor: familyDescriptor, size: 0.0)
    //    }
    
    convenience init?(customFont: CustomFont, size pointSize: CGFloat) {
        
        self.init(name: customFont.name, size: pointSize)
    }
}

enum StandardSize: Double {
    case largeTitle = 40.0
    case Title1     = 32.0
    case Title2     = 24.0
    case headline   = 18.0
    case body       = 16.0
    case caption    = 11.0
}

enum CustomFont {
    
    case Avenir(Styles.Avenir)
    
    var name: String {
        switch self {
        case .Avenir(let style):
            return "\(family.replacingOccurrences(of: " ", with: ""))-\(style.rawValue)"
        }
    }
    
    var family: String {
        switch self {
        case .Avenir:
            return "Avenir"
        }
    }
    
    struct Styles {
        
        enum Avenir: String {
            case Black
            case Medium
            case Roman
            case Heavy
        }
    }
}
