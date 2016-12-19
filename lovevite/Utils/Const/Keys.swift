//
//  Keys.swift
//  lovevite
//
//  Created by Eason Leo on 2016/10/24.
//  Copyright © 2016年 lovevite. All rights reserved.
//

import Foundation

// MARK: common

class Keys: NSObject {
    
    static var lauch: String {
        return "eason_lovevite_lauch"
    }
    
}

// MARK: user

extension Keys {
    
    static var saveUserToken: String {
        return "eason_lovevite_save_user_token"
    }
    
    static var saveUserInfo: String {
        return "eason_lovevite_save_user_info"
    }
    
}

// MARK: save the details user default key

extension Keys {
    
    static var picturesLibraryNoteLabelShouldShow: String {
        return "eason_lovevite_pictures_library_note_label_should_show"
    }
    
}
