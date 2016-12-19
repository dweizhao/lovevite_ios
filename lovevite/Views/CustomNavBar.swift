//
//  CustomNavBar.swift
//  SpeedInfinite
//
//  Created by Mango on 16/6/18.
//  Copyright © 2016年 TM. All rights reserved.
//

import UIKit

@objc protocol CustomNavBarDelegate {
    optional func backButtonDidTapped(navBar: CustomNavBar)
}

class CustomNavBar: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUserInterface()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let disposeBag = DisposeBag()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        self.addSubview(label)
        label.textColor = UIColor.whiteColor()
        label.font = UIFont.title
        label.snp_makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self).offset(UIScreen.statusBarHeight / 2.0)
        }
        return label
    }()
    
    // default is hidden.
    lazy var backNavButton: UIButton = {
        let button = UIButton(type: .System)
        button.hidden = true
        button.setImage(UIImage.init(named: "nav_common_back")?.imageWithRenderingMode(.AlwaysOriginal), forState: .Normal)
        button.rx_tap.subscribeNext({ [weak self] in
            guard let `self` = self else {
                return
            }
            self.viewController?.navigationController?.popViewControllerAnimated(true)
            self.delegate?.backButtonDidTapped?(self)
        }).addDisposableTo(self.disposeBag)
        return button
    }()

    weak var viewController: UIViewController?
    
    weak var delegate: CustomNavBarDelegate?
    
    var leftView: UIView?
    
    var rightView: UIView?
    
    let bottomMargin: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.strokeColor = UIColor(white: 1, alpha: 0.2).CGColor
        layer.lineWidth = UIScreen.onePix
        let path = UIBezierPath()
        path.moveToPoint(CGPointMake(0, UIScreen.navigationBarHeight))
        path.addLineToPoint(CGPointMake(UIScreen.width, UIScreen.navigationBarHeight))
        layer.path = path.CGPath
        return layer
    }()
    
}

extension CustomNavBar {
    
    private func initUserInterface() {
        self.layer.addSublayer(bottomMargin)
        backgroundColor = UIColor.main
    }
    
    var title: String? {
        set {
            titleLabel.text = newValue
        }
        get {
            return titleLabel.text
        }
    }
    
    private func setLeftView(view: UIView?) {
        if let view = view {
            self.addSubview(view)
            view.snp_makeConstraints { make in
                make.centerY.equalTo(self).offset(UIScreen.statusBarHeight / 2.0)
                make.left.equalTo(self).offset(8.0)
                make.height.equalTo(24.0)
                make.width.equalTo(58.0)
            }
        }
        leftView = view
    }
    
    private func setRightView(view: UIView?) {
        if let view = view {
            self.addSubview(view)
            view.snp_makeConstraints(closure: { (make) in
                make.centerY.equalTo(self).offset(UIScreen.statusBarHeight / 2.0)
                make.right.equalTo(self)
                make.height.equalTo(24.0)
                make.width.equalTo(58.0)
            })
        }
        rightView = view
    }
    
}

extension CustomNavBar {
    
    func addRightView(view: UIView?) {
        if rightView != nil {
            return
        }
        setRightView(view)
    }
    
}

// MARK: - convenience init

extension CustomNavBar {
    
    /**
     传入viewController后 backButton 会出现，并且自带pop响应事件
     navBar也会被加载到该viewController上
     
     - parameter title:          标题
     - parameter viewController: 当前viewController
     - parameter rightView:      右视图
     
     */
    
    convenience init(title: String?, viewController: UIViewController?, rightView: UIView? = nil) {
        self.init(title: title, leftView: nil, rightView: rightView)
        
        if let vc = viewController {
            vc.navigationController?
                .interactivePopGestureRecognizer?.delegate = vc as? UIGestureRecognizerDelegate
            self.viewController = vc
            backNavButton.hidden = false
            setLeftView(backNavButton)
        }
    }
    
    convenience init(title: String?, leftView: UIView? = nil, rightView: UIView? = nil) {
        self.init(frame: CGRectMake(0, 0, UIScreen.width, UIScreen.navigationBarHeight))
        
        self.title = title
        
        setLeftView(leftView)
        setRightView(rightView)
    }
    
    convenience init(viewContrller: UIViewController?, cancelAndSureStyleWithTitle title: String?) {
        let sureButton = UIButton(type: .System)
        self.init(title: title, viewController: viewContrller,rightView: sureButton)
        sureButton.setTitle("确定".es_ml(), forState: .Normal)
        sureButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        sureButton.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 0.5), forState: .Disabled)
        backNavButton.setImage(nil, forState: .Normal)
        backNavButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        backNavButton.setTitle("取消".es_ml(), forState: .Normal)
    }
    
}
