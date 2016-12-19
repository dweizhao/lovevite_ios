//
//  MultipleTabsSubViewController.swift
//  lovevite
//
//  Created by Eason Leo on 2016/11/20.
//  Copyright © 2016年 lovevite. All rights reserved.
//

import UIKit

class MultipleTabsSubViewController: BaseViewController {
    
    var tableViewContentOffsetYChangedNotificationName: String? {
        return nil
    }
    
    var scrolledheaderHeight: CGFloat {
        return 0
    }
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        if let notiName = tableViewContentOffsetYChangedNotificationName {
            NSNotificationCenter.defaultCenter()
                .rx_notification(notiName)
                .subscribeNext { [weak self] noti in
                    if let offsetY = (noti.userInfo?["offsetY"] as? CGFloat) {
                        if self?.contentOffsetY == offsetY {
                            return
                        }
                        self?.contentOffsetY = offsetY
                    }
                }
                .addDisposableTo(disposeBag)
        }
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var contentOffsetY: CGFloat = 0 {
        willSet {
            tableView.contentOffset.y = newValue
        }
    }
    
    private var shouldPostContentOffsetY = false
    
    let tableView = UITableView.init(frame: UIScreen.noneTabbarFrame, style: .Grouped)
    
    struct ReuseIdentifier {
        static var defaultCell = "sub_view_controller_default_cell"
    }

}

extension MultipleTabsSubViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func initialize() {
        super.initialize()
        
        tableView.addTableHeaderView()
        tableView.addTableFooterView()
        tableView.contentOffset = CGPoint.init(x: 0, y: contentOffsetY)
        tableView.delegate = self
        view.addSubview(tableView)
    }
    
}

extension MultipleTabsSubViewController: UITableViewDelegate {
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        shouldPostContentOffsetY = true
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if shouldPostContentOffsetY {
            guard let notiName = tableViewContentOffsetYChangedNotificationName else {
                return
            }
            var offsetY = scrollView.contentOffset.y
            if offsetY >= scrolledheaderHeight {
                offsetY = scrolledheaderHeight
            } else if offsetY <= 0 {
                offsetY = 0
            }
            NSNotificationCenter.defaultCenter().postNotificationName(notiName, object: nil, userInfo: ["offsetY":offsetY])
        }
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        shouldPostContentOffsetY = false
    }
    
}
