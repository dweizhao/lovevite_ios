//
//  PicturesBroswerViewModel.swift
//  lovevite
//
//  Created by Eason Leo on 2016/11/11.
//  Copyright © 2016年 lovevite. All rights reserved.
//

import Foundation

class PicturesBroswerViewModel: PicturesViewModel {
    
    var index: Int = 0
    
}

extension PicturesBroswerViewModel {
    
    private var title: String {
        if picturesCount() == 0 {
            return "暂无图片".es_ml()
        }
        return "\(index + 1)/\(picturesCount())"
    }
    
    func title(index: Int? = nil) -> String {
        guard let idx = index else {
            return title
        }
        return "\(idx + 1)/\(picturesCount())"
    }
    
}

// MARK: edit picture.

extension PicturesBroswerViewModel {
    
    func pictureDesciption(index: Int? = nil) -> String? {
        return (index ?? self.index) % 2 == 0 ? "考虑接的考拉姐看多了就爱看了圣诞节卡拉胶打卡里就考虑接的考拉姐看多了就爱看了圣诞节卡拉胶打卡里就考虑接的考拉姐看多了就爱看了圣诞节卡拉胶打卡里就考虑接的考拉姐看多了就爱看了圣诞节卡拉胶打卡里就考虑接的考拉姐看多了就爱看了圣诞节卡拉胶打卡里就考虑接的考拉姐看多了就爱看了圣诞节卡拉胶打卡里就" : "考虑接的考拉姐看多了就爱看了圣诞节卡拉胶打卡里就"
    }
    
    func pictureUploadDate(index: Int? = nil) -> String? {
        return "2016-11-14 14:22"
    }
    
}
