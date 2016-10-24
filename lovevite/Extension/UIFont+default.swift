//
//  UIFont+default.swift
//  lovevite
//
//  Created by Eason Leo on 2016/9/28.
//  Copyright © 2016年 lovevite. All rights reserved.
//

import UIKit

extension UIFont {
    
    static func title(weight: CGFloat? = nil) -> UIFont {
        if weight != nil {
            if #available(iOS 8.2, *) {
                return UIFont.systemFontOfSize(UIFont.labelFontSize(), weight: weight!)
            } else {
                return UIFont.boldSystemFontOfSize(UIFont.labelFontSize())
            }
        }
        return UIFont.systemFontOfSize(UIFont.labelFontSize())
    }
    
    static func body(weight: CGFloat? = nil) -> UIFont {
        if weight != nil {
            if #available(iOS 8.2, *) {
                return UIFont.systemFontOfSize(15.0, weight: weight!)
            } else {
                return UIFont.boldSystemFontOfSize(15.0)
            }
        }
        return UIFont.systemFontOfSize(15.0)
    }
    
    static func button(weight: CGFloat? = nil) -> UIFont {
        if weight != nil {
            if #available(iOS 8.2, *) {
                return UIFont.systemFontOfSize(UIFont.buttonFontSize(), weight: weight!)
            } else {
                return UIFont.boldSystemFontOfSize(UIFont.labelFontSize())
            }
        }
        return UIFont.systemFontOfSize(UIFont.buttonFontSize())
    }
    
}
