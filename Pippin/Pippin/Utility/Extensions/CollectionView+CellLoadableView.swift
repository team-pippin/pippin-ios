//
//  CollectionView+CellLoadableView.swift
//  Pippin
//
//  Created by Will Brandin on 4/13/19.
//  Copyright © 2019 SchoolConnect. All rights reserved.
//

import UIKit

/**
 CellLoadableView is a protocol for Reusable components such as Table View Cells or Collection View Cells.
 Overarching premise is that a default ReuseId is created with the class name.
 ie. MyCollectionCell will use "MyCollectionCell" as a reuseId.
 */
protocol CellLoadableView: class {
    ///Cell name will be the default id used.
    static var cellName: String { get }
}

extension CellLoadableView where Self: UIView {
    static var cellName: String {
        return String(describing: self)
    }
}

extension UITableView {
    
    func register<T: UITableViewCell>(_: T.Type) where T: CellLoadableView {
        register(T.self, forCellReuseIdentifier: T.cellName)
    }
    
    func deqeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T where T: CellLoadableView {
        guard let cell = dequeueReusableCell(withIdentifier: T.cellName, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.cellName)")
        }
        return cell
    }
}

extension UICollectionView {
    
    func register<T: UICollectionViewCell>(_: T.Type) where T: CellLoadableView {
        register(T.self, forCellWithReuseIdentifier: T.cellName)
    }
    
    func deqeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T where T: CellLoadableView {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.cellName, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.cellName)")
        }
        return cell
    }
}
