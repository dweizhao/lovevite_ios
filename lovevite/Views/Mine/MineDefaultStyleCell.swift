//
//  MineDefaultStyleCell.swift
//  lovevite
//
//  Created by Eason Leo on 2016/10/24.
//  Copyright © 2016年 lovevite. All rights reserved.
//

import Foundation

class MineDefaultStyleCell: UITableViewCell {
    
    var title: String? {
        willSet {
            textLabel?.text = title
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .Default, reuseIdentifier: reuseIdentifier)
        textLabel?.textColor = UIColor.title
        textLabel?.font = UIFont.title
        detailTextLabel?.textColor = UIColor.textGray
        detailTextLabel?.font = UIFont.body
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
