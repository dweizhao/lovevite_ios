//
//  TrueWordsQuestionCell.swift
//  lovevite
//
//  Created by Eason Leo on 2016/11/6.
//  Copyright © 2016年 lovevite. All rights reserved.
//

import UIKit

class TrueWordsQuestionCell: UITableViewCell {

    var question: String? {
        willSet {
            questionLabel.text = newValue
        }
    }
    
    private let bgView = UIView()
    
    private let questionLabel = UILabel()
    
    private let passBtn = UIButton.init(type: UIButtonType.System)
    
    private let answerBtn = UIButton.init(type: UIButtonType.System)
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor.bgGray
        
        bgView.backgroundColor = UIColor.clearColor()
        bgView.layer.contents =  UIImage(named: "circular_border_bg")?.CGImage
        bgView.setShadow()
        contentView.addSubview(bgView)
        
        questionLabel.textColor = UIColor.text
        questionLabel.font = UIFont.body
        questionLabel.numberOfLines = 0
        bgView.addSubview(questionLabel)
        
        passBtn.setAttributedTitle(NSAttributedString.init(string: "跳过".es_ml(), attributes: [NSForegroundColorAttributeName:UIColor.textGray, NSFontAttributeName:UIFont.button]), forState: .Normal)
        bgView.addSubview(passBtn)
        
        let separator = UIView()
        separator.backgroundColor = UIColor.bgGray
        
        bgView.addSubview(separator)
        separator.snp_makeConstraints { (make) in
            make.left.equalTo(UIConst.defaultInset - 4.0)
            make.right.equalTo(-UIConst.defaultInset + 4.0)
            make.height.equalTo(1)
            make.bottom.equalTo(passBtn.snp_top)
        }
        
        answerBtn.setAttributedTitle(NSAttributedString.init(string: "回答".es_ml(), attributes: [NSForegroundColorAttributeName:UIColor.text, NSFontAttributeName:UIFont.button]), forState: .Normal)
        bgView.addSubview(answerBtn)
        
        setNeedsUpdateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension TrueWordsQuestionCell {
    
    override func updateConstraints() {
        super.updateConstraints()
        bgView.snp_makeConstraints { (make) in
            make.left.equalTo(UIConst.defaultInset)
            make.right.equalTo(-UIConst.defaultInset)
            make.top.equalTo(3.0)
            make.bottom.equalTo(-3.0)
        }
        questionLabel.snp_makeConstraints { (make) in
            make.left.equalTo(UIConst.defaultInset)
            make.right.equalTo(-UIConst.defaultInset)
            make.top.equalTo(16.0)
            make.bottom.equalTo(passBtn.snp_top).offset(-17.0)
        }
        passBtn.snp_makeConstraints { (make) in
            make.left.equalTo(bgView)
            make.bottom.equalTo(bgView)
            make.height.equalTo(45.0)
        }
        answerBtn.snp_makeConstraints { (make) in
            make.right.equalTo(bgView)
            make.width.bottom.height.equalTo(passBtn)
            make.left.equalTo(passBtn.snp_right)
        }
    }
    
}
