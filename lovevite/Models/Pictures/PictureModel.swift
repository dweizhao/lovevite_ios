//
//  PicturesModel.swift
//  lovevite
//
//  Created by Eason Leo on 2016/11/11.
//  Copyright © 2016年 lovevite. All rights reserved.
//

import ObjectMapper

struct PictureModel: Mappable {
    
    var approved: Bool {
        return approvedString ?? "" == "true"
    }
    
    var approvedString: String?
    
    var description: String?
    
    var id: String?
    
    var photolg: String?        // 740 * 560
    
    var photomp: String?        // 200 * 200
    
    var photosm: String?
    
    init?(_ map: Map) {
        mapping(map)
    }
    
    mutating func mapping(map: Map) {
        approvedString  <- map["approved"]
        description     <- map["description"]
        id              <- map["id"]
        photolg         <- map["photolg"]
        photomp         <- map["photomp"]
        photosm         <- map["photosm"]
    }
    
}
