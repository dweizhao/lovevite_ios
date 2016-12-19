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
    
    static let debugURL = "http://54.214.162.237"
    
    static let releaseURL = "http://www.baidu.com"
    
    static let baseURL = APP.isRelease ? releaseURL : debugURL
    
    static let needLoginNotification = "NeedLoginNotification"
    
    static private let localTokenKey = "NetworkManagerUserDefaultTokenKey"
    
    static var httpRequestHeader: [String: String] {
        var header = ["Content-Type": "application/x-www-form-urlencoded",
                      "Accept": "application/json",]
        if !token.isEmpty {
            header[headerTokenKey] = "<\(token)>"
        }
        return header
    }
    
    static private let headerTokenKey = "authId"
    
    static private var token: String {
        return UserManager.token ?? ""
    }
    
    static private func failureResultDic(httpStatusCode code: Int) -> Dictionary<String, AnyObject> {
        return ["status": code,
                "message": "网络暂时不通畅，请稍后再试"]
    }

    func rx_request<T>(config: RequestConfig<T>) -> RxSwift.Observable<T> {
        return rx_requestByIgnoringCodeEvent(config).map {
            if !config.codeEventIgnore {
                if let requestResult = $0 as? Response {
                    switch requestResult.status {
                    case 500:
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
            guard var dic = json as? Dictionary<String, AnyObject> else {
                let object = Mapper<T>().map(json) ?? Mapper<T>().map(NetworkManager.failureResultDic(httpStatusCode: response.statusCode))!
                return object
            }
            dic["status"] = response.statusCode
            let object = Mapper<T>().map(dic) ?? Mapper<T>().map(NetworkManager.failureResultDic(httpStatusCode: response.statusCode))!
            return object
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
    
    static func completeImageURL(suffix: String) -> String {
        return debugURL + suffix
    }

}
