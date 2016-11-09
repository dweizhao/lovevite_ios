//
//  TrueWordsViewModel.swift
//  lovevite
//
//  Created by Eason Leo on 2016/11/6.
//  Copyright © 2016年 lovevite. All rights reserved.
//

import UIKit

class TrueWordsViewModel: Response {

    private let titles = ["公开的问题", "私密的问题", "跳过的问题", "非常重要的问题", "重要的问题", "不重要的问题", "无关紧要的问题"]
    
}

extension TrueWordsViewModel {
    
    func numberOfRowsInSection(section: Int) -> Int {
        return section == 0 ? 1 : titles.count
    }
    
    func headerTitle(section: Int) -> String {
        if section == 0 {
            return "新问题".es_ml()
        } else if section == 1 {
            return "已看过的问题".es_ml()
        }
        return "error"
    }
    
    func question() -> String {
        return "加快圣诞节快拉上建档立卡就爱上的离开就爱看了圣诞节加快圣诞节快拉上建档立卡就爱上的离开就爱看了圣诞节加快圣诞节快拉上建档立卡就爱上的离开就爱看了圣诞节加快圣诞节快拉上建档立卡就爱上的离开就爱看了圣诞节"
    }
    
    func cellTitles(row: Int) -> String? {
        if row < titles.count {
            return titles[row].es_ml()
        }
        return nil
    }
    
    func answeredCount() -> Int {
        return 11
    }
    
    func answerCount(row: Int) -> String? {
        let count = 11
        return "(\(count)个)"
    }
    
}
