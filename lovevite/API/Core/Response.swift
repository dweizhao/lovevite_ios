//
//  RequestResult.swift
//  HomerMerchant
//
//  Created by Mango on 16/6/18.
//  Copyright © 2016年 Homer. All rights reserved.
//

import ObjectMapper


class Response: NSObject, Mappable {
    var status = -1
    var message: String?
    var isSuccess: Bool {
        return status == 0
    }
    
    required init?(_ map: Map) {
        super.init()
        self.mapping(map)
    }
    
    override init() {
        super.init()
    }
    
    func mapping(map: Map) {
        status    <- map["status"]
        message <- map["statusInfo.message"]
    }
    
}
