//
//  UserManager.swift
//  lovevite
//
//  Created by Eason Leo on 2016/10/31.
//  Copyright © 2016年 lovevite. All rights reserved.
//

import Foundation

class UserManager: NSObject {
    
    private override init() {}
    
    static var manager = UserManager()
    
    static var user: UserInfo?
    
}

extension UserManager {
    
    // operate user info at inside.
    // to prevent user info error.
    
    private var userInfo: UserInfo? {
        set {
            UserManager.user = newValue
        }
        get {
            return UserManager.user
        }
    }
    
    private func getSavedUserInfo() -> UserInfo? {
        let userJSON = NSUserDefaults.standardUserDefaults().objectForKey(Keys.saveUserInfo) as? [String:AnyObject]
        return UserInfo.init(Map.init(mappingType: .FromJSON, JSONDictionary: userJSON ?? [:]))
    }
    
}

extension UserManager {
    
    static var isUserExit: Bool {
        guard let token = manager.userInfo?.token() else {
            return false
        }
        return token.characters.count > 0
    }
    
    static func saveTheCurrentUserInfo() {
        NSUserDefaults.standardUserDefaults().setObject(manager.userInfo?.toJSON(), forKey: Keys.saveUserInfo)
    }
    
    static func updateTheCurrentUserInfo() {
        manager.userInfo = UserInfo.init(Map.init(mappingType: .FromJSON, JSONDictionary: [:]))
    }
    
}
