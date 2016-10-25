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
        initializeUserInterface()
    }
    
    override func initializeUserInterface() {
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

extension MultipleTabsViewController: UICollectionViewDelegate {}
