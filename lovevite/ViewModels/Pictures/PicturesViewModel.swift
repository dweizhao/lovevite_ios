//
//  PicturesViewModel.swift
//  lovevite
//
//  Created by Eason Leo on 2016/11/11.
//  Copyright © 2016年 lovevite. All rights reserved.
//

import Foundation

class PicturesViewModel: NSObject {
    
    var pictures: Array<PictureModel> = Array.init(count: 30, repeatedValue: 1).map { (_) -> PictureModel in
        return PictureModel.init(Map.init(mappingType: .FromJSON, JSONDictionary: ["photolg":"http://img6.bdstatic.com/img/image/smallpic/mingxing1108.jpg"]))!
    }
    
}

extension PicturesViewModel: PicturesProtocol {
    
    func picturesCount() -> Int {
        return pictures.count
    }
    
    func pictureURL(index: Int) -> NSURL? {
        if index < pictures.count {
            return NSURL.init(string: pictures[index].photolg ?? "")
        }
        return nil
    }
    
}
