//
//  ESAnimation.swift
//  lovevite
//
//  Created by Eason Leo on 2016/10/27.
//  Copyright © 2016年 lovevite. All rights reserved.
//

import Foundation

class ESAnimation: NSObject {
    
    private var completion: (Bool -> Void)?
    
    private let privateAnimation = CABasicAnimation.init()
    
    convenience init(keyPath: String, duration: NSTimeInterval, fromValue: AnyObject, configuation: (CABasicAnimation -> Void)? = nil, completion: (Bool -> Void)?) {
        self.init()
        privateAnimation.keyPath = keyPath
        privateAnimation.duration = duration
        privateAnimation.fromValue = fromValue
        if let config = configuation {
            config(privateAnimation)
        }
        privateAnimation.delegate = self
        self.completion = completion
    }
    
}

extension ESAnimation: CAAnimationDelegate {
    
    var animation: CABasicAnimation {
        return privateAnimation
    }
    
    func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        if let com = completion {
            com(flag)
        }
    }
    
}
