//
//  OtherUserModel.swift
//  lovevite
//
//  Created by Eason Leo on 2016/11/24.
//  Copyright © 2016年 lovevite. All rights reserved.
//

import ObjectMapper

struct OtherUserModel: Mappable {
    
    var accountID: String?
    
    var age: String?
    
    var gender: String?
    
    var height: String?
    
    var location: String?
    
    var name: String?
    
    var online: String?
    
    var photolg: String?
    
    var photomp: String?
    
    var photosm: String?
    
    var vip: String?
    
    var follow: String?
    
    var matchScore: String?
    
    var introduction: String?
    
    init?(_ map: Map) {
        mapping(map)
    }
    
    mutating func mapping(map: Map) {
        accountID       <- map["accountID"]
        age             <- map["age"]
        gender          <- map["gender"]
        height          <- map["height"]
        location        <- map["location"]
        name            <- map["name"]
        online          <- map["online"]
        photolg         <- map["photolg"]
        photomp         <- map["photomp"]
        photosm         <- map["photosm"]
        vip             <- map["vip"]
        follow          <- map["follow"]
        matchScore      <- map["matchScore"]
        introduction    <- map["introduction"]
    }
    
}
