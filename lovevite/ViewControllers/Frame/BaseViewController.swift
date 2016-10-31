//
//  BaseViewController.swift
//  lovevite
//
//  Created by Eason Leo on 2016/9/27.
//  Copyright © 2016年 lovevite. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        initialize()
    }
    
    func initialize() {
        view.backgroundColor = UIColor.bgGray
    }

}

extension BaseViewController {
    
    // subclass could override the function to change operation.
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.firstInputResponder()?.resignFirstResponder()
    }
    
}
