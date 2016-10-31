//
//  LoginViewController.swift
//  lovevite
//
//  Created by Eason Leo on 2016/10/31.
//  Copyright © 2016年 lovevite. All rights reserved.
//

import Foundation

class LoginViewController: BaseViewController {
    
    
}

extension LoginViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    override func initialize() {
        title = "登录"
        
        let whiteView = UIView()
        whiteView.backgroundColor = UIColor.clearColor()
        whiteView.layer.contents = UIImage(named: "login_text_bg")?.CGImage
        whiteView.setShadow()
        
        view.addSubview(whiteView)
        whiteView.snp_makeConstraints { (make) in
            make.top.equalTo(view.snp_centerY).offset(-Scale.height(40))
            make.left.equalTo(UIConst.defaultInset)
            make.right.equalTo(-UIConst.defaultInset)
        }
        
        //MARK: username textfied
        
        let username = UITextField()
        username.setCommonStyle("用户名/邮箱/手机号".es_ml())
        username.delegate = self
        
        whiteView.addSubview(username)
        username.snp_makeConstraints { (make) in
            make.top.right.equalTo(whiteView)
            make.left.equalTo(UIConst.defaultInset)
            make.height.equalTo(50)
        }
        
        let segmentor = UIView()
        segmentor.backgroundColor = UIColor.bgGray
        
        whiteView.addSubview(segmentor)
        segmentor.snp_makeConstraints { (make) in
            make.left.right.centerY.equalTo(whiteView)
            make.height.equalTo(1)
        }
        
        //MARK: password textfield
        
        let password = UITextField()
        password.setCommonStyle("密码".es_ml())
        password.delegate = self
        
        whiteView.addSubview(password)
        password.snp_makeConstraints { (make) in
            make.left.right.height.equalTo(username)
            make.top.equalTo(username.snp_bottom)
            make.bottom.equalTo(whiteView)
        }
        
        let loginBtn = UIButton.init(type: UIButtonType.System)
        loginBtn.setAttributedTitle(NSAttributedString.init(string: "登录".es_ml(), attributes: [NSFontAttributeName:UIFont.button]), forState: .Normal)
        loginBtn.layer.cornerRadius = 4
        loginBtn.enabled = false
        loginBtn.setShadow()
        
        view.addSubview(loginBtn)
        loginBtn.snp_makeConstraints { (make) in
            make.left.right.equalTo(whiteView)
            make.top.equalTo(whiteView.snp_bottom).offset(10)
            make.height.equalTo(Scale.height(45))
        }
        
        //MARK: input observable
        
        let input = Observable.combineLatest(username.rx_text, password.rx_text, resultSelector: { return ($0, $1) })
        
        input.map { (username, password) -> Bool in
            if username.characters.count > 6 && password.characters.count > 6 { return true }
            return false
        }.distinctUntilChanged().subscribeNext { (result) in
            if result {
                loginBtn.backgroundColor = UIColor.main
                loginBtn.tintColor = UIColor.whiteColor()
            } else {
                loginBtn.backgroundColor = UIColor.main.colorWithAlphaComponent(0.7)
                loginBtn.tintColor = UIColor.whiteColor().colorWithAlphaComponent(0.7)
            }
            loginBtn.enabled = result
        }.addDisposableTo(disposeBag)
        
        //MARK: login button observable
        
        loginBtn.rx_tap.withLatestFrom(input).filter { [weak self] (username, password) -> Bool in
            if let result = InputHandler.username(username) {
                self?.view.showMsgHUD(result)
                return false
            }
            if let result = InputHandler.password(password) {
                self?.view.showMsgHUD(result)
                return false
            }
            return true
        }.subscribeNext { (username, password) in
            
        }.addDisposableTo(disposeBag)
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
}
