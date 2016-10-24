//
//  SettingSwitchManager.swift
//  lovevite
//
//  Created by Eason Leo on 2016/10/8.
//  Copyright © 2016年 lovevite. All rights reserved.
//

import UIKit

class SettingSwitchManager: NSObject {
    
    private enum functionType {
        // 意外处理
        case Empty
        // 邮件通知设置
        case NewVisitors        // 新的来访者
        case NewFollowers       // 新的关注
        // 推送设置
        case Message            // 私信
        case Favour             // 媚眼
        case Collect            // 收藏
    }
    
    private func functionTypeRecognize(switchMark: NSIndexPath?) -> functionType {
        if switchMark == nil {
            return .Empty
        }
        if switchMark!.section == 1 {
            switch switchMark!.row {
            case 0:
                return .NewVisitors
            case 1:
                return .NewFollowers
            default:
                return .Empty
            }
        } else if switchMark!.section == 2 {
            switch switchMark!.row {
            case 0:
                return .Message
            case 1:
                return .Favour
            case 2:
                return .Collect
            default:
                return .Empty
            }
        } else {
            return .Empty
        }
    }

}

extension SettingSwitchManager {
    
    private func handleEmailNotificationOnNewVisitors(on: Bool) -> Void {
        let state = on == true ? "打开" : "关闭"
        print("新的来访者邮件通知" + state)
    }
    
    private func handleEmailNotificationOnNewFollwers(on: Bool) -> Void {
        let state = on == true ? "打开" : "关闭"
        print("新的关注者邮件通知" + state)
    }
    
    private func handleRemoteNotificationOnMessage(on: Bool) -> Void {
        let state = on == true ? "打开" : "关闭"
        print("消息推送通知" + state)
    }
    
    private func handleRemoteNotificationOnFavour(on: Bool) -> Void {
        let state = on == true ? "打开" : "关闭"
        print("媚眼推送通知" + state)
    }
    
    private func handleRemoteNotificationOnCollect(on: Bool) -> Void {
        let state = on == true ? "打开" : "关闭"
        print("收藏推送通知" + state)
    }
    
}

extension SettingSwitchManager {
    
    func handleSwitchEvent(switchMark indexPath: NSIndexPath?, switchState on: Bool) {
        let functionType = functionTypeRecognize(indexPath)
        switch functionType {
        case .NewVisitors:
            handleEmailNotificationOnNewVisitors(on)
        case .NewFollowers:
            handleEmailNotificationOnNewFollwers(on)
        case .Message:
            handleRemoteNotificationOnMessage(on)
        case .Favour:
            handleRemoteNotificationOnFavour(on)
        case .Collect:
            handleRemoteNotificationOnCollect(on)
        case .Empty:
            break
        }
    }
    
}
