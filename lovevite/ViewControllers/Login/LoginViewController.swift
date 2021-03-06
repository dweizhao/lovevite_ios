//
//  LoginViewController.swift
//  lovevite
//
//  Created by Eason Leo on 2016/10/31.
//  Copyright © 2016年 lovevite. All rights reserved.
//

import Foundation
import YYWebImage

class LoginViewController: BaseViewController {
    
    
}

extension LoginViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func initialize() {
        title = "登录"
        
        let whiteView = UIView()
        whiteView.backgroundColor = UIColor.clearColor()
        whiteView.layer.contents = UIImage(named: "circular_border_bg")?.CGImage
        whiteView.setShadow()
        
        view.addSubview(whiteView)
        whiteView.snp_makeConstraints { (make) in
            make.top.equalTo(view.snp_centerY).offset(-Scale.height(40))
            make.left.equalTo(UIConst.defaultInset)
            make.right.equalTo(-UIConst.defaultInset)
        }
        
        //MARK: username textfied
        
        let username = UITextField()
        username.setLikeUserNameStyle("用户名/邮箱/手机号".es_ml())
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
        password.setLikePasswordStyle("密码".es_ml())
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
            if username.characters.count > 6 && password.characters.count > 6 {
                return true
            }
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
        }.flatMapLatest { [weak self] (username, password) -> Observable<UserToken> in
            guard let `self` = self else {
                return API.login(username, password: password)
            }
            self.view.showLoadingHUD()
            return API.login(username, password: password)
        }.subscribeNext { [weak self] (token) in
            guard let `self` = self else {
                return
            }
            self.view.hideAllHUDs()
            if token.isSuccess {
                UserManager.createTheNewUser(token)
                self.handleAtLogined()
                self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
            } else {
                self.view.showMsgHUD(token.message)
            }
        }.addDisposableTo(disposeBag)
        
        //MARK: register button
        
        let signinBtn = UIButton.init(type: UIButtonType.System)
        signinBtn.setAttributedTitle(NSAttributedString.init(string: "注册".es_ml(), attributes: [NSForegroundColorAttributeName:UIColor.color(hexValue: 0x419bf9), NSFontAttributeName:UIFont.button]), forState: .Normal)
        
        view.addSubview(signinBtn)
        signinBtn.snp_makeConstraints { (make) in
            make.top.equalTo(loginBtn.snp_bottom).offset(10)
            make.right.equalTo(loginBtn)
            make.height.equalTo(30)
        }
        
        signinBtn.rx_tap
            .subscribeNext({ [weak self] _ in
                let vc = SigninViewController()
                self?.navigationController?.pushViewController(vc, animated: true)
            })
            .addDisposableTo(disposeBag)
    }
    
    private func handleAtLogined() {
        NSNotificationCenter.defaultCenter().postNotificationName(NotificationNames.UserLogined, object: nil)
        guard let token = UserManager.token else {
            return
        }
        YYWebImageManager.sharedManager().headers = ["authId":token]
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
}
