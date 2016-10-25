//
//  ExtensionViewController.swift
//  IMBusiness
//
//  Created by Eason Leo on 2016/9/24.
//  Copyright © 2016年 XingShi. All rights reserved.
//

import UIKit

class ExtendableViewController: UIViewController {
    
    private var mainViewController: UIViewController?
    
    private var extendedViewController: UIViewController?

    convenience init(mainViewController: UIViewController, extendedViewController: UIViewController? = nil) {
        self.init(nibName: nil, bundle: nil)
        self.mainViewController = mainViewController
        self.extendedViewController = extendedViewController
    }

}

extension ExtendableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = .None
        automaticallyAdjustsScrollViewInsets = false
        view.backgroundColor = UIColor.whiteColor()
        
        if let vc = mainViewController {
            addChildViewController(vc)
            view.addSubview(vc.view)
        } else {
            addChildViewController(ViewControllerManager.manager.mainTabbarViewController)
            view.addSubview(ViewControllerManager.manager.mainTabbarViewController.view)
        }
    }
    
}
