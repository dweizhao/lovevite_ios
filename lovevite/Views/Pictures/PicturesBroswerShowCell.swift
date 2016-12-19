//
//  PicturesBroswerShowCell.swift
//  lovevite
//
//  Created by Eason Leo on 2016/11/11.
//  Copyright © 2016年 lovevite. All rights reserved.
//

import Foundation

class PicturesBroswerShowCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = nil
        
        pictureView.userInteractionEnabled = true
        contentView.addSubview(pictureView)
        pictureView.snp_makeConstraints { (make) in
            make.centerX.equalTo(0)
            make.centerY.equalTo(-UIScreen.navigationBarHeight / 2.0)
            make.width.height.equalTo(UIScreen.width)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let pictureView = UIImageView()
    
}
