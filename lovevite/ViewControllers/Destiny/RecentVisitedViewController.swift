//
//  RecentVisitedViewController.swift
//  lovevite
//
//  Created by Eason Leo on 2016/11/21.
//  Copyright © 2016年 lovevite. All rights reserved.
//

import UIKit

class RecentVisitedViewController: ShowOtherUsersListViewController {

    override var tableViewContentOffsetYChangedNotificationName: String? {
        return NotificationNames.DestinySubTableViewContentOffsetYChanged
    }
    
}
