//
//  UIVIew+function.swift
//  lovevite
//
//  Created by Eason Leo on 2016/10/31.
//  Copyright © 2016年 lovevite. All rights reserved.
//

import UIKit

extension UIView {
    
    func firstInputResponder() -> UIView? {
        return firstInputResponder(self)
    }
    
    private func firstInputResponder(view : UIView?) -> UIView?{
        if let view = view {
            if view.isFirstResponder() && (view is UITextInput){
                return view
            }else{
                for subview in view.subviews{
                    if let firstView = firstInputResponder(subview){
                        return firstView
                    }
                }
            }
        }
        return nil
    }
    
}

// MARK: MBProgressHUD quickly launch

extension UIView {
    
    private static let HUBHideDelay = 1.0
    
    func showMsgHUD(msg : String?) {
        let hub = MBProgressHUD.showHUDAddedTo(self, animated: true)
        hub.mode = .Text
        hub.label.text = msg
        hub.hideAnimated(true, afterDelay: UIView.HUBHideDelay)
    }
    
    func showLoadingHUD() {
        MBProgressHUD.showHUDAddedTo(self, animated: true)
    }
    
    func showLoadingHUD(msg: String?) {
        let hub = MBProgressHUD.showHUDAddedTo(self, animated: true)
        hub.label.text = msg
    }
    
    func hideAllHUDs() {
        MBProgressHUD.hideHUDForView(self, animated: true)
    }
    
}
