//
//  API+Login.swift
//  iCarOwner
//
//  Created by Mango on 2016/9/24.
//  Copyright © 2016年 iCarOwner. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class API {}

// MARK: - Login API
extension API {
    /*
 
     Usage:

     In API:
     
     static func login(phone: String, password: String) -> RxSwift.Observable<LoginModel> {
         let config = RequestConfig<LoginModel>(URLPath: "api_dealer/dealer/user/login")
         config.addParameter("mobile", value: phone)
         config.addParameter("password", value: password)
         return NetworkManager().rx_request(config)
     }
    
     * LoginModel is a subclass of Response
     
     In view controller and view model:
     
     API.login("18583341110", password: "1234567")
     .subscribeNext { print($0.token) }
     .addDisposableTo(disposeBag)
     
     */
    
}
