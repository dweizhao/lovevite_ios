//
//  SomeQuestionForMeViewModel.swift
//  lovevite
//
//  Created by Eason Leo on 2016/11/6.
//  Copyright © 2016年 lovevite. All rights reserved.
//

import UIKit

class SomeQuestionForMeViewModel: Response {

    var info: Array<Dictionary<String, String>> = [["我的独白":"jkasdjaksdjljjkasdjaksdjljjkasdjaksdjljjkasdjaksdjljjkasdjaksdjljjkasdjaksdjljjkasdjaksdjljjkasdjaksdjljjkasdjaksdjljjkasdjaksdjljjkasdjaksdjljjkasdjaksdjljjkasdjaksdjljjkasdjaksdjljjkasdjaksdjljjkasdjaksdjljjkasdjaksdjljjkasdjaksdjljjkasdjaksdjljjkasdjaksdjljjkasdjaksdjljjkasdjaksdjljjkasdjaksdjlj"], ["最让我开心的几件事":"哈几十块的痕迹阿克苏的哈桑哈几十块的痕迹阿克苏的哈桑哈几十块的痕迹阿克苏的哈桑哈几十块的痕迹阿克苏的哈桑哈几十块的痕迹阿克苏的哈桑"], ["哈哈哈哈":"哈几十块的痕迹阿克苏的哈桑哈几十块的痕迹阿克苏的哈桑jsakljlkdjalksjdlkasjd\nakjldjaskljd"]]
    
}

extension SomeQuestionForMeViewModel {
    
    var titlesCount: Int {
        return 3
    }
    
    func title(index: Int) -> String? {
        if index < info.count {
            return info[index].keys.first
        }
        return nil
    }
    
    func answer(index: Int) -> String? {
        if index < info.count {
            return info[index].values.first
        }
        return nil
    }
    
}
