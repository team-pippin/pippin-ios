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
        
        static var primaryTextLight: UIColor = .white
        
        static var primaryTextDark: UIColor = .black
        
        static var secondaryTextLight: UIColor = .lightGray
        
        static var secondaryTextDark: UIColor = .darkGray
        
        static var actionableText: UIColor = .red
        
        static var action: UIColor = .blue
        
        static var secondaryAction: UIColor = .blue
        
        static var destructiveAction: UIColor = .red
        
        static var error: UIColor = .red
        
        static var interactiveTint: UIColor = .blue
        
        static var navigationAction: UIColor = .lightGray
        
        static var lightBackground: UIColor = .white
        
        static var darkBackground: UIColor = .black
        
        static var lightGray: UIColor = .lightGray
        
        static var darkGray: UIColor = .darkGray
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
        
        static var button: UIFont = UIFont(customFont: .OpenSans(.SemiBold), size: .body)!
        
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
