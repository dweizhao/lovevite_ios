//
//  RequestConfig.swift
//  HomerMerchant
//
//  Created by Mango on 16/6/17.
//  Copyright © 2016年 Homer. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

enum RequestMethod {
    case Get
    case Post
}

class RequestConfig<ResponseType: Mappable>: NSObject {
    
    var parameters: [String: AnyObject] = [:]
    
    var imageParameters: [String: UIImage] = [:]
    
    var method: RequestMethod = .Post
    
    var codeEventIgnore = false
    
    var url: String
    
    init(url: String) {
        self.url = url
    }
    
    convenience init(URLPath: String) {
        self.init(url: URLPath)
        url = NetworkManager.baseURL + url
    }
    
    func addParameter(key: String, value: AnyObject?) {
        parameters[key] = value
    }
    
    func addImageParameter(key: String, image: UIImage) {
        imageParameters[key] = image
    }
    
    func needUploadImage() -> Bool {
        return imageParameters.count > 0
    }
    
    func paramString() -> String {

        var urlParam:String = "?"
        var index = 0
        for (key, value) in parameters {
            index += 1
            urlParam = urlParam+"\(key)=\(value)"
            if(index < parameters.count) {
                urlParam = urlParam+"&"
            }
        }
        return urlParam
    }
    
    override var description: String {
        return "requestURL: \(url) \nmethods: \(method)\nparamters: \(parameters)"
    }
}

