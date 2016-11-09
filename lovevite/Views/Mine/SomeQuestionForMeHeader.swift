//
//  SomeQuestionForMeHeader.swift
//  lovevite
//
//  Created by Eason Leo on 2016/11/6.
//  Copyright © 2016年 lovevite. All rights reserved.
//

import UIKit

class SomeQuestionForMeHeader: UITableViewHeaderFooterView {

    var question: String? {
        willSet {
            questionLabel.text = newValue
        }
    }
    
    let disposeBag = DisposeBag()
    
    let tapEdite = PublishSubject<Void>()
    
    private let questionLabel = UILabel()
    
    private let editeBtn = UIButton.init(type: UIButtonType.System)
    
    private let editeItemView = UIImageView(image: UIImage(named: "edite"))
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor.whiteColor()
        
        questionLabel.textColor = UIColor.title
        questionLabel.font = UIFont.title
        contentView.addSubview(questionLabel)
        
        contentView.addSubview(editeBtn)
        editeBtn.rx_tap.subscribeNext { [weak self] in
            self?.tapEdite.onNext()
        }.addDisposableTo(disposeBag)
        
        contentView.addSubview(editeItemView)
        
        setNeedsUpdateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension SomeQuestionForMeHeader {
    
    override func updateConstraints() {
        super.updateConstraints()
        questionLabel.snp_makeConstraints { (make) in
            make.left.equalTo(UIConst.defaultInset)
            make.centerY.equalTo(0)
            make.right.greaterThanOrEqualTo(editeBtn.snp_left).offset(-5)
        }
        editeBtn.snp_makeConstraints { (make) in
            make.top.bottom.right.equalTo(0)
        }
        editeItemView.snp_makeConstraints { (make) in
            make.centerY.equalTo(0)
            make.right.equalTo(-UIConst.defaultInset)
        }
    }
    
}
