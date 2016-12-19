//
//  SettingsUserInterfaceConfigurator.swift
//  lovevite
//
//  Created by Eason Leo on 2016/9/27.
//  Copyright © 2016年 lovevite. All rights reserved.
//

import UIKit

class SettingsUserInterfaceConfigurator: NSObject {
    
    private let uiContent = SettingsUserInterfaceContent()
    
    func title() -> String {
        return uiContent.viewControllerTitle.es_ml()
    }
    
    func signOutBtnTitle() -> String {
        return uiContent.signOutButtonTitle.es_ml()
    }
    
    func headersCount() -> Int {
        return uiContent.headerTitles.count
    }
    
    func cellsCount(section: Int) -> Int {
        return uiContent.cellTitles[section]?.count ?? 0
    }
    
    func headerTitle(section: Int) -> String? {
        if section < headersCount() {
            return uiContent.headerTitles[section].es_ml()
        }
        return nil
    }
    
    func cellTitle(indexPath: NSIndexPath) -> String? {
        if indexPath.section < cellsCount(indexPath.section) {
            let arr = uiContent.cellTitles[indexPath.section] as Array<String>!
            if indexPath.row < arr.count {
                return arr[indexPath.row].es_ml()
            }
        }
        return nil
    }
    
    func cellHeight(indexPath: NSIndexPath) -> CGFloat {
        return 44.0
    }
    
    func headerHeight(section: Int) -> CGFloat {
        return 40.0
    }

}

extension SettingsUserInterfaceConfigurator {
    
    enum SettingsRightViewType {
        case Empty
        case Label
        case Switch
    }
    
    func findRightViewType(indexPath: NSIndexPath) -> SettingsRightViewType {
        if indexPath.section == 0 {
            return .Label
        } else if indexPath.section == 1 {
            return .Switch
        } else if indexPath.section == 2 {
            return .Switch
        } else {
            return .Empty
        }
    }
    
    func checkCellAccessoryType(indexPath: NSIndexPath) -> UITableViewCellAccessoryType {
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                return .None
            default:
                return .DisclosureIndicator
            }
        } else if indexPath.section == 3 {
            return .DisclosureIndicator
        } else {
            return .None
        }
    }
    
}
