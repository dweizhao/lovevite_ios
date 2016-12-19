//
//  SearchViewController.swift
//  lovevite
//
//  Created by Eason Leo on 2016/9/26.
//  Copyright © 2016年 lovevite. All rights reserved.
//

import UIKit

class SearchViewController: MultipleTabsViewController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nil, bundle: nil)
        NSNotificationCenter.defaultCenter().rx_notification(NotificationNames.SearchSubTableViewContentOffsetYChanged)
            .subscribeNext { [weak self] noti in
                if let offsetY = (noti.userInfo?["offsetY"] as? CGFloat) {
                    let y = offsetY > ShowOtherUsersListViewController.headerHeight ? ShowOtherUsersListViewController.headerHeight : offsetY
                    self?.navBar.frame.origin.y = -y
                    self?.tabNamesView.frame.origin.y = -y + UIScreen.navigationBarHeight
                    if y > ShowOtherUsersListViewController.headerHeight / 2.0 && UIApplication.sharedApplication().statusBarHidden == false {
                        UIApplication.sharedApplication().setStatusBarHidden(true, withAnimation: .Fade)
                        self?.isShouldHiddenStatusBar = true
                    } else if y < ShowOtherUsersListViewController.headerHeight / 2.0 && UIApplication.sharedApplication().statusBarHidden == true {
                        UIApplication.sharedApplication().setStatusBarHidden(false, withAnimation: .Slide)
                        self?.isShouldHiddenStatusBar = false
                    }
                }
            }.addDisposableTo(disposeBag)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let navBar: CustomNavBar = {
        let navBar = CustomNavBar.init(title: "寻找".es_ml(), leftView: nil, rightView: nil)
        return navBar
    }()

    private let tabNamesView = ESSegmentControl.init(titles: ["人气".es_ml(), "上次在线".es_ml(), "最新加入".es_ml()])
    
    private let viewControllers = [PopularViewController(), StillOnlineViewController(), RecentJoinViewController()]
    
    private var isShouldHiddenStatusBar = false
    
    private let conditionVC = SearchConditionViewController()
    
    override var segmentView: ESSegmentControl? {
        return tabNamesView
    }
    
    override var subViewControllers: Array<BaseViewController>? {
        return viewControllers
    }

}

extension SearchViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        if isShouldHiddenStatusBar {
            UIApplication.sharedApplication().setStatusBarHidden(true, withAnimation: .None)
        } else {
            UIApplication.sharedApplication().setStatusBarHidden(false, withAnimation: .None)
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func initialize() {
        super.initialize()
        title = "寻找"
        
        let searchBtn = UIButton.init(type: .System)
        searchBtn.tintColor = UIColor.clearColor()
        searchBtn.setImage(UIImage(named: "nav_search_btn")?.imageWithRenderingMode(.AlwaysOriginal), forState: .Normal)
        searchBtn.rx_tap.subscribeNext { [weak self] in
            guard let `self` = self else {
                return
            }
            self.navigationController?.pushViewController(self.conditionVC, animated: true)
            }.addDisposableTo(disposeBag)
        navBar.addRightView(searchBtn)
        
        view.addSubview(navBar)
        
        tabNamesView.frame = CGRectMake(0, UIScreen.navigationBarHeight, UIScreen.width, 35.0)
        tabNamesView.segmentTintColor = UIColor.title
        tabNamesView.backgroundColor = UIColor.whiteColor()
        view.addSubview(tabNamesView)
    }
    
}
