//
//  UserManager.swift
//  lovevite
//
//  Created by Eason Leo on 2016/10/31.
//  Copyright © 2016年 lovevite. All rights reserved.
//

import Foundation

class UserManager: NSObject {
    
    static var manager = UserManager()
    
    private override init() {}
    
    private var userInfo: UserInfo?
    
    private lazy var userToken: UserToken? = {
        return self.getSavedUserToken()
    }()
    
}

extension UserManager {
    
    // operate user info at inside.
    // to prevent user info error.
    
    private func getSavedUserInfo() -> UserInfo? {
        let userJson = NSUserDefaults.standardUserDefaults().objectForKey(Keys.saveUserInfo) as? [String:AnyObject]
        return UserInfo.init(Map.init(mappingType: .FromJSON, JSONDictionary: userJson ?? [:]))
    }
    
    private func getSavedUserToken() -> UserToken? {
        let tokenJson = NSUserDefaults.standardUserDefaults().objectForKey(Keys.saveUserToken) as? [String:AnyObject]
        return UserToken.init(Map.init(mappingType: .FromJSON, JSONDictionary: tokenJson ?? [:]))
    }
    
}

extension UserManager {
    
    static func createTheNewUser(token: UserToken) {
        manager.userToken = token
        saveTheCurrentUserToken()
    }
    
    static func updateTheCurrentUserInfo(user: UserInfo) {
        manager.userInfo = user
        saveTheCurrentUserInfo()
    }
    
    private static func saveTheCurrentUserToken() {
        NSUserDefaults.standardUserDefaults().setObject(manager.userToken?.toJSON(), forKey: Keys.saveUserToken)
    }
    
    private static func saveTheCurrentUserInfo() {
        NSUserDefaults.standardUserDefaults().setObject(manager.userInfo?.toJSON(), forKey: Keys.saveUserInfo)
    }
    
}

extension UserManager {
    
    static var isUserExit: Bool {
        guard let token = manager.userToken?.token else {
            return false
        }
        return token.characters.count > 0
    }
    
    static var token: String? {
        return manager.userToken?.token
    }
    
}
