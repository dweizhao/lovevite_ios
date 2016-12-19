//
//  PictureDescriptionView.swift
//  lovevite
//
//  Created by Eason Leo on 2016/11/14.
//  Copyright © 2016年 lovevite. All rights reserved.
//

import UIKit

class PictureDescriptionView: UIView {
    
    var descriptionText: String? {
        willSet {
            textView.text = newValue
            textView.scrollEnabled = false
        }
    }
    
    var dateText: String? {
        willSet {
            dateLabel.text = newValue
        }
    }
    
    private let disposeBag = DisposeBag()
    
    private let textView = UITextView()
    
    private let dateLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        textView.shouldAutoSize = true
        UITextView.es_maxHeight = (UIScreen.height - UIScreen.navigationBarHeight - UIScreen.width) / 2.0 - UIScreen.tabBarHeight - 10.0
        textView.textColor = UIColor.text
        textView.font = UIFont.subtitle
        textView.placeholder = "添加标题".es_ml()
        textView.showsHorizontalScrollIndicator = false
        textView.showsVerticalScrollIndicator = false
        textView.delegate = self
        addSubview(textView)
        
        dateLabel.backgroundColor = UIColor.whiteColor()
        dateLabel.textColor = UIColor.textGray
        dateLabel.font = UIFont.body
        dateLabel.textAlignment = .Right
        addSubview(dateLabel)
        
        NSNotificationCenter.defaultCenter()
            .rx_notification(UIKeyboardWillShowNotification).filter { [weak self] _ -> Bool in
                return self?.textView.isFirstResponder() ?? false
        }.subscribeNext { [weak self] notification in
            let height = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? CGRect)?.height ?? 298.0
            guard let `self` = self else {
                return
            }
            var bottom: CGFloat = -height - self.inputFinishedView.frame.height + UIScreen.tabBarHeight + 2.0
            if #available(iOS 10.1, *) {
                bottom = bottom + self.inputFinishedView.frame.height
            }
            self.textView.snp_updateConstraints(closure: { (make) in
                make.bottom.equalTo(bottom)
            })
            self.layoutIfNeeded()
        }.addDisposableTo(disposeBag)
        
        NSNotificationCenter.defaultCenter()
            .rx_notification(UIKeyboardWillHideNotification).filter { [weak self] _ -> Bool in
                return self?.textView.isFirstResponder() ?? false
        }.subscribeNext { [weak self] notification in
            guard let `self` = self else {
                return
            }
            self.textView.snp_updateConstraints(closure: { (make) in
                make.bottom.equalTo(-20.0)
            })
            self.layoutIfNeeded()
        }.addDisposableTo(disposeBag)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var inputFinishedView: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.width, height: 40))
        view.backgroundColor = UIColor.whiteColor()
        
        let separator = CAShapeLayer()
        let linePath = UIBezierPath.init()
        linePath.moveToPoint(CGPoint.init(x: 0, y: 0))
        linePath.addLineToPoint(CGPoint.init(x: UIScreen.width, y: 0))
        separator.path = linePath.CGPath
        separator.lineWidth = 1.0
        separator.strokeColor = UIColor.bgDarkGray.CGColor
        view.layer.addSublayer(separator)
        
        let cancel = UIButton.custom("取消".es_ml())
        cancel.frame = CGRectMake(0, 0, UIScreen.width / 2.0, 40)
        cancel.tintColor = UIColor.textGray
        view.addSubview(cancel)
        
        let finished = UIButton.custom("完成".es_ml())
        finished.frame = CGRectMake(UIScreen.width / 2.0, 0, UIScreen.width / 2.0, 40)
        finished.tintColor = UIColor.main
        view.addSubview(finished)
        
        cancel.rx_tap.subscribeNext({ [weak self] _ in
            self?.textView.resignFirstResponder()
        }).addDisposableTo(self.disposeBag)
        
        finished.rx_tap.subscribeNext({ [weak self] _ in
            self?.textView.resignFirstResponder()
        }).addDisposableTo(self.disposeBag)
        
        return view
    }()
    
}

extension PictureDescriptionView {
    
    override func updateConstraints() {
        super.updateConstraints()
        textView.snp_makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.bottom.equalTo(-20.0)
            make.top.greaterThanOrEqualTo(0)
        }
        dateLabel.snp_makeConstraints { (make) in
            make.left.bottom.right.equalTo(0)
            make.height.equalTo(20.0)
        }
    }
    
}

extension PictureDescriptionView: UITextViewDelegate {
    
    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        if textView == self.textView {
            textView.inputAccessoryView = inputFinishedView
        }
        return true
    }
    
}
