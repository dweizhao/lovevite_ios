//
//  PicturesBroswerViewController.swift
//  lovevite
//
//  Created by Eason Leo on 2016/11/11.
//  Copyright © 2016年 lovevite. All rights reserved.
//

import Foundation

class PicturesBroswerViewController: BaseViewController {
    
    init(dataSource: Array<PictureModel>, index: Int) {
        super.init(nibName: nil, bundle: nil)
        viewModel.index = index
        viewModel.pictures = dataSource
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let picturesShowView: UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        layout.minimumLineSpacing = CGFloat.min
        layout.minimumInteritemSpacing = CGFloat.min
        layout.itemSize = CGSize.init(width: UIScreen.width, height: UIScreen.height - UIScreen.navigationBarHeight)
        layout.scrollDirection = .Horizontal
        let v = UICollectionView.init(frame: CGRectMake(0, 0, UIScreen.width, UIScreen.height - UIScreen.navigationBarHeight), collectionViewLayout: layout)
        return v
    }()
    
    private let viewModel = PicturesBroswerViewModel()
    
    private struct Const {
        static let pictureShowCellReuseIdentifier = "pictureShowCell"
    }
    
    private let indexChangeSubject = PublishSubject<Int>()
    
}

extension PicturesBroswerViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func initialize() {
        view.backgroundColor = UIColor.customBlack
        
        title = viewModel.title()
        
        picturesShowView.dataSource = self
        picturesShowView.delegate = self
        picturesShowView.backgroundColor = nil
        picturesShowView.pagingEnabled = true
        picturesShowView.alwaysBounceHorizontal = true
        picturesShowView.registerClass(PicturesBroswerShowCell.self, forCellWithReuseIdentifier: Const.pictureShowCellReuseIdentifier)
        view.addSubview(picturesShowView)
        
        picturesShowView.setContentOffset(CGPoint.init(x: UIScreen.width * CGFloat(viewModel.index), y: 0), animated: false)
        
        picturesShowView.rx_contentOffset.map { (offset) -> Int in
            return Int(round(offset.x / UIScreen.width))
        }.distinctUntilChanged().subscribeNext { [weak self] index in
            self?.indexChangeSubject.onNext(index)
            self?.title = self?.viewModel.title(index)
        }.addDisposableTo(disposeBag)
    }
    
}

extension PicturesBroswerViewController: UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.picturesCount()
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(Const.pictureShowCellReuseIdentifier, forIndexPath: indexPath) as! PicturesBroswerShowCell
        cell.pictureView.yy_setImageWithURL(viewModel.pictureURL(indexPath.item), options: .SetImageWithFadeAnimation)
        return cell
    }
    
}

extension PicturesBroswerViewController: UICollectionViewDelegate {}

extension PicturesBroswerViewController {
    
    func addEditToolsBar() {
        let toolsBar = UIView.init(frame: CGRect.init(x: 0, y: picturesShowView.frame.height - UIScreen.tabBarHeight, width: UIScreen.width, height: UIScreen.tabBarHeight))
        toolsBar.backgroundColor = UIColor.main
        view.addSubview(toolsBar)
        
        let rotateBtn = UIButton.custom(UIImage(named: "pic_rotate_btn")?.imageWithRenderingMode(.AlwaysOriginal))
        toolsBar.addSubview(rotateBtn)
        rotateBtn.snp_makeConstraints { (make) in
            make.left.equalTo(0)
            make.width.equalTo(toolsBar).dividedBy(3)
            make.top.bottom.equalTo(0)
        }
        
        let cutBtn = UIButton.custom(UIImage(named: "pic_cut_btn")?.imageWithRenderingMode(.AlwaysOriginal))
        toolsBar.addSubview(cutBtn)
        cutBtn.snp_makeConstraints { (make) in
            make.left.equalTo(rotateBtn.snp_right)
            make.top.bottom.width.equalTo(rotateBtn)
        }
        
        let deleteBtn = UIButton.custom(UIImage(named: "pic_delete_btn")?.imageWithRenderingMode(.AlwaysOriginal))
        toolsBar.addSubview(deleteBtn)
        deleteBtn.snp_makeConstraints { (make) in
            make.left.equalTo(cutBtn.snp_right)
            make.top.bottom.width.equalTo(cutBtn)
        }
        
        rotateBtn.rx_tap.subscribeNext { [weak self] in
            self?.responseRotateTaped()
        }.addDisposableTo(disposeBag)
        
        cutBtn.rx_tap.subscribeNext { [weak self] in
            self?.responseCutAvatarTaped()
        }.addDisposableTo(disposeBag)
        
        deleteBtn.rx_tap.subscribeNext { [weak self] in
            self?.responseDeleteTaped()
        }.addDisposableTo(disposeBag)
    }
    
