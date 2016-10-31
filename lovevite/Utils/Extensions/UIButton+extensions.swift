//
//  UIButton+extensions.swift
//  lovevite
//
//  Created by Eason Leo on 2016/10/26.
//  Copyright © 2016年 lovevite. All rights reserved.
//

import Foundation

extension UIButton {
    
    static func custom(title: String) -> UIButton {
        let btn = UIButton.init(type: UIButtonType.System)
        btn.setTitle(title, forState: .Normal)
        return btn
    }
    
}
