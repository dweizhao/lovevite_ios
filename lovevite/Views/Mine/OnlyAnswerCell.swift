//
//  OnlyAnswerCell.swift
//  lovevite
//
//  Created by Eason Leo on 2016/11/6.
//  Copyright © 2016年 lovevite. All rights reserved.
//

import UIKit

class OnlyAnswerCell: UITableViewCell {

    var answer: String? {
        willSet {
            answerLabel.text = newValue
        }
    }
    
//    private let bgView = UIView()
    
    private let answerLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor.bgDarkGray
        selectionStyle = .None
        
//        bgView.backgroundColor = UIColor.color(hexValue: 0xf3f3f3)
//        bgView.layer.cornerRadius = 5
//        bgView.layer.masksToBounds = true
//        contentView.addSubview(bgView)
        
        answerLabel.textColor = UIColor.text
        answerLabel.font = UIFont.body
        answerLabel.numberOfLines = 0
//        bgView.addSubview(answerLabel)
        contentView.addSubview(answerLabel)
        
        setNeedsUpdateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension OnlyAnswerCell {
    
    override func updateConstraints() {
        super.updateConstraints()
//        bgView.snp_makeConstraints { (make) in
//            make.left.top.equalTo(UIConst.defaultInset)
//            make.right.bottom.equalTo(-UIConst.defaultInset)
//        }
        answerLabel.snp_makeConstraints { (make) in
//            make.left.top.equalTo(bgView).offset(10.0)
//            make.right.bottom.equalTo(bgView).offset(-10.0)
            make.left.top.equalTo(UIConst.defaultInset)
            make.right.bottom.equalTo(-UIConst.defaultInset)
        }
    }
    
}
