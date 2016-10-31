//
//  UIScreen+effect.swift
//  lovevite
//
//  Created by Eason Leo on 2016/10/31.
//  Copyright © 2016年 lovevite. All rights reserved.
//

import Foundation

extension UIScreen {
    
    // to capture the current screen view image.
    
    static func capture() -> UIImage? {
        return capture(UIApplication.sharedApplication().keyWindow!, size: mainScreen().bounds.size)
    }
    
    // to capture the view image with assign size.
    
    static func capture(view: UIView, size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContext(size)
        guard let ctx = UIGraphicsGetCurrentContext() else {
            return nil
        }
        view.layer.renderInContext(ctx)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result
    }
    
}
