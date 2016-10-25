//
//  PersonalInfoViewController.swift
//  lovevite
//
//  Created by Eason Leo on 2016/10/24.
//  Copyright © 2016年 lovevite. All rights reserved.
//

import UIKit

class PersonalInfoViewController: BaseViewController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nil, bundle: nil)
        NSNotificationCenter.defaultCenter()
            .rx_notification(NotificationNames.MineSubTableViewContentOffsetYChanged)
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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let tableView = UITableView.init(frame: UIScreen.noneTabbarFrame, style: .Grouped)
    
    struct ReuseIdentifier {
        static var defaultCell = "personalInfoDefaultCell"
    }
    
    private let viewModel = PersonalInfoConfiguator()
    
    private var shouldPostContentOffsetY = false
    
    private var contentOffsetY: CGFloat = 0 {
        willSet {
            tableView.contentOffset.y = newValue
        }
    }

}

extension PersonalInfoViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeUserInterface()
    }
    
    override func initializeUserInterface() {
        // will reset contentOffset.y when add table header view.
        tableView.addTableHeaderView(MineUserInterfaceContent.photosViewHeight)
        tableView.contentOffset.y = contentOffsetY
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerClass(MineDefaultStyleCell.self, forCellReuseIdentifier: ReuseIdentifier.defaultCell)
        view.addSubview(tableView)
    }
    
}

extension PersonalInfoViewController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return viewModel.sectionsCount()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cellsCount(section)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(ReuseIdentifier.defaultCell) as! MineDefaultStyleCell
        cell.textLabel?.text = viewModel.cellTitle(indexPath)
        cell.accessoryType = viewModel.cellAllowSelected(indexPath) ? .DisclosureIndicator : .None
        cell.selectionStyle = .None
        return cell
    }
    
}

extension PersonalInfoViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 64.0 : 12.0
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.min
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        shouldPostContentOffsetY = true
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if shouldPostContentOffsetY {
            var offsetY = scrollView.contentOffset.y
            if offsetY > MineUserInterfaceContent.photosViewHeight {
                offsetY = MineUserInterfaceContent.photosViewHeight
            }
            NSNotificationCenter.defaultCenter().postNotificationName(NotificationNames.MineSubTableViewContentOffsetYChanged, object: nil, userInfo: ["offsetY":offsetY])
        }
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        shouldPostContentOffsetY = false
    }
    
}
