//
//  SingleLineTextTableViewCell.swift
//  Pippin
//
//  Created by Will Brandin on 4/13/19.
//  Copyright © 2019 SchoolConnect. All rights reserved.
//

import UIKit

class SingleLineTextTableViewCell: UITableViewCell, CellLoadableView {
    
    // MARK: - Properties
    
    private let titleLabel = UILabel()
    
    private var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
                
        titleLabel.font = Style.Font.p2Light
        titleLabel.textColor = Style.Color.secondaryTextDark
        
        contentView.addSubview(titleLabel)
        titleLabel.pinToLeadingMargin()
        titleLabel.pinToVerticalCenter()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func setCellContent(_ title: String) {
        self.title = title
    }
    
    func setCellStyle(_ style: SingleLineTextTableViewCellStyle) {
        titleLabel.font = style.titleFont
        titleLabel.textColor = style.titleColor
    }
}

class SingleLineTextTableViewCellStyle {
    var titleFont = Style.Font.p2Light
    var titleColor = Style.Color.secondaryTextDark
    init() {}
}

extension SingleLineTextTableViewCellStyle {
    static var standardStyle: SingleLineTextTableViewCellStyle {
        return SingleLineTextTableViewCellStyle()
    }
    
    static var boldStyle: SingleLineTextTableViewCellStyle {
        let style = SingleLineTextTableViewCellStyle()
        style.titleFont = Style.Font.p2
        return style
    }
}
