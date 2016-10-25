//
//  MineViewController.swift
//  lovevite
//
//  Created by Eason Leo on 2016/9/26.
//  Copyright © 2016年 lovevite. All rights reserved.
//

import UIKit

class MineViewController: MultipleTabsViewController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nil, bundle: nil)
        NSNotificationCenter.defaultCenter()
            .rx_notification(NotificationNames.MineSubTableViewContentOffsetYChanged)
            .subscribeNext { [weak self] noti in
                if let offsetY = (noti.userInfo?["offsetY"] as? CGFloat) {
                    let y = offsetY > MineUserInterfaceContent.photosViewHeight ? MineUserInterfaceContent.photosViewHeight : offsetY
                    self?.photosView.frame.origin.y = -y
                }
            }
            .addDisposableTo(disposeBag)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let photosView: UICollectionView = {
        let fl = UICollectionViewFlowLayout.init()
        fl.minimumLineSpacing = CGFloat.min
        fl.minimumInteritemSpacing = CGFloat.min
        fl.scrollDirection = .Horizontal
        fl.itemSize = CGSize.init(width: UIScreen.width, height: UIScreen.width)
        let c = UICollectionView.init(frame: CGRectMake(0, 0, UIScreen.width, UIScreen.width), collectionViewLayout:fl)
        c.backgroundColor = UIColor.bgGray
        c.showsVerticalScrollIndicator = false
        c.showsHorizontalScrollIndicator = false
        c.pagingEnabled = true
        return c
    }()
    
    private let toPhotoLibraryBtn = UIButton.init(type: UIButtonType.System)
    
    override var subViewControllers: Array<BaseViewController> {
        return viewControllers
    }
    
    private let viewControllers = [PersonalInfoViewController(), DesiredRequireViewController()]
    
    struct ReuseIdentifier {
        
        static let photoCell = "photoCell"
        
    }
    
    private let viewModel = MineConfiguator()

}

extension MineViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeUserInterface()
        responseUIEvent()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        UIApplication.sharedApplication().setStatusBarHidden(true, withAnimation: .Fade)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
        UIApplication.sharedApplication().setStatusBarHidden(false, withAnimation: .None)
    }
    
    override func initializeUserInterface() {
        photosView.dataSource = self
        photosView.delegate = self
        photosView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: ReuseIdentifier.photoCell)
        view.addSubview(photosView)
        
        toPhotoLibraryBtn.frame = CGRectMake(Scale.width(40), UIScreen.width - Scale.height(80), 70, 30)
        toPhotoLibraryBtn.backgroundColor = UIColor.main
        toPhotoLibraryBtn.layer.cornerRadius = 4
        toPhotoLibraryBtn.setTitle("编辑照片".es_ml(), forState: .Normal)
        toPhotoLibraryBtn.tintColor = UIColor.whiteColor()
        photosView.addSubview(toPhotoLibraryBtn)
    }
    
    override func responseUIEvent() {
        toPhotoLibraryBtn.rx_tap
            .subscribeNext({
                print("编辑照片")
            })
            .addDisposableTo(disposeBag)
    }
    
}

extension MineViewController {
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        if collectionView == photosView {
            return 1
        }
        return super.numberOfSectionsInCollectionView(collectionView)
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == photosView {
            return viewModel.photosCount()
        }
        return super.collectionView(collectionView, numberOfItemsInSection: section)
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if collectionView == photosView {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(ReuseIdentifier.photoCell, forIndexPath: indexPath)
            cell.layer.yy_setImageWithURL(viewModel.photoImageURL(indexPath), options: .ShowNetworkActivity)
            return cell
        }
        return super.collectionView(collectionView, cellForItemAtIndexPath: indexPath)
    }
    
}

extension MineViewController {
    
    func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        
    }
    
}
