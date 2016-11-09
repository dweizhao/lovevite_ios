//
//  UICollectionView+extension.swift
//  lovevite
//
//  Created by Eason Leo on 2016/11/8.
//  Copyright © 2016年 lovevite. All rights reserved.
//

import Foundation

extension UICollectionView {
    
    func dequeueStaticCell<T: UICollectionViewCell>(indexPath: NSIndexPath) -> T {
        let reuseIdentifier = "\(T.description()) - \(indexPath.description)"
        registerClass(T.self, forCellWithReuseIdentifier: reuseIdentifier)
        if let cell = self.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as? T {
            return cell
        } else {
            let cell = T()
            return cell
        }
    }
    
}