    private var creatMainPhotoBarButtonItemTag: Int {
        return 19283
    }
    
    func addCreatMainPhotoBarButtonItem() {
        let btn = UIButton.custom("设为主照片".es_ml())
        btn.frame = CGRectMake(0, 0, 58.0, 24.0)
        btn.tintColor = UIColor.whiteColor()
        let item = UIBarButtonItem.init(customView: btn)
        item.tag = creatMainPhotoBarButtonItemTag
        navigationItem.setRightBarButtonItem(item, animated: true)
    }
    
    private func creatMainPhotoBarButtonItem(hidden: Bool) {
        guard let items = navigationItem.rightBarButtonItems else {
            return
        }
        for item in items {
            if item.tag == creatMainPhotoBarButtonItemTag {
                item.customView?.hidden = hidden
                return
            }
        }
    }
    
    private func responseRotateTaped() {
        guard let cell = picturesShowView.visibleCells().first as? PicturesBroswerShowCell else {
            return
        }
        UIView.animateWithDuration(0.25) { 
            cell.pictureView.transform = CGAffineTransformRotate(cell.pictureView.transform, CGFloat(M_PI_2))
        }
    }
    
    private func responseCutAvatarTaped() {
        willCutAvatar()
        
        let bar = UIView.init(frame: CGRect.init(x: 0, y: picturesShowView.frame.height - UIScreen.tabBarHeight, width: UIScreen.width, height: UIScreen.tabBarHeight))
        bar.backgroundColor = UIColor.main
        self.view.addSubview(bar)
        
        let cancel = UIButton.custom("取消".es_ml())
        cancel.tintColor = UIColor.bgDarkGray
        bar.addSubview(cancel)
        cancel.snp_makeConstraints { (make) in
            make.left.top.bottom.equalTo(0)
            make.width.equalTo(bar).dividedBy(3)
        }
        
        let setAvatar = UIButton.custom("剪辑为头像".es_ml())
        setAvatar.tintColor = UIColor.whiteColor()
        bar.addSubview(setAvatar)
        setAvatar.snp_makeConstraints { (make) in
            make.right.top.bottom.equalTo(0)
            make.width.equalTo(bar).multipliedBy(2.0 / 3.0)
        }
        
        guard let cell = picturesShowView.visibleCells().first as? PicturesBroswerShowCell else {
            return
        }
        let cutView = PictureCutView.init(frame: CGRectZero)
        
        cell.pictureView.addSubview(cutView)
        
        cancel.rx_tap.subscribeNext { [weak self] in
            bar.removeFromSuperview()
            cutView.removeFromSuperview()
            self?.didCutAvatar()
        }.addDisposableTo(disposeBag)
        
        setAvatar.rx_tap.subscribeNext { [weak self] in
            bar.removeFromSuperview()
            cutView.removeFromSuperview()
            self?.didCutAvatar()
            self?.cutAvatar(cutView.selectRect)
        }.addDisposableTo(disposeBag)
        
    }
    
    private func willCutAvatar() {
        title = "剪辑头像".es_ml()
        picturesShowView.scrollEnabled = false
        creatMainPhotoBarButtonItem(true)
    }
    
    private func cutAvatar(rect: CGRect) {
        let newRect = CGRectMake(rect.origin.x - 2.0, rect.origin.y - 2.0, rect.width + 4.0, rect.height + 4.0)
        view.showMsgHUD("截取\(newRect)区域为头像")
    }
    
    private func didCutAvatar() {
        title = viewModel.title()
        picturesShowView.scrollEnabled = true
        creatMainPhotoBarButtonItem(false)
    }
    
    private func responseDeleteTaped() {
        view.showMsgHUD("删除")
    }
    
}

extension PicturesBroswerViewController {
    
    func addDescriptionView() {
        let textView = PictureDescriptionView.init(frame: CGRectZero)
        textView.descriptionText = viewModel.pictureDesciption()
        textView.dateText = viewModel.pictureUploadDate()
        view.addSubview(textView)
        textView.snp_makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.bottom.equalTo(-UIScreen.tabBarHeight - 2.0)
            make.height.greaterThanOrEqualTo(20.0)
        }
        indexChangeSubject.subscribeNext { [weak self] index in
            textView.descriptionText = self?.viewModel.pictureDesciption(index)
            textView.dateText = self?.viewModel.pictureUploadDate(index)
            }.addDisposableTo(disposeBag)
    }
    
}
