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
        initializeUserInterface()
    }
    
    func initializeUserInterface() {
        view.backgroundColor = UIColor.bgGray
    }
    
    func responseUIEvent() {}

}
