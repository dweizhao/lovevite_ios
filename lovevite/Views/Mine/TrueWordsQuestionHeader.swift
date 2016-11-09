//
//  TrueWordsQuestionHeader.swift
//  lovevite
//
//  Created by Eason Leo on 2016/11/6.
//  Copyright © 2016年 lovevite. All rights reserved.
//

import UIKit

class TrueWordsQuestionHeader: UITableViewHeaderFooterView {
    
    var title: String? {
        willSet {
            titleLabel.text = newValue
        }
    }

    private let titleLabel = UILabel()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor.bgGray
        
        titleLabel.textColor = UIColor.title
        titleLabel.font = UIFont.title(0.3)
        contentView.addSubview(titleLabel)
        
        setNeedsUpdateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension TrueWordsQuestionHeader {
    
    override func updateConstraints() {
        super.updateConstraints()
        titleLabel.snp_makeConstraints { (make) in
            make.left.equalTo(UIConst.defaultInset)
            make.right.equalTo(-UIConst.defaultInset)
            make.centerY.equalTo(0)
        }
    }
    
}
