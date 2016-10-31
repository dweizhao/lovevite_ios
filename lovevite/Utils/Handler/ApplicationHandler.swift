//
//  ApplicationManager.swift
//  lovevite
//
//  Created by Eason Leo on 2016/10/31.
//  Copyright © 2016年 lovevite. All rights reserved.
//

import Foundation

class ApplicationHandler: NSObject {
    
    static var releaseVersion: String? {
        return NSBundle.mainBundle().infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    static func launch() {
        NSUserDefaults.standardUserDefaults().setObject(releaseVersion, forKey: Keys.lauch)
    }
    
    static var isFirstLaunch: Bool {
        return (NSUserDefaults.standardUserDefaults().objectForKey(Keys.lauch) as? String) == nil
    }
    
}
