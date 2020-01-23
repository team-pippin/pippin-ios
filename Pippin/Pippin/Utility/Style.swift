//
//  Style.swift
//  Pippin
//
//  Created by Will Brandin on 4/1/19.
//  Copyright © 2019 SchoolConnect. All rights reserved.
//

import UIKit

struct Style {
    
    public static var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    public static var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    struct Table {
        static let listCellHeight: CGFloat = 64.0
        static let defaultSectionHeaderHeight: CGFloat = 32.0
        static let cardHeight: CGFloat = 72.0
    }
   
    struct Separator {
        static let height: CGFloat = 1.0
    }
    
    // TODO: - Pallete
    struct Color {
        
        private static let blue = UIColor(hex: "0090C1")
        private static let red = UIColor(hex: "E71D36")
        private static let green = UIColor(hex: "2EC4B6")
        private static let lightGray = UIColor(red: 183 / 255, green: 187 / 255, blue: 192 / 255, alpha: 1)
        private static let mediumGray = UIColor(red: 126 / 255, green: 129 / 255, blue: 131 / 255, alpha: 1)
        private static let darkGrey = UIColor(red: 71 / 255, green: 76 / 255, blue: 81 / 255, alpha: 1)
        
        static var primaryTextLight: UIColor = .white
        
        static var primaryTextDark: UIColor = Style.Color.darkGrey
        
        static var secondaryTextLight: UIColor = Style.Color.lightGray
        
        static var secondaryTextDark: UIColor = Style.Color.mediumGray
        
        static var actionableText: UIColor = .white
        
        static var action: UIColor = Style.Color.green
        
        static var secondaryAction: UIColor = Style.Color.blue
        
        static var destructiveAction: UIColor = Style.Color.red
        
        static var error: UIColor = Style.Color.red
        
        static var interactiveTint: UIColor = Style.Color.green.withAlphaComponent(0.7)
        
        static var navigationAction: UIColor = Style.Color.darkGrey//UIColor(hex: "D1D1D1")
        
        static var lightBackground: UIColor = .white
                
        static var darkBackground: UIColor = .black
    }
    
    struct Font {
        
        static var h1: UIFont = UIFont(customFont: .Avenir(.Black), size: .largeTitle)!
        
        static var h2: UIFont = UIFont(customFont: .Avenir(.Black), size: .Title1)!
        
        static var h3: UIFont = UIFont(customFont: .Avenir(.Heavy), size: .headline)!
        
        static var p1: UIFont = UIFont(customFont: .Avenir(.Medium), size: .body)!
        
        static var p2: UIFont = UIFont(customFont: .Avenir(.Black), size: .body)!
        
        static var p2Light: UIFont = UIFont(customFont: .Avenir(.Roman), size: .body)!
        
        static var p2Bold: UIFont = UIFont(customFont: .Avenir(.Heavy), size: .body)!
        
        static var mini: UIFont = UIFont(customFont: .Avenir(.Medium), size: .caption)!
        
        static var miniBold: UIFont = UIFont(customFont: .Avenir(.Black), size: .caption)!
        
        static var button: UIFont = UIFont(customFont: .Avenir(.Black), size: .body)!
        
        static var navigationTitle: UIFont = UIFont(customFont: .Avenir(.Black), size: .headline)!
        
        static var navigationButton: UIFont = UIFont(customFont: .Avenir(.Heavy), size: .body)!
    }
    
    struct Layout {
        // MarginXL 32 Points
        static var marginXL: CGFloat { return 32.0 }
        /// Margin 16 points
        static var margin: CGFloat { return 16.0 }
        
        /// innerSpacing 8 points
        static var innerSpacing: CGFloat { return 8.0 }
        
        /// Single line cell height 72 points
        static var cellHeight: CGFloat { return 72 }
        
        static var textFieldHeight: CGFloat { return 52.0 }
    }
}
