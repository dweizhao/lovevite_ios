//
//  NetworkManager.swift
//  HomerMerchant
//
//  Created by Mango on 16/6/17.
//  Copyright © 2016年 Homer. All rights reserved.
//

import Alamofire
import ObjectMapper
import RxAlamofire
import RxSwift
import RxCocoa

private extension RequestMethod {
    var alamofireMethod: Alamofire.Method {
        switch self {
        case .Get:
            return .GET
        case .Post:
            return .POST
        }
    }
}

class NetworkManager {
    
    static let baseURL = "http://dev.api.woshichezhu.com/"
    
    static let needLoginNotification = "NeedLoginNotification"
    
    static private let localTokenKey = "NetworkManagerUserDefaultTokenKey"
    
    static var httpRequestHeader: [String: String] {
        var header = ["Content-Type": "application/x-www-form-urlencoded",
                      "Accept": "application/json",]
        if !token.isEmpty {
            header[headerTokenKey] = token
        }
        return header
    }
    
    static private let headerTokenKey = "Authorization"
    
    static private(set) var token: String {
        get {
            return NSUserDefaults.standardUserDefaults().valueForKey(localTokenKey) as? String ?? ""
        }
        set {
            NSUserDefaults.standardUserDefaults().setValue(newValue, forKey: localTokenKey)
        }
    }
    
    static func storeToken(token: String) {
        NetworkManager.token = "Bearer \(token)"
    }
    
    static private let failureResultDic  = ["status": -1,
                                            "message": "网络暂时不通畅，请稍后再试"]

    func rx_request<T>(config: RequestConfig<T>) -> RxSwift.Observable<T> {
        return rx_requestByIgnoringCodeEvent(config).map {
            if !config.codeEventIgnore {
                if let requestResult = $0 as? Response {
                    switch requestResult.status {
                    case 40000...40009:
                        NSNotificationCenter
                            .defaultCenter()
                            .postNotificationName(NetworkManager.needLoginNotification, object: nil, userInfo: nil)
                    default:
                        break
                    }
                }
            }
            return $0
        }
    }
    
    // FIXME: has no consideration for uploading image yet.
    private func rx_requestByIgnoringCodeEvent<T>(config: RequestConfig<T>) -> RxSwift.Observable<T> {
        let method: Alamofire.Method = config.method.alamofireMethod
        print("request: " + config.url + config.paramString())

        return RxAlamofire.requestJSON(method, config.url, parameters: config.parameters, headers: NetworkManager.httpRequestHeader)
            .observeOn(MainScheduler.instance)
            .map { (response, json) -> T in
            let object = Mapper<T>().map(json) ?? Mapper<T>().map(NetworkManager.failureResultDic)!
            return object
        }
    }
    
    private func checkToken(response: NSHTTPURLResponse?) {
        if let token = response?.allHeaderFields[NetworkManager.headerTokenKey] as? String {
            NetworkManager.token = token
        }
    }
    
    private func printResponseData(data: NSData?) {
        if let data = data {
            let dic = try? NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments)
    
            print(dic)
        }else {
            print("没有response data")
        }
    }
    

}
