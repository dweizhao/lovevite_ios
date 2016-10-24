//
//  SettingsUserInterfaceData.swift
//  lovevite
//
//  Created by Eason Leo on 2016/10/9.
//  Copyright © 2016年 lovevite. All rights reserved.
//

import UIKit

class SettingsInfoManagerInService: NSObject {
    
    

}

extension SettingsInfoManagerInService {
    
    func requestSettingsInfo() -> Observable<SettingsInfoModel> {
        let model = SettingsInfoModel()
        model.email = "1003004733@qq.com"
        model.language = "中文"
        model.coin = 100.00
        model.vip = true
        model.newVisitorNoti = false
        model.newFollowerNoti = true
        model.messageNoti = false
        model.favorNoti = true
        model.collectNoti = true
        
        return Observable.create { (obj) -> Disposable in
            obj.onNext(model)
            obj.onCompleted()
            return NopDisposable.instance
        }
        
    }
    
}
