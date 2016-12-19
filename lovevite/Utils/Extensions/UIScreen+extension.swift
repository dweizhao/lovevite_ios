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
    
    static var onePix: CGFloat {
        return 1.0 / UIScreen.mainScreen().scale
    }
    
    static var navigationBarHeight: CGFloat {
        return 64.0
    }
    
    static var statusBarHeight: CGFloat {
        return 20.0
    }
    
    static var tabBarHeight: CGFloat {
        return 49.0
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
    
    static func frame(inset: UIEdgeInsets) -> CGRect {
        return CGRect.init(x: inset.left, y: inset.top, width: width - inset.left - inset.right, height: height - inset.top - inset.bottom)
    }
    
    static var noneNavibarFrame: CGRect {
        return CGRect.init(x: 0, y: UIScreen.navigationBarHeight, width: UIScreen.width, height: UIScreen.height - UIScreen.navigationBarHeight)
    }
    
    static var noneTabbarFrame: CGRect {
        return CGRect.init(x: 0, y: 0, width: width, height: height - tabBarHeight)
    }
    
    static var noneNavTabBarFrame: CGRect {
        return CGRect.init(x: 0, y: navigationBarHeight, width: width, height: height - navigationBarHeight - tabBarHeight)
    }
    
}
