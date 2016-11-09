//
//  UINavigationController+display.swift
//  lovevite
//
//  Created by Eason Leo on 2016/10/31.
//  Copyright © 2016年 lovevite. All rights reserved.
//

import Foundation

extension UINavigationController {
    
    func setCommonStyle() {
        navigationBar.setBackgroundImage(UIImage.yy_imageWithColor(UIColor.main), forBarMetrics: .Default)
        navigationBar.tintColor = UIColor.whiteColor()
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor(), NSFontAttributeName:UIFont.title]
    }
    
}
