//
//  SettingSwitch.swift
//  lovevite
//
//  Created by Eason Leo on 2016/10/8.
//  Copyright © 2016年 lovevite. All rights reserved.
//

import UIKit

class SettingSwitch: UISwitch {
    
    private var switchMark: NSIndexPath?
    
    private let dispose = DisposeBag()
    
    private let manager = SettingSwitchManager()

    convenience init(switchMark indexPath: NSIndexPath?) {
        self.init()
        if let idx = indexPath {
            switchMark = idx
        }
        rx_value
            .filter({ (on) -> Bool in
                return !self.hidden
            })
            .subscribeNext ({ (on) in
                self.manager.handleSwitchEvent(switchMark: self.switchMark!, switchState: on)
            })
            .addDisposableTo(dispose)
    }
    
    override var on: Bool {
        willSet {
            hidden = false
            super.on = newValue
        }
    }

}
