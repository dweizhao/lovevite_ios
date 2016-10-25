//
//  UIScreen.swift
//  lovevite
//
//  Created by Eason Leo on 2016/10/24.
//  Copyright © 2016年 lovevite. All rights reserved.
//

import Foundation

extension UIScreen {
    
    static var width: CGFloat {
        return UIScreen.mainScreen().bounds.width
    }
    
    static var height: CGFloat {
        return UIScreen.mainScreen().bounds.height
    }
    
    static var navigationBarHeight: CGFloat {
        return 64.0
    }
    
    static var tabBarHeight: CGFloat {
        return 48.0
    }
    
    static var center: CGPoint {
        return CGPoint.init(x: width / 2.0, y: height / 2.0)
    }
    
    static var size: CGSize {
        return UIScreen.mainScreen().bounds.size
    }
    
    static var frame: CGRect {
        return UIScreen.mainScreen().bounds
    }
    
    static var noneTabbarFrame: CGRect {
        return CGRect.init(x: 0, y: 0, width: width, height: height - tabBarHeight)
    }
    
}
