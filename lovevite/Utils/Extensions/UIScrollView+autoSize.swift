//
//  UIScrollView+autoSize.swift
//  lovevite
//
//  Created by Eason Leo on 2016/11/14.
//  Copyright © 2016年 lovevite. All rights reserved.
//

import Foundation

extension UIScrollView {
    
    private struct AssociatedKey {
        static var shouldAutoFitSize = 0
    }
    
    private struct OnceToken {
        static var methodsSwizzled = dispatch_once_t()
    }
    
    @objc var shouldAutoSize: Bool {
        set {
            UITextView.es_maxHeight = nil
            objc_setAssociatedObject(self, &AssociatedKey.shouldAutoFitSize, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            scrollEnabled = !shouldAutoSize
        }
        get {
            return (objc_getAssociatedObject(self, &AssociatedKey.shouldAutoFitSize) as? Bool) ?? false
        }
    }
    
    class func prepareAutoSize() {
        dispatch_once(&OnceToken.methodsSwizzled) {
            let originalMethod = class_getInstanceMethod(UITextView.self, Selector("setContentSize:"))
            let swizzledMethod = class_getInstanceMethod(UITextView.self, #selector(mm_setContentSize(_:)))
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
    }
    
    static var es_maxHeight: CGFloat?
    
    func mm_setContentSize(contentSize: CGSize) {
        mm_setContentSize(contentSize)
        if shouldAutoSize {
            if let textView = self as? UITextView {
                textView.scrollEnabled = true
                let textFrame = textView.layoutManager.usedRectForTextContainer(textView.textContainer)
                var height = textFrame.height + 20.0
                if let maxHeight = UITextView.es_maxHeight {
                    height = height > maxHeight ? maxHeight : height
                }
                textView.snp_updateConstraints(closure: { (make) in
                    make.height.equalTo(height)
                })
            } else {
                self.snp_updateConstraints { (make) in
                    make.height.equalTo(contentSize.height)
                }
            }
        }
    }
    
}
