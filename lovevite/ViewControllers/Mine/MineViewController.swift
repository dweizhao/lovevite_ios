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
        NSNotificationCenter.defaultCenter().rx_notification(NotificationNames.MineSubTableViewContentOffsetYChanged)
            .subscribeNext { [weak self] noti in
                if let offsetY = (noti.userInfo?["offsetY"] as? CGFloat) {
                    let y = offsetY > MineUserInterfaceContent.photosViewHeight ? MineUserInterfaceContent.photosViewHeight : offsetY
                    self?.headerView.frame.origin.y = -y
                }
            }.addDisposableTo(disposeBag)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let headerView: UIView = UIView.init(frame: CGRectMake(0, 0, UIScreen.width, UIScreen.width))
    
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
    
    private lazy var libraryViewController: PictureLibraryViewController = {
        let vc = PictureLibraryViewController()
        vc.title = "相册"
        vc.willAddMutilpSelectButton()
        return vc
    }()
    
    private let tabNamesView = ESSegmentControl.init(titles: ["个人资料".es_ml(), "择偶要求".es_ml(), "关于我".es_ml(), "真心话".es_ml()])
    
    private let viewControllers = [PersonalInfoViewController(), DesiredRequireViewController(), SomeQuestionForMeViewController(), TrueWordsViewController()]
    
    struct ReuseIdentifier {
        static let photoCell = "photoCell"
    }
    
    private let viewModel = MineConfiguator()
    
    override var segmentView: ESSegmentControl? {
        return tabNamesView
    }
    
    override var subViewControllers: Array<BaseViewController> {
        return viewControllers
    }

}

extension MineViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        UIApplication.sharedApplication().setStatusBarHidden(true, withAnimation: .Fade)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.sharedApplication().setStatusBarHidden(false, withAnimation: .None)
    }
    
    override func initialize() {
        super.initialize()
        title = "主页".es_ml()
        
        view.addSubview(headerView)
        
        photosView.dataSource = self
        photosView.delegate = self
        photosView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: ReuseIdentifier.photoCell)
        headerView.addSubview(photosView)
        
        let toPhotoLibraryBtn = UIButton.custom("编辑照片".es_ml())
        toPhotoLibraryBtn.frame = CGRectMake(Scale.width(40), UIScreen.width - Scale.height(80), 70, 30)
        toPhotoLibraryBtn.backgroundColor = UIColor.main
        toPhotoLibraryBtn.layer.cornerRadius = 4
        toPhotoLibraryBtn.tintColor = UIColor.whiteColor()
        headerView.addSubview(toPhotoLibraryBtn)
        
        tabNamesView.frame = CGRectMake(0, UIScreen.width - 35, UIScreen.width, 35)
        tabNamesView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.4)
        headerView.addSubview(tabNamesView)
        
        // MARK: to photo library button response.
        
        toPhotoLibraryBtn.rx_tap.subscribeNext({ [weak self] in
            guard let `self` = self else {
                return
            }
            self.navigationController?.pushViewController(self.libraryViewController, animated: true)
            }).addDisposableTo(disposeBag)
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

