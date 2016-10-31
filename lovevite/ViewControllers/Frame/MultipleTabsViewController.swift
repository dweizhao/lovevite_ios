//
//  MultipleTabsViewController.swift
//  lovevite
//
//  Created by Eason Leo on 2016/10/24.
//  Copyright © 2016年 lovevite. All rights reserved.
//

import UIKit

class MultipleTabsViewController: BaseViewController {
    
    private let backgroundView = MultipleTabsView()
    
    dynamic var currentIndex: Int = 0
    
    @objc var subViewControllers: Array<BaseViewController>? {
        return nil
    }
    
    struct ReuseIdentifier {
        
        static let viewControllerCell = "viewControllerCell"
        
    }
    
}

extension MultipleTabsViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    override func initialize() {
        if let _ = subViewControllers {
            backgroundView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: ReuseIdentifier.viewControllerCell)
            backgroundView.dataSource = self
            backgroundView.delegate = self
            view.addSubview(backgroundView)
        }
    }

}

extension MultipleTabsViewController: UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return subViewControllers?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(ReuseIdentifier.viewControllerCell, forIndexPath: indexPath)
        if cell.contentView.subviews.count == 0 {
            if let vc = subViewControllers?[indexPath.item] {
                addChildViewController(vc)
                cell.contentView.addSubview(vc.view)
            }
        }
        return cell
    }
    
}

extension MultipleTabsViewController: UICollectionViewDelegate {
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView == backgroundView {
            currentIndex = Int(round(scrollView.contentOffset.x / UIScreen.width))
        }
    }
    
}
