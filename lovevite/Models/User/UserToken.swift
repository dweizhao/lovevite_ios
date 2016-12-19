//
//  UserToken.swift
//  lovevite
//
//  Created by Eason Leo on 2016/11/24.
//  Copyright © 2016年 lovevite. All rights reserved.
//

import ObjectMapper

class UserToken: Response {
    
    var token: String?
    
    override func mapping(map: Map) {
        super.mapping(map)
        token   <- map["authID"]
    }

}
