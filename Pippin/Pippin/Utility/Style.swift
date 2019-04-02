//
//  Style.swift
//  Pippin
//
//  Created by Will Brandin on 4/1/19.
//  Copyright © 2019 SchoolConnect. All rights reserved.
//

import UIKit

struct Style {
   
    struct Color {
        
        private static let blue = UIColor(hex: "0090C1")
        private static let red = UIColor(hex: "E71D36")
        private static let green = UIColor(hex: "2EC4B6")
        private static let black = UIColor(hex: "050505")
        
        static var primaryTextLight: UIColor = .white
        
        static var primaryTextDark: UIColor = Style.Color.black
        
        static var secondaryTextLight: UIColor = .lightGray
        
        static var secondaryTextDark: UIColor = UIColor(hex: "252323")
        
        static var actionableText: UIColor = .white
        
        static var action: UIColor = Style.Color.blue
        
        static var secondaryAction: UIColor = Style.Color.green
        
        static var destructiveAction: UIColor = Style.Color.red
        
        static var error: UIColor = Style.Color.red
        
        static var interactiveTint: UIColor = Style.Color.blue.withAlphaComponent(0.7)
        
        static var navigationAction: UIColor = Style.Color.black//UIColor(hex: "D1D1D1")
        
        static var lightBackground: UIColor = .white
        
        static var darkBackground: UIColor = .black
        
        static var lightGray: UIColor = .lightGray
        
        static var darkGray: UIColor = UIColor(hex: "252323")
    }
    
    struct Font {
        
        static var h1: UIFont = UIFont(customFont: .OpenSans(.SemiBold), size: .largeTitle)!
        
        static var h2: UIFont = UIFont(customFont: .OpenSans(.SemiBold), size: .Title1)!
        
        static var h3: UIFont = UIFont(customFont: .OpenSans(.Bold), size: .headline)!
        
        static var p1: UIFont = UIFont(customFont: .OpenSans(.Regular), size: .body)!
        
        static var p2: UIFont = UIFont(customFont: .OpenSans(.SemiBold), size: .body)!
        
        static var p2Light: UIFont = UIFont(customFont: .OpenSans(.Light), size: .body)!
        
        static var p2Bold: UIFont = UIFont(customFont: .OpenSans(.Bold), size: .body)!
        
        static var mini: UIFont = UIFont(customFont: .OpenSans(.Regular), size: .caption)!
        
        static var miniBold: UIFont = UIFont(customFont: .OpenSans(.SemiBold), size: .caption)!
        
        static var button: UIFont = UIFont(customFont: .OpenSans(.Bold), size: .body)!
        
        static var navigationTitle: UIFont = UIFont(customFont: .OpenSans(.SemiBold), size: .headline)!
        
        static var navigationButton: UIFont = UIFont(customFont: .OpenSans(.SemiBold), size: .body)!
    }
    
    struct Layout {
        // MarginXL 32 Points
        static var marginXL: CGFloat { return 32.0 }
        /// Margin 16 points
        static var margin: CGFloat { return 16.0 }
        
        /// innerSpacing 8 points
        static var innerSpacing: CGFloat { return 8.0 }
        
        /// Single line cell height 48 points
        static var cellHeight: CGFloat { return 48.0 }
        
        static var textFieldHeight: CGFloat { return 52.0 }
    }
}
