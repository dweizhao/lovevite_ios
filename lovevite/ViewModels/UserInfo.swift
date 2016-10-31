//
//  UserInfo.swift
//  lovevite
//
//  Created by Eason Leo on 2016/10/31.
//  Copyright © 2016年 lovevite. All rights reserved.
//

import ObjectMapper

class UserInfo: Mappable {
    
    private var model: UserModel?
    
    required init?(_ map: Map) {
        mapping(map)
    }
    
    func mapping(map: Map) {
        model           <- map["user"]
    }
    
}

extension UserInfo {
    
    func token() -> String? {
        return model?.token
    }
    
}
