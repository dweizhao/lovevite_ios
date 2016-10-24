//
//  SettingsUserInterfaceContent.swift
//  lovevite
//
//  Created by Eason Leo on 2016/9/27.
//  Copyright © 2016年 lovevite. All rights reserved.
//

import UIKit

class SettingsUserInterfaceContent: NSObject {
    
    let viewControllerTitle = "设置"
    
    let signOutButtonTitle = "退出登录"
    
    let headerTitles: Array<String> = ["基本信息", "邮件通知设置", "推送设置", "其他"]
    
    let cellTitles: Dictionary<Int, Array<String>> = [0:["邮箱", "密码", "语言", "金币", "vip"], 1:["新的来访者", "新的关注"], 2:["私信", "媚眼", "收藏"], 3:["关于我们", "隐私申明", "使用协议", "帮助中心"]]
    
    let infoManager = SettingsInfoManagerInService()
    
    var infoModel: SettingsInfoModel?
    
    private let dispose = DisposeBag.init()
    
    override init() {
        super.init()
        updateSettingsInfo()
    }

}

extension SettingsUserInterfaceContent {
    
    private func updateSettingsInfo() {
        infoManager
            .requestSettingsInfo()
            .delaySubscription(2.0, scheduler: MainScheduler.instance)
            .subscribeNext { (model) in
                self.infoModel = model
        }
            .addDisposableTo(dispose)
    }
    
}
