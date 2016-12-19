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
    
    private var tabIndex: Int = 0
    
    private struct ReuseIdentifier {
        static let viewControllerCell = "viewControllerCell"
    }
    
    dynamic var currentIndex: Int {
        set {
            tabIndex = newValue
            indexSubject.onNext(newValue)
        }
        get {
            return tabIndex
        }
    }
    
    @objc var subViewControllers: Array<BaseViewController>? {
        return nil
    }
    
    @objc var segmentView: ESSegmentControl? {
        return nil
    }
    
    let indexSubject = PublishSubject<Int>()
    
}

extension MultipleTabsViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func initialize() {
        super.initialize()
        if let _ = subViewControllers {
            backgroundView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: ReuseIdentifier.viewControllerCell)
            backgroundView.dataSource = self
            backgroundView.delegate = self
            view.addSubview(backgroundView)
            
            indexSubject.subscribeNext({ [weak self] (idx) in
                guard let `self` = self else {
                    return
                }
                if idx != self.currentIndex {
                    self.backgroundView.setContentOffset(CGPoint.init(x: UIScreen.width * CGFloat(idx), y: 0), animated: false)
                    self.currentIndex = idx
                }
            }).addDisposableTo(disposeBag)
            
            if let segmentView = segmentView {
                indexSubject.subscribeNext { (idx) in
                    if idx != segmentView.index {
                        segmentView.index = idx
                    }
                    }.addDisposableTo(disposeBag)
                segmentView.rx_observe(Int.self, "index").map { [weak self] (idx) -> Int in
                    return idx ?? self!.currentIndex
                    }.distinctUntilChanged().subscribeNext { [weak self] (idx) in
                        guard let `self` = self else {
                            return
                        }
                        self.indexSubject.onNext(idx)
                    }.addDisposableTo(disposeBag)
            }
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
        let cell: UICollectionViewCell = collectionView.dequeueStaticCell(indexPath)
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
