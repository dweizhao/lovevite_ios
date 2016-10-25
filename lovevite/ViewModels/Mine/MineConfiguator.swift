//
//  MineConfiguator.swift
//  lovevite
//
//  Created by Eason Leo on 2016/10/24.
//  Copyright © 2016年 lovevite. All rights reserved.
//

import Foundation

class MineConfiguator: NSObject {
    
    func photosCount() -> Int {
        return 3
    }
    
    func photoImageURL(indexPath: NSIndexPath) -> NSURL? {
        return NSURL.init(string: "http://img6.bdstatic.com/img/image/smallpic/mingxing1020_copy.jpg")
    }
    
}
