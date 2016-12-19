//
//  RecentJoinViewController.swift
//  lovevite
//
//  Created by Eason Leo on 2016/11/20.
//  Copyright © 2016年 lovevite. All rights reserved.
//

import UIKit

class RecentJoinViewController: ShowOtherUsersListViewController {

    override var tableViewContentOffsetYChangedNotificationName: String? {
        return NotificationNames.SearchSubTableViewContentOffsetYChanged
    }
    
    private var configuator = SearchViewModel()
    
}

extension RecentJoinViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.mj_header.beginRefreshing()
    }
    
    override func initialize() {
        super.initialize()
        
        NSNotificationCenter.defaultCenter().rx_notification(NotificationNames.UserLogined, object: nil).subscribeNext { [weak self] (_) in
            self?.refresh()
            }.addDisposableTo(disposeBag)
        
    }
    
}

extension RecentJoinViewController {
    
    override func refresh() {
        API.searchResult(.popular, lastUserID: nil).subscribeNext { [weak self] (result) in
            guard let `self` = self else {
                return
            }
            self.tableView.mj_header.endRefreshing()
            if result.isSuccess {
                self.configuator = result
                self.tableView.reloadData()
            } else {
                self.view.showMsgHUD(result.message)
            }
            }.addDisposableTo(disposeBag)
    }
    
}

extension RecentJoinViewController {
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return configuator.cellsCount(section)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAtIndexPath: indexPath) as! ShowOtherUserCell
        cell.configTheCell(configuator, indexPath: indexPath)
        return cell
    }
    
}
