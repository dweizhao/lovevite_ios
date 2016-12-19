//
//  BlackListViewController.swift
//  lovevite
//
//  Created by Eason Leo on 2016/11/21.
//  Copyright © 2016年 lovevite. All rights reserved.
//

import UIKit

class BlackListViewController: ShowOtherUsersListViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func initialize() {
        super.initialize()
        
        title = "黑名单".es_ml()
        
        tableView.frame = CGRect.init(x: 0, y: 0, width: UIScreen.width, height: UIScreen.height - UIScreen.navigationBarHeight)
        tableView.addTableHeaderView()
    }

}
