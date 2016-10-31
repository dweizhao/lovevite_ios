//
//  UIImage+effect.swift
//  lovevite
//
//  Created by Eason Leo on 2016/10/31.
//  Copyright © 2016年 lovevite. All rights reserved.
//

import Foundation

extension UIImage {
    
    func commonBlur() -> UIImage? {
        return blur(10)
    }
    
    func blur(value: CGFloat) -> UIImage? {
        return yy_imageByBlurRadius(value, tintColor: UIColor.init(white: 1.0, alpha: 0.3), tintMode: .Normal, saturation: 1.8, maskImage: nil)
    }
    
}
