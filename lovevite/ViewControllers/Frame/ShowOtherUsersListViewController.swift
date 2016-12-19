//
//  ShowOtherUsersListViewController.swift
//  lovevite
//
//  Created by Eason Leo on 2016/11/20.
//  Copyright © 2016年 lovevite. All rights reserved.
//

import UIKit

class ShowOtherUsersListViewController: MultipleTabsSubViewController {
    
    static let headerHeight = UIScreen.navigationBarHeight
    
    override var scrolledheaderHeight: CGFloat {
        return ShowOtherUsersListViewController.headerHeight
    }
    
}

extension ShowOtherUsersListViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func initialize() {
        super.initialize()
        
        tableView.dataSource = self
        tableView.addTableHeaderView(ShowOtherUsersListViewController.headerHeight + 35.0)
        tableView.contentOffset.y = contentOffsetY
        tableView.estimatedRowHeight = 130.0
        tableView.separatorInset = UIEdgeInsets.init(top: 0, left: -15, bottom: 0, right: 0)
        tableView.registerClass(ShowOtherUserCell.self, forCellReuseIdentifier: ReuseIdentifier.defaultCell)
        
        tableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            self.refresh()
        })
        tableView.mj_header.ignoredScrollViewContentInsetTop = -ShowOtherUsersListViewController.headerHeight - 35.0
        tableView.mj_footer = MJRefreshAutoFooter.init(refreshingBlock: {
            self.loadMore()
        })
    }
    
}

extension ShowOtherUsersListViewController {
    
    func refresh() {
        
    }
    
    func loadMore() {
        
    }
    
}

extension ShowOtherUsersListViewController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: ShowOtherUserCell = tableView.dequeueReusableCellWithIdentifier(ReuseIdentifier.defaultCell) as! ShowOtherUserCell
        return cell
    }
    
}
