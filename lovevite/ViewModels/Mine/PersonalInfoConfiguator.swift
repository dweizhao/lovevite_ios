//
//  PersonalInfoConfiguator.swift
//  lovevite
//
//  Created by Eason Leo on 2016/10/24.
//  Copyright © 2016年 lovevite. All rights reserved.
//

import Foundation

class PersonalInfoConfiguator: NSObject {
    
    func sectionsCount() -> Int {
        return MineUserInterfaceContent.personalInfoModules.count
    }
    
    func cellsCount(sec: Int) -> Int {
        return MineUserInterfaceContent.personalInfoModules[sec].count
    }
    
    func cellTitle(indexPath: NSIndexPath) -> String {
        return MineUserInterfaceContent.personalInfoModules[indexPath.section][indexPath.row].es_ml()
    }
    
    func cellAllowSelected(indexPath: NSIndexPath) -> Bool {
        switch indexPath.section {
        case 0:
            return indexPath.row != 1
        case 1:
            return indexPath.row > 1
        default:
            return false
        }
    }
    
}
