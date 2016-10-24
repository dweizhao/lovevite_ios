//
//  MainTabbarViewController.swift
//  IMBusiness
//
//  Created by Eason Leo on 2016/9/24.
//  Copyright © 2016年 XingShi. All rights reserved.
//

import UIKit

class MainTabbarViewController: UITabBarController {
    
    private let es_viewControllers: Array<UIViewController> = [SearchViewController(), DestinyViewController(), IMessageViewController(), MineViewController(), SettingsViewController()]
    
    private let es_titles: Array<String> = ["搜索".es_ml(), "缘分".es_ml(), "消息".es_ml(), "我".es_ml(), "设置".es_ml()]
    
    private let es_normalItemImageNames = ["item_search_0", "item_destiny_0", "item_im_0", "item_mine_0", "item_settings_0"]
    
    private let es_selectedItemImageNames = ["item_search_1", "item_destiny_1", "item_im_1", "item_mine_1", "item_settings_1"]

    convenience init() {
        self.init(nibName: nil, bundle: nil)
        for (index, viewController) in es_viewControllers.enumerate() {
            let image = UIImage(named: es_normalItemImageNames[index])?.imageWithRenderingMode(.AlwaysOriginal)
            let selectedImage = UIImage(named: es_selectedItemImageNames[index])?.imageWithRenderingMode(.AlwaysOriginal)
            viewController.tabBarItem = UITabBarItem.init(title: es_titles[index], image: image, selectedImage: selectedImage)
        }
        setViewControllers(es_viewControllers, animated: false)
        tabBar.tintColor = UIColor.theme()
        delegate = self
    }
    
}

extension MainTabbarViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        edgesForExtendedLayout = .None
        automaticallyAdjustsScrollViewInsets = false
    }
    
}

extension MainTabbarViewController: UITabBarControllerDelegate {
    
    func tabBarController(tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
    
}
