//
//  SigninViewController.swift
//  lovevite
//
//  Created by Eason Leo on 2016/10/31.
//  Copyright © 2016年 lovevite. All rights reserved.
//

import UIKit

class SigninViewController: BaseViewController {

    private let tableView: UITableView = {
        let t = UITableView.init(frame: UIScreen.frame, style: .Grouped)
        t.backgroundColor = UIColor.bgGray
        t.addTableHeaderView()
        t.addTableFooterView(200)
        t.showsVerticalScrollIndicator = false
        t.showsHorizontalScrollIndicator = false
        t.keyboardDismissMode = .OnDrag
        return t
    }()
    
    private let protocolView = AbideProtocolView.init(note: "我确认已阅读并同意".es_ml(), protocol1Name: "隐私政策".es_ml(), protocol2Name: "使用条件".es_ml())
    
    private let signinBtn: UIButton = {
        let btn = UIButton.init(type: UIButtonType.System)
        btn.setTitle("免费注册".es_ml(), forState: .Normal)
        btn.layer.cornerRadius = 4
        btn.setShadow()
        return btn
    }()
    
    private let viewModel = SigninViewModel()
    
}

extension SigninViewController {
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
    }
    
    override func initialize() {
        title = viewModel.title()
        
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)

        protocolView.rx_observe(Bool.self, "isAbide").subscribeNext { [weak self] abide in
            let couldSignin = abide ?? true
            self?.signinBtn.enabled = couldSignin
            if couldSignin {
                self?.signinBtn.backgroundColor = UIColor.main
                self?.signinBtn.tintColor = UIColor.whiteColor()
            } else {
                self?.signinBtn.backgroundColor = UIColor.main.colorWithAlphaComponent(0.7)
                self?.signinBtn.tintColor = UIColor.whiteColor().colorWithAlphaComponent(0.7)
            }
        }.addDisposableTo(disposeBag)
        
        tableView.tableFooterView?.addSubview(protocolView)
        protocolView.snp_makeConstraints { (make) in
            make.top.equalTo(5)
            make.centerX.equalTo(0)
            make.height.equalTo(40)
        }
        
        tableView.tableFooterView?.addSubview(signinBtn)
        signinBtn.snp_makeConstraints { (make) in
            make.left.equalTo(UIConst.defaultInset)
            make.right.equalTo(-UIConst.defaultInset)
            make.bottom.equalTo(0)
            make.height.equalTo(Scale.height(45))
        }
        
        signinBtn.rx_tap.subscribeNext { [weak self] in
            self?.presentingViewController?.dismissViewControllerAnimated(true, completion: { 
                ViewControllerManager.manager.mainTabbarViewController.view.showMsgHUD("模拟注册成功")
            })
        }.addDisposableTo(disposeBag)
        
    }
    
}

extension SigninViewController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cellsCount(section)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: RightForCustomViewDefaultCell = tableView.dequeueStaticCell(indexPath)
        cell.titleLabel.text = viewModel.cellTitle(indexPath)
        if indexPath.section == 0 {
            cell.addRightView(viewModel.baseInfoTextField(indexPath)) { (maker) in
                maker.left.equalTo(SigninUIContent.cellLeftInset)
                maker.top.bottom.right
                    .equalTo(0)
            }
        } else {
            cell.accessoryType = .DisclosureIndicator
            cell.addRightView(viewModel.detailsInfoRightView(indexPath), rightViewContraintsMaker: { (maker) in
                maker.top.bottom.equalTo(0)
                maker.right.equalTo(-10.0)
            })
        }
        cell.selectionStyle = .None
        return cell
    }
    
}

extension SigninViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UIConst.topInset
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.min
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init()
        view.backgroundColor = UIColor.bgGray
        return view
    }
    
}
