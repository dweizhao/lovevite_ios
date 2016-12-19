//
//  PicturesProtocol.swift
//  lovevite
//
//  Created by Eason Leo on 2016/11/11.
//  Copyright © 2016年 lovevite. All rights reserved.
//

import Foundation

protocol PicturesProtocol {
    
    func picturesCount() -> Int
    
    func pictureURL(index: Int) -> NSURL?
    
}
