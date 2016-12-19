//
//  ApplicationManager.swift
//  lovevite
//
//  Created by Eason Leo on 2016/10/31.
//  Copyright © 2016年 lovevite. All rights reserved.
//

import Foundation
import YYWebImage

struct ApplicationHandler {
    
    static var releaseVersion: String? {
        return NSBundle.mainBundle().infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    static var isFirstLaunch: Bool {
        return (NSUserDefaults.standardUserDefaults().objectForKey(Keys.lauch) as? String) == nil
    }
    
}

extension ApplicationHandler {
    
    static let baseConfiguation: Void = {
        UIBarButtonItem.appearance()
            .setBackButtonTitlePositionAdjustment(UIOffset.init(horizontal: 0, vertical: -64.0), forBarMetrics: .Default)
        UIBarButtonItem.appearance().setBackButtonBackgroundImage(UIImage(named: "nav_common_back"), forState: .Normal, barMetrics: .Default)
        UITextView.addPlaceholder()
        UIScrollView.prepareAutoSize()
    }()
    
    static let loginedConfiguation: Void = {
        if UserManager.isUserExit {
            guard let token = UserManager.token else {
                return
            }
            YYWebImageManager.sharedManager().headers = ["authId":token]
        }
    }()
    
    static let launch: Void = {
        NSUserDefaults.standardUserDefaults().setObject(releaseVersion, forKey: Keys.lauch)
    }()
    
}
