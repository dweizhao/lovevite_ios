//
//  Const.swift
//  lovevite
//
//  Created by Eason Leo on 2016/9/28.
//  Copyright © 2016年 lovevite. All rights reserved.
//

import UIKit

class Const: NSObject {
    
    static let screenWidth = UIScreen.mainScreen().bounds.width
    
    static let screenHeight = UIScreen.mainScreen().bounds.height
    
    static func adaptionWidth(originalWidth: CGFloat) -> CGFloat {
        return originalWidth * 375.0 / screenWidth
    }
    
    static func adaptionHeight(originalHeight: CGFloat) -> CGFloat {
        return originalHeight * 667.0 / screenHeight
    }
    
    static let defaultInset: CGFloat = 15
    
}
