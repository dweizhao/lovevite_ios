//
//  UIFont+default.swift
//  lovevite
//
//  Created by Eason Leo on 2016/9/28.
//  Copyright © 2016年 lovevite. All rights reserved.
//

import UIKit

extension UIFont {
    
    static func defaultWithSize(size: CGFloat) -> UIFont {
        return UIFont.systemFontOfSize(size)
    }
    
    static var title: UIFont {
        return UIFont.defaultWithSize(17.0)
    }
    
    static var button: UIFont {
        return UIFont.defaultWithSize(16.0)
    }
    
    static var body: UIFont {
        return UIFont.defaultWithSize(15.0)
    }
    
}

extension UIFont {
    
    static func title(weight: CGFloat) -> UIFont {
        if #available(iOS 8.2, *) {
            return UIFont.systemFontOfSize(17.0, weight: weight)
        } else {
            return UIFont.boldSystemFontOfSize(17.0)
        }
    }
    
    static func button(weight: CGFloat) -> UIFont {
        if #available(iOS 8.2, *) {
            return UIFont.systemFontOfSize(16.0, weight: weight)
        } else {
            return UIFont.boldSystemFontOfSize(16.0)
        }
    }
    
    static func body(weight: CGFloat) -> UIFont {
        if #available(iOS 8.2, *) {
            return UIFont.systemFontOfSize(15.0, weight: weight)
        } else {
            return UIFont.boldSystemFontOfSize(15.0)
        }
    }
    
}
