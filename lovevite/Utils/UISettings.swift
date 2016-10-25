//
//  UISettings.swift
//  lovevite
//
//  Created by Eason Leo on 2016/10/24.
//  Copyright © 2016年 lovevite. All rights reserved.
//

import UIKit

struct UIConst {
    
    static var defaultInset: CGFloat {
        return 12.0
    }
    
}

struct Scale {
    
    static func width(w: CGFloat) -> CGFloat {
        return w * UIScreen.width / 375.0
    }
    
    static func height(h: CGFloat) -> CGFloat {
        return h * UIScreen.height / 667.0
    }
    
    static func selectHeight(iPhone4: CGFloat, iPhone5: CGFloat, iPhone6: CGFloat, iPhone6Plus: CGFloat) -> CGFloat {
        switch UIScreen.height {
        case 480:
            return iPhone4
        case 568:
            return iPhone5
        case 667:
            return iPhone6
        case 736:
            return iPhone6Plus
        default:
            return CGFloat.min
        }
    }
    
}
