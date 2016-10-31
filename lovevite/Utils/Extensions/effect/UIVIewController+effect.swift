//
//  UIVIewController+effect.swift
//  lovevite
//
//  Created by Eason Leo on 2016/10/31.
//  Copyright © 2016年 lovevite. All rights reserved.
//

import Foundation

extension UIViewController {
    
    func setBackgroundBlur(image: UIImage?) {
        guard let blurImage = image else { return }
        let blurImageView = UIImageView(frame: view.frame)
        blurImageView.image = blurImage
        blurImageView.alpha = 0
        view.addSubview(blurImageView)
        view.sendSubviewToBack(blurImageView)
    }
    
}
