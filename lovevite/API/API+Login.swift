//
//  API+Login.swift
//  iCarOwner
//
//  Created by Mango on 2016/9/24.
//  Copyright © 2016年 iCarOwner. All rights reserved.
//

import Foundation

// MARK: - Login API
extension API {
    /*
 
     Usage:

     In API:
     
     */
     
     static func login(username: String, password: String) -> RxSwift.Observable<UserToken> {
        let config = RequestConfig<UserToken>(URLPath: "/api/account/login")
        config.method = .Post
        config.addParameter("username", value: username)
        config.addParameter("password", value: password)
        config.addParameter("device", value: "iOS")
        return NetworkManager().rx_request(config)
     }
    
     /* LoginModel is a subclass of Response
     
     In view controller and view model:
     
     API.login("18583341110", password: "1234567")
     .subscribeNext { print($0.token) }
     .addDisposableTo(disposeBag)
     
     */
    
}
