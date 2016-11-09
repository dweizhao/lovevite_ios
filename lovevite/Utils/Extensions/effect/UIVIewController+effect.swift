//
//  UIVIewController+effect.swift
//  lovevite
//
//  Created by Eason Leo on 2016/10/31.
//  Copyright © 2016年 lovevite. All rights reserved.
//

import Foundation

extension UIViewController {
    
    func setBackgroundBlur(blurImage: UIImage?) {
        guard let image = blurImage else {
            return
        }
        let blurImageView = UIImageView(frame: view.frame)
        blurImageView.image = image
        view.addSubview(blurImageView)
        view.sendSubviewToBack(blurImageView)
    }
    
    func setBackgroundBlurAnimation(original: UIImage?, blur: UIImage?) {
        guard let img1 = original, let img2 = blur else {
            return
        }
        view.layer.contents = img1.CGImage
        let blurImageView = UIImageView(frame: view.frame)
        blurImageView.image = img2
        blurImageView.alpha = 0
        view.addSubview(blurImageView)
        view.sendSubviewToBack(blurImageView)
        UIView.animateWithDuration(0.3, animations: { 
            blurImageView.alpha = 1
        })
    }
    
}
