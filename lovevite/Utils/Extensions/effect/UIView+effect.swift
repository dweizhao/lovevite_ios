//
//  UIView+effect.swift
//  lovevite
//
//  Created by Eason Leo on 2016/10/31.
//  Copyright © 2016年 lovevite. All rights reserved.
//

import Foundation

extension UIView {
    
    func setShadow() {
        layer.shadowRadius = 4
        layer.shadowOpacity = 0.2
        layer.shadowOffset  = CGSize(width: 0, height: 3)
    }
    
}
