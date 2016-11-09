//
//  SettingsViewController.swift
//  lovevite
//
//  Created by Eason Leo on 2016/9/26.
//  Copyright © 2016年 lovevite. All rights reserved.
//

import UIKit

class SettingsViewController: BaseViewController {

    private let settingsTable = UITableView.init(frame: UIScreen.mainScreen().bounds, style: .Grouped)
    
    private let configurator = SettingsUserInterfaceConfigurator()
    
    private let signOutBtn = UIButton.init(type: UIButtonType.System)
    
    let dispose = DisposeBag.init()

}

extension SettingsViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = configurator.title()
        configSettingsTableView()
        configSignOutButton()
        view.addSubview(settingsTable)
        settingsTable.tableFooterView?.addSubview(signOutBtn)
    }
    
    private func configSettingsTableView() {
        settingsTable.addTableHeaderView()
        settingsTable.addTableFooterView(200)
        settingsTable.dataSource = self
        settingsTable.delegate = self
    }
    
    private func configSignOutButton() {
        signOutBtn.frame = CGRectMake(UIConst.defaultInset, 28, UIScreen.width - UIConst.defaultInset * 2, 50)
        signOutBtn.setTitle(configurator.signOutBtnTitle(), forState: .Normal)
        signOutBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        signOutBtn.titleLabel?.font = UIFont.button
        signOutBtn.backgroundColor = UIColor.main
        signOutBtn.layer.cornerRadius = 4
        signOutBtn.rx_tap
            .subscribeNext({
                print("退出登录.")
            })
            .addDisposableTo(dispose)
    }
    
}

extension SettingsViewController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return configurator.headersCount()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return configurator.cellsCount(section)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: RightForCustomViewDefaultCell = tableView.dequeueStaticCell(indexPath)
        cell.titleLabel.text = configurator.cellTitle(indexPath)
        cell.selectionStyle = .None
        cell.accessoryType = configurator.checkCellAccessoryType(indexPath)
        let rightViewType = configurator.findRightViewType(indexPath)
        if cell.contentView.subviews.count < 2 {
            switch rightViewType {
                case .Empty:
                    break
                case .Label:
                    let settingLabel = UILabel.init()
                    settingLabel.textColor = UIColor.lightGrayColor()
                    settingLabel.font = UIFont.body
                    cell.addRightView(settingLabel, rightViewContraintsMaker: { (maker) in
                        maker.right.equalTo(cell.accessoryType == .DisclosureIndicator ? 0 : -UIConst.defaultInset)
                        maker.centerY.equalTo(0)
                    })
                case .Switch:
                    let settingSwitch = SettingSwitch.init(switchMark: indexPath)
                    cell.addRightView(settingSwitch, rightViewContraintsMaker: { (maker) in
                        maker.right.equalTo(-UIConst.defaultInset)
                        maker.centerY.equalTo(0)
                    })
            }
        }
        if rightViewType == .Label {
            (cell.rightView as? UILabel)?.text = "aaaa"
        }
        return cell
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header: UITableViewHeaderFooterView = tableView.dequeueStaticHeaderView(section)
        if header.contentView.subviews.count == 0 {
            let label = UILabel.init(frame: CGRectMake(UIConst.defaultInset, 0, 200, self.tableView(tableView, heightForHeaderInSection: section)))
            label.textColor = UIColor.title
            label.font = UIFont.title
            label.text = configurator.headerTitle(section)
            header.contentView.addSubview(label)
        }
        return header
    }
    
}

extension SettingsViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return configurator.cellHeight(indexPath)
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return configurator.headerHeight(section)
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.min
    }
    
}
