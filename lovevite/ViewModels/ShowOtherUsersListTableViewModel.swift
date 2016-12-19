//
//  ShowOtherUsersListTableViewModel.swift
//  lovevite
//
//  Created by Eason Leo on 2016/11/24.
//  Copyright © 2016年 lovevite. All rights reserved.
//

import Foundation

protocol ShowOtherUsersListTableViewModel {
    
    func cellsCount(section: Int) -> Int
    
    func userAvatarURL(idx: Int) -> NSURL?
    
    func userBaseInfoString(idx: Int) -> String
    
    func userLocationString(idx: Int) -> String
    
    func userIntroduce(idx: Int) -> String?
    
}
