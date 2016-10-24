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
    
    let extendableViewController: ExtendableViewController
    
    let rootViewController: UINavigationController
    
    // MARK: private
    
    private override init() {
        mainTabbarViewController = MainTabbarViewController()
        
        let mainNavigationController = UINavigationController(rootViewController: mainTabbarViewController)
        mainNavigationController.navigationBar.barTintColor = UIColor.theme()
        
        extendableViewController = ExtendableViewController(mainViewController: mainNavigationController)
        
        rootViewController = UINavigationController(rootViewController: extendableViewController)
        rootViewController.navigationBarHidden = true
        
        super.init()
    }
    
}
