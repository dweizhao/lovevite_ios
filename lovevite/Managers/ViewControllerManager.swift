//
//  ViewControllerManager.swift
//  IMBusiness
//
//  Created by Eason Leo on 2016/9/24.
//  Copyright © 2016年 XingShi. All rights reserved.
//

import UIKit

class ViewControllerManager: NSObject {
    
    // MARK: public
    
    static let manager = ViewControllerManager()
    
    let mainTabbarViewController: MainTabbarViewController
    
    let rootViewController: ExtendableViewController
    
    // MARK: private
    
    private override init() {
        mainTabbarViewController = MainTabbarViewController()
        
        let mainNavigationController = UINavigationController(rootViewController: mainTabbarViewController)
        mainNavigationController.navigationBar.barTintColor = UIColor.main
        
        rootViewController = ExtendableViewController(mainViewController: mainNavigationController)
        
        super.init()
    }
    
}
