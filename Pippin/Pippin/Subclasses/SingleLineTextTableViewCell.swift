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
                
        titleLabel.font = Style.Font.p2
        titleLabel.textColor = Style.Color.primaryTextDark
        
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
}
