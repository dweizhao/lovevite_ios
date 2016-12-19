//
//  UserInfo.swift
//  lovevite
//
//  Created by Eason Leo on 2016/10/31.
//  Copyright © 2016年 lovevite. All rights reserved.
//

import ObjectMapper

class UserInfo: Response {
    
    private var model: UserModel?
    
    required init?(_ map: Map) {
        super.init(map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map)
        model           <- map["user"]
    }
    
}
