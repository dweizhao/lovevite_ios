//
//  AnsweredCountRecordView.swift
//  lovevite
//
//  Created by Eason Leo on 2016/11/8.
//  Copyright © 2016年 lovevite. All rights reserved.
//

import Foundation

class AnsweredCountRecordView: UIView {
    
    var count: Int = 0 {
        willSet {
            let text = "已回答".es_ml() + "\(newValue)" + "个问题".es_ml()
            let mutAtr = NSMutableAttributedString.init(string: text)
            mutAtr.addAttribute(NSFontAttributeName, value: UIFont.title, range: NSMakeRange("已回答".es_ml().characters.count, "\(newValue)".characters.count))
            recordLabel.attributedText = mutAtr
        }
    }
    
    private let recordLabel = UILabel()
    
    init() {
        super.init(frame: CGRectZero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.main
        layer.cornerRadius = 5
        layer.masksToBounds = true
        
        recordLabel.textColor = UIColor.whiteColor()
        recordLabel.font = UIFont.body
        addSubview(recordLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension AnsweredCountRecordView {
    
    override func updateConstraints() {
        super.updateConstraints()
        recordLabel.snp_makeConstraints { (make) in
            make.left.equalTo(5.0)
            make.right.equalTo(-5.0)
            make.top.equalTo(3.0)
            make.bottom.equalTo(-3.0)
        }
    }
    
}
