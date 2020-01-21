//
//  SettingsViewModel.swift
//  Pippin
//
//  Created by Will Brandin on 4/18/19.
//  Copyright © 2019 SchoolConnect. All rights reserved.
//

import UIKit

enum SettingsOption: Int, CaseIterable {
    case accountInfo
    case schoolPicker
    case logout
    
    var title: String {
        switch self {
        case .accountInfo: return "Account Info"
        case .schoolPicker: return "Change School"
        case .logout: return "Logout"
        }
    }
    
    var cellAccessory: UITableViewCell.AccessoryType {
        switch self {
        case .logout:
            return .none
        default:
            return .disclosureIndicator
        }
    }
    
    var cellStyle: SingleLineTextTableViewCellStyle {
        switch self {
        case .logout:
            return .standardStyle
        default:
            return .boldStyle
        }
    }
}

protocol SettingsViewModelProtocol: class {
    var onSelected: ((SettingsOption) -> Void)? { get set }
    
    var numberOfRows: Int { get }
    var numberOfSections: Int { get }
    
    func cellFor(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell
    func didSelect(at indexPath: IndexPath)
}

class SettingsViewModel: SettingsViewModelProtocol {
    
    // MARK: - Properties

    var onSelected: ((SettingsOption) -> Void)?
    
    var numberOfRows: Int {
        return SettingsOption.allCases.count
    }
    
    var numberOfSections: Int {
        return 1
    }
    
    // MARK: - Methods
    
    func cellFor(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        let cell: SingleLineTextTableViewCell = tableView.deqeueReusableCell(for: indexPath)
        cell.setCellContent(SettingsOption.allCases[indexPath.row].title)
        cell.accessoryType = SettingsOption.allCases[indexPath.row].cellAccessory
        cell.setCellStyle(SettingsOption.allCases[indexPath.row].cellStyle)
        return cell
    }
    
    func didSelect(at indexPath: IndexPath) {
        onSelected?(SettingsOption.allCases[indexPath.row])
    }
}
