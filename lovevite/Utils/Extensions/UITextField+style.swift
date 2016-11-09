//
//  UITextField+style.swift
//  lovevite
//
//  Created by Eason Leo on 2016/10/31.
//  Copyright © 2016年 lovevite. All rights reserved.
//

import Foundation

extension UITextField {
    
    func setCommonStyle(placeHolderString: String?) {
        backgroundColor = UIColor.clearColor()
        placeholder = placeHolderString
        textColor = UIColor.text
        font = UIFont.body
    }
    
    func setLikeUserNameStyle(placeHolderString: String?) {
        setCommonStyle(placeHolderString)
        autocorrectionType = .No
        autocapitalizationType = .None
        keyboardType = .EmailAddress
    }
    
    func setLikePasswordStyle(placeHolderString: String?) {
        setCommonStyle(placeHolderString)
        autocorrectionType = .No
        autocapitalizationType = .None
        secureTextEntry = true
    }
    
}
