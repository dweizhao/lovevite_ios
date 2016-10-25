//
//  RightForCustomVIewDefaultCell.swift
//  lovevite
//
//  Created by Eason Leo on 2016/9/28.
//  Copyright © 2016年 lovevite. All rights reserved.
//

import UIKit

class RightForCustomVIewDefaultCell: UITableViewCell {

    let titleLabel = UILabel()
    
    var rightView: UIView?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configTitleLabel()
        contentView.addSubview(titleLabel)
        setNeedsUpdateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension RightForCustomVIewDefaultCell {
    
    private func configTitleLabel() {
        titleLabel.textColor = UIColor.title
        titleLabel.font = UIFont.body
        titleLabel.textAlignment = .Left
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        titleLabel.snp_makeConstraints { (make) in
            make.left.equalTo(UIConst.defaultInset * 2)
            make.top.bottom.equalTo(contentView)
        }
    }
    
}

extension RightForCustomVIewDefaultCell {
    
    func addRightView(view: UIView, rightViewContraintsMaker maker: ((ConstraintMaker) -> Void)? = nil) {
        rightView = view
        if rightView?.superview == nil {
            contentView.addSubview(rightView!)
        }
        if let mark = maker {
            rightView?.snp_remakeConstraints(closure: mark)
        }
    }
    
}
