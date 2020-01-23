//
//  EventCollectionViewCell.swift
//  Pippin
//
//  Created by Will Brandin on 1/23/20.
//  Copyright © 2020 SchoolConnect. All rights reserved.
//

import UIKit

class EventCollectionViewCell: UICollectionViewCell, CellLoadableView {
    
    // MARK: - SubViews
    
    private let titleLabel = UILabel(frame: .zero)

    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    func setupView() {
        contentView.addSubview(titleLabel)
        titleLabel.pinToMargins()
        titleLabel.text = "HELLO"
    }
}
