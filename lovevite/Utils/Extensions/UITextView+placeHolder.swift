//
//  UITextView+placeHolder.swift
//  lovevite
//
//  Created by Eason Leo on 2016/11/14.
//  Copyright © 2016年 lovevite. All rights reserved.
//

import Foundation

extension UITextView {
    
    private struct OnceToken {
        static var addPlaceholder = dispatch_once_t()
        static var placeHolderLabel = dispatch_once_t()
    }
    
    private var placeHolderDisposeBag: DisposeBag {
        return UITextView.disposeBag
    }
    
    private static let disposeBag = DisposeBag()
    
    class func addPlaceholder() {
        dispatch_once(&OnceToken.addPlaceholder) {
            let originalMethod = class_getInstanceMethod(self, Selector("setFont:"))
            let swizzledMethod = class_getInstanceMethod(self, #selector(mm_setFont(_:)))
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
    }
    
    @objc private func mm_setFont(font: UIFont?) {
        mm_setFont(font)
        placeholderLabel.font = font
        rx_text.map({ (text) -> Bool in
            return text.characters.count > 0
        }).distinctUntilChanged().subscribeNext { [weak self] isHaveText in
            if self?.placeholderLabel.hidden == false {
                if isHaveText {
                    self?.placeholderLabel.hidden = true
                }
            } else {
                if !isHaveText {
                    self?.placeholderLabel.hidden = false
                }
            }
        }.addDisposableTo(placeHolderDisposeBag)
    }
    
    @objc dynamic var placeholderLabel: UILabel {
        set {
            objc_setAssociatedObject(self, &OnceToken.placeHolderLabel, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            var label = objc_getAssociatedObject(self, &OnceToken.placeHolderLabel) as? UILabel
            if label == nil {
                label = UILabel()
                label?.textColor = UIColor.textGray
                label?.numberOfLines = 2
                self.placeholderLabel = label!
                addSubview(label!)
                label?.snp_makeConstraints(closure: { (make) in
                    make.left.equalTo(8)
                    make.top.equalTo(7)
                    make.width.equalTo(self).offset(-16)
                })
            }
            return label!
        }
    }
    
    @objc var placeholder: String? {
        set {
            placeholderLabel.text = newValue
        }
        get {
            return placeholderLabel.text
        }
    }
    
}

