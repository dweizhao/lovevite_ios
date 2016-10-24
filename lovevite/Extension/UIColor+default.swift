//
//  UIColor+default.swift
//  lovevite
//
//  Created by Eason Leo on 2016/9/27.
//  Copyright © 2016年 lovevite. All rights reserved.
//

import UIKit

extension UIColor {
    
    static func color(hexValue hex: Int, alphaValue alpha: CGFloat) -> UIColor {
        return UIColor.init(red: CGFloat((hex & 0xFF0000) >> 16) / 255.0, green: CGFloat((hex & 0x00FF00) >> 8) / 255.0, blue: CGFloat(hex & 0x0000FF) / 255.0, alpha: alpha)
    }
    
    static func color(hexValue hex: Int) -> UIColor {
        return color(hexValue: hex, alphaValue: 1)
    }
    
    static func theme() -> UIColor {
        return UIColor.color(hexValue: 0xE74614)
    }
    
    static func background() -> UIColor {
        return UIColor.color(hexValue: 0xF0F0F0)
    }
    
    static func textTitle() -> UIColor {
        return UIColor.color(hexValue: 0x222222)
    }
    
    static func textBody() -> UIColor {
        return UIColor.color(hexValue: 0x000000)
    }
    
}
