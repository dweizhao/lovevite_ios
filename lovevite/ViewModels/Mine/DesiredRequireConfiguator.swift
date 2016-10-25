//
//  DesiredRequiresCOnfiguator.swift
//  lovevite
//
//  Created by Eason Leo on 2016/10/24.
//  Copyright © 2016年 lovevite. All rights reserved.
//

import Foundation

class DesiredRequireConfiguator: NSObject {
    
    func sectionsCount() -> Int {
        return 1
    }
    
    func cellsCount(sec: Int) -> Int {
        return MineUserInterfaceContent.desiredRequiresTitle.count
    }
    
    func cellTitle(indexPath: NSIndexPath) -> String {
        return MineUserInterfaceContent.desiredRequiresTitle[indexPath.row].es_ml()
    }
    
    func cellAllowSelected(indexPath: NSIndexPath) -> Bool {
        return true
    }
    
}
