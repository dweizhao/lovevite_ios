//
//  Calculate.swift
//  lovevite
//
//  Created by Eason Leo on 2016/11/14.
//  Copyright © 2016年 lovevite. All rights reserved.
//

import Foundation

struct Calculate {
    
    static func distance(point1: CGPoint, point2: CGPoint) -> CGFloat {
        let xD = point1.x - point2.x
        let yD = point1.y - point2.y
        let d = sqrt(pow(xD, 2) + pow(yD, 2))
        return d
    }
    
}
