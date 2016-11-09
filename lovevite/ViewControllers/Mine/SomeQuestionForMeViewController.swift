//
//  SomeQuestionForMeViewController.swift
//  lovevite
//
//  Created by Eason Leo on 2016/11/6.
//  Copyright © 2016年 lovevite. All rights reserved.
//

import UIKit

class SomeQuestionForMeViewController: BaseViewController {

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
        static var defaultCell = "answerCell"
        static var defaultHeader = "questionHeader"
    }
    
    private let viewModel = SomeQuestionForMeViewModel()
    
    private var shouldPostContentOffsetY = false
    
    private var contentOffsetY: CGFloat = 0 {
        willSet {
            tableView.contentOffset.y = newValue
        }
    }
    
}

extension SomeQuestionForMeViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func initialize() {
        title = "关于我"
        
        tableView.addTableHeaderView(MineUserInterfaceContent.photosViewHeight)
        tableView.contentOffset.y = contentOffsetY
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerClass(OnlyAnswerCell.self, forCellReuseIdentifier: ReuseIdentifier.defaultCell)
        tableView.registerClass(SomeQuestionForMeHeader.self, forHeaderFooterViewReuseIdentifier: ReuseIdentifier.defaultHeader)
        tableView.estimatedRowHeight = 95.0
        view.addSubview(tableView)
    }
    
}

extension SomeQuestionForMeViewController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return viewModel.titlesCount
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(ReuseIdentifier.defaultCell) as! OnlyAnswerCell
        cell.answer = viewModel.answer(indexPath.section)
        return cell
    }
    
}

extension SomeQuestionForMeViewController: UITableViewDelegate {
    
    private func handleEditeAnswer(index: Int) {
        print("handle the \(index) answer.")
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.min
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterViewWithIdentifier(ReuseIdentifier.defaultHeader) as! SomeQuestionForMeHeader
        header.question = viewModel.title(section)
        header.tapEdite.subscribeNext { [weak self] in
            self?.handleEditeAnswer(section)
        }.addDisposableTo(header.disposeBag)
        return header
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        handleEditeAnswer(indexPath.section)
    }
    
    // MARK: manage scroll.
    
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
