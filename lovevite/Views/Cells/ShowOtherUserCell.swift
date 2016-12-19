//
//  ShowUserCell.swift
//  lovevite
//
//  Created by Eason Leo on 2016/11/20.
//  Copyright © 2016年 lovevite. All rights reserved.
//

import UIKit

class ShowOtherUserCell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let avatarImageView = UIImageView()
    
    private let baseInfoLabel = UILabel()
    
    private let locationLabel = UILabel()
    
    private let introduceLabel = UILabel()
    
    private let inset = 14.0
    
    func initialize() {
        selectionStyle = .None
        
        avatarImageView.layer.cornerRadius = 30.0
        avatarImageView.layer.masksToBounds = true
        contentView.addSubview(avatarImageView)
        avatarImageView.snp_makeConstraints { (make) in
            make.left.top.equalTo(inset)
            make.width.height.equalTo(60.0)
        }
        
        baseInfoLabel.textColor = UIColor.title
        baseInfoLabel.font = UIFont.title(0.1)
        contentView.addSubview(baseInfoLabel)
        baseInfoLabel.snp_makeConstraints { (make) in
            make.left.equalTo(avatarImageView.snp_right)
                .offset(inset * 3.0 / 4.0)
            make.top.equalTo(avatarImageView.snp_top)
                .offset(5.0)
        }
        
        locationLabel.textColor = UIColor.text
        locationLabel.font = UIFont.subtitle
        contentView.addSubview(locationLabel)
        locationLabel.snp_makeConstraints { (make) in
            make.left.equalTo(baseInfoLabel)
            make.bottom.equalTo(avatarImageView.snp_bottom).offset(-5.0)
        }
        
        introduceLabel.textColor = UIColor.text
        introduceLabel.font = UIFont.subtitle
        introduceLabel.numberOfLines = 2
        introduceLabel.lineBreakMode = .ByTruncatingTail
        contentView.addSubview(introduceLabel)
        introduceLabel.snp_makeConstraints { (make) in
            make.left.equalTo(avatarImageView)
            make.top.equalTo(avatarImageView.snp_bottom)
                .offset(inset)
            make.right.bottom.equalTo(-inset)
        }
    }
    
    func configTheCell(viewModel: ShowOtherUsersListTableViewModel, indexPath: NSIndexPath) {
        let idx = indexPath.row
        avatarImageView.yy_setImageWithURL(viewModel.userAvatarURL(idx), options: .SetImageWithFadeAnimation)
        baseInfoLabel.text = viewModel.userBaseInfoString(idx)
        locationLabel.text = viewModel.userLocationString(idx)
        introduceLabel.text = viewModel.userIntroduce(idx)
    }

}
