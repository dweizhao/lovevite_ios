//
//  MultipleTabsView.swift
//  lovevite
//
//  Created by Eason Leo on 2016/10/24.
//  Copyright © 2016年 lovevite. All rights reserved.
//

import Foundation

class MultipleTabsView: UICollectionView {
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    override convenience init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        self.init()
    }
    
    init() {
        let fl = UICollectionViewFlowLayout.init()
        fl.minimumLineSpacing = CGFloat.min
        fl.minimumInteritemSpacing = CGFloat.min
        fl.scrollDirection = .Horizontal
        fl.itemSize = UIScreen.size
        super.init(frame: UIScreen.frame, collectionViewLayout: fl)
        backgroundColor = UIColor.bgGray
        allowsSelection = false
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        pagingEnabled = true
    }
    
}
