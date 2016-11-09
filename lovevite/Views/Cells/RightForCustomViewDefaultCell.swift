//
//  RightForCustomViewDefaultCell.swift
//  lovevite
//
//  Created by Eason Leo on 2016/9/28.
//  Copyright © 2016年 lovevite. All rights reserved.
//

import UIKit

class RightForCustomViewDefaultCell: UITableViewCell {

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

extension RightForCustomViewDefaultCell {
    
    private func configTitleLabel() {
        titleLabel.textColor = UIColor.title
        titleLabel.font = UIFont.body
        titleLabel.textAlignment = .Left
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        titleLabel.snp_makeConstraints { (make) in
            make.left.equalTo(UIConst.defaultInset * 2)
            make.centerY.equalTo(-1)
        }
    }
    
}

extension RightForCustomViewDefaultCell {
    
    func addRightView(view: UIView, rightViewContraintsMaker maker: ((ConstraintMaker) -> Void)) {
        rightView = view
        if rightView?.superview == nil {
            contentView.addSubview(rightView!)
        }
        rightView?.snp_remakeConstraints(closure: maker)
    }
    
}
