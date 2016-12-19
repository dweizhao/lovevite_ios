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
    
    let mainNavigationController: UINavigationController
    
    let rootViewController: ExtendableViewController
    
    // MARK: private
    
    private override init() {
        mainTabbarViewController = MainTabbarViewController()
        
        mainNavigationController = UINavigationController(rootViewController: mainTabbarViewController)
        mainNavigationController.setCommonStyle()
        
        rootViewController = ExtendableViewController(mainViewController: mainNavigationController)
        
        super.init()
    }
    
}

extension ViewControllerManager {
    
    func theVisibleViewController<T>() -> T? {
        guard let vc = mainNavigationController.viewControllers.last else {
            return nil
        }
        return vc as? T
    }
    
}
