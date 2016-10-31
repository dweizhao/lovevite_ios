//
//  UserModel.swift
//  lovevite
//
//  Created by Eason Leo on 2016/10/31.
//  Copyright © 2016年 lovevite. All rights reserved.
//

import ObjectMapper

struct UserModel: Mappable {
    
    var token: String?
    
    init?(_ map: Map) {
        mapping(map)
    }
    
    mutating func mapping(map: Map) {
        token           <- map["map"]
    }
    
}
