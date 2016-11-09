//
//  TrueWordsViewController.swift
//  lovevite
//
//  Created by Eason Leo on 2016/11/6.
//  Copyright © 2016年 lovevite. All rights reserved.
//

import UIKit

class TrueWordsViewController: BaseViewController {

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
    
    let tableView = UITableView.init(frame: UIScreen.noneTabbarFrame, style: .Plain)
    
    private lazy var recordView: AnsweredCountRecordView = {
        let v = AnsweredCountRecordView.init(frame: CGRectZero)
        return v
    }()
    
    struct ReuseIdentifier {
        static var questionCell = "questionCell"
        static var answerCountCell = "answerCountCell"
        static var questionHeader = "questionHeader"
        static var answerCountHeader = "answerCountHeader"
    }
    
    private let viewModel = TrueWordsViewModel()
    
    private var shouldPostContentOffsetY = false
    
    private var contentOffsetY: CGFloat = 0 {
        willSet {
            tableView.contentOffset.y = newValue
        }
    }

}

extension TrueWordsViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func initialize() {
        title = "真心话"
        
        tableView.addTableHeaderView(MineUserInterfaceContent.photosViewHeight)
        tableView.contentOffset.y = contentOffsetY
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerClass(TrueWordsQuestionHeader.self, forHeaderFooterViewReuseIdentifier: ReuseIdentifier.questionHeader)
        tableView.registerClass(TrueWordsQuestionCell.self, forCellReuseIdentifier: ReuseIdentifier.questionCell)
        tableView.registerClass(TrueWordsQuestionHeader.self, forHeaderFooterViewReuseIdentifier: ReuseIdentifier.answerCountHeader)
        tableView.registerClass(MineDefaultStyleCell.self, forCellReuseIdentifier: ReuseIdentifier.answerCountCell)
        view.addSubview(tableView)
    }
    
}

extension TrueWordsViewController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell: TrueWordsQuestionCell = tableView.dequeueReusableCellWithIdentifier(ReuseIdentifier.questionCell) as! TrueWordsQuestionCell
            cell.question = viewModel.question()
            cell.selectionStyle = .None
            cell.contentView.backgroundColor = UIColor.bgGray
            return cell
        } else if indexPath.section == 1 {
            let cell: MineDefaultStyleCell = tableView.dequeueReusableCellWithIdentifier(ReuseIdentifier.answerCountCell) as! MineDefaultStyleCell
            cell.title = viewModel.cellTitles(indexPath.row)
            cell.detail = viewModel.answerCount(indexPath.row)
            cell.selectionStyle = .None
            cell.accessoryType = .DisclosureIndicator
            return cell
        }
        return UITableViewCell()
    }
    
//    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
//        if indexPath.section == 0 {
//            cell.separatorInset = UIEdgeInsets.init(top: 0, left: UIScreen.width, bottom: 0, right: 0)
//        }
//    }
    
}

extension TrueWordsViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return UITableViewAutomaticDimension
        } else {
            return 49.0
        }
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 100.0
        } else {
            return 0.0
        }
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 54.0
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.min
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var header: TrueWordsQuestionHeader?
        if section == 0 {
            header = tableView.dequeueReusableHeaderFooterViewWithIdentifier(ReuseIdentifier.questionHeader) as? TrueWordsQuestionHeader
            recordView.count = viewModel.answeredCount()
            if recordView.superview == nil {
                header?.addSubview(recordView)
                recordView.snp_makeConstraints(closure: { (make) in
                    make.right.equalTo(-UIConst.defaultInset)
                    make.centerY.equalTo(0)
                })
            }
        } else if section == 1 {
            header = tableView.dequeueReusableHeaderFooterViewWithIdentifier(ReuseIdentifier.answerCountHeader) as? TrueWordsQuestionHeader
        }
        header?.title = viewModel.headerTitle(section)
        return header
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
