//
//  PictureLibraryViewController.swift
//  lovevite
//
//  Created by Eason Leo on 2016/11/10.
//  Copyright © 2016年 lovevite. All rights reserved.
//

import Foundation

class PictureLibraryViewController: BaseViewController, UIGestureRecognizerDelegate {
    
    private lazy var navBar: CustomNavBar = {
        let bar = CustomNavBar.init(title: nil, viewController: self, rightView: nil)
        return bar
    }()
    
    private let picturesView: UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        layout.minimumLineSpacing = CGFloat.min
        layout.minimumInteritemSpacing = CGFloat.min
        layout.scrollDirection = .Vertical
        let length = (UIScreen.width - 2 * UIConst.defaultInset) / 4.0
        layout.itemSize = CGSize.init(width: length, height: length)
        layout.sectionInset = UIEdgeInsetsMake(8.0, 0, UIScreen.tabBarHeight, 0)
        let view = UICollectionView.init(frame: CGRect.init(x: UIConst.defaultInset, y: UIScreen.navigationBarHeight, width: UIScreen.width - 2 * UIConst.defaultInset, height: UIScreen.height - UIScreen.navigationBarHeight), collectionViewLayout: layout)
        return view
    }()
    
    private struct ReuseIdentifier {
        static let pictureCell = "libraryPictureCell"
        static let addPictureCell = "addPictureCell"
        static let pictureCellBaseTag = 29321
    }
    
    private var viewModel = PicturesLibraryViewModel()
    
    private lazy var deleteBtn: UIButton = {
        let btn = UIButton.custom("删除".es_ml())
        btn.frame = CGRectMake(UIConst.defaultInset, UIScreen.height, UIScreen.width - 2 * UIConst.defaultInset, 40)
        btn.tintColor = UIColor.whiteColor()
        btn.backgroundColor = UIColor.main
        btn.layer.cornerRadius = 5
        btn.setShadow()
        btn.rx_tap.subscribeNext({ [weak self] in
            self?.didDeletePictures()
            }).addDisposableTo(self.disposeBag)
        return btn
    }()
    
    private weak var mutilpSelectBtn: UIButton? {
        return navBar.rightView as? UIButton
    }
    
    private var isAddMutilpSelectButton = false
    
}

extension PictureLibraryViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func initialize() {
        view.backgroundColor = UIColor.customBlack
        
        navBar.title = title
        view.addSubview(navBar)
        
        picturesView.dataSource = self
        picturesView.delegate = self
        picturesView.backgroundColor = nil
        picturesView.alwaysBounceVertical = true
        picturesView.registerClass(LibraryPictureCell.self, forCellWithReuseIdentifier: ReuseIdentifier.pictureCell)
        picturesView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: ReuseIdentifier.addPictureCell)
        view.addSubview(picturesView)
        
        shouldShowNoteLabel()
        
        if isAddMutilpSelectButton {
            addMutilpSelectButton()
        }
    }
    
}

// MARK: private methods

extension PictureLibraryViewController {
    
    private func shouldShowNoteLabel() {
        let shouldShow: Bool = (NSUserDefaults.standardUserDefaults().objectForKey(Keys.picturesLibraryNoteLabelShouldShow) as? Bool) ?? true
        if shouldShow {
            let noteLabel = UILabel()
            noteLabel.backgroundColor = UIColor.customBlack
            noteLabel.textColor = UIColor.textGray
            noteLabel.font = UIFont.body
            noteLabel.text = "点击查看图片详情, 长按可以选择单张图片".es_ml()
            noteLabel.textAlignment = .Center
            noteLabel.userInteractionEnabled = true
            
            let tap = UITapGestureRecognizer.init()
            tap.rx_event.filter({ (gesture) -> Bool in
                return gesture.state == .Ended
            }).subscribeNext({ (_) in
                UIView.animateWithDuration(0.3, animations: { 
                    noteLabel.frame = CGRectMake(0, UIScreen.height, UIScreen.width, UIScreen.tabBarHeight)
                }, completion: { (_) in
                    noteLabel.removeFromSuperview()
                    NSUserDefaults.standardUserDefaults().setObject(false, forKey: Keys.picturesLibraryNoteLabelShouldShow)
                })
            }).addDisposableTo(disposeBag)
            noteLabel.addGestureRecognizer(tap)
            
            view.addSubview(noteLabel)
            noteLabel.snp_makeConstraints { (make) in
                make.left.right.bottom.equalTo(0)
                make.height.equalTo(UIScreen.tabBarHeight)
            }
        }
    }
    
}

// MARK: handle all select.

extension PictureLibraryViewController {
    
    func willAddMutilpSelectButton() {
        isAddMutilpSelectButton = true
    }
    
    private func addMutilpSelectButton() {
        let btn = UIButton.init(type: UIButtonType.System)
        btn.tintColor = UIColor.clearColor()
        btn.setImage(UIImage(named: "pictures_mutilp_select_n")?.imageWithRenderingMode(.AlwaysOriginal), forState: .Normal)
        btn.setImage(UIImage(named: "pictures_mutilp_select_s")?.imageWithRenderingMode(.AlwaysOriginal), forState: .Selected)
        btn.rx_tap.map({ () -> Bool in
            btn.selected = !btn.selected
            return btn.selected
        }).subscribeNext { [weak self] (selected) in
            if selected {
                self?.allSelect()
                self?.willDeletePictures()
            } else {
                self?.cancelAllSelect()
                self?.didDeletePictures()
            }
        }.addDisposableTo(disposeBag)
        self.navBar.addRightView(btn)
    }
    
    private func allSelect() {
        viewModel.allSelect()
        picturesView.reloadData()
    }
    
    private func cancelAllSelect() {
        viewModel.cancelAllSelect()
        picturesView.reloadData()
    }
    
    private func select(index: Int) {
        mutilpSelectBtn?.selected = false
        if viewModel.select(index) {
            willDeletePictures()
        } else {
            didDeletePictures()
        }
        let cell = picturesView.cellForItemAtIndexPath(NSIndexPath.init(forItem: index, inSection: 0)) as! LibraryPictureCell
        cell.changeSelectState(viewModel.isSelected(index))
    }
    
}

// MARK: handle delete.

extension PictureLibraryViewController {
    
    private func willDeletePictures() {
        if deleteBtn.superview != nil {
            return
        }
        view.addSubview(deleteBtn)
        UIView.animateWithDuration(0.3) { 
            self.deleteBtn.frame.origin.y = UIScreen.height - 45.0
        }
    }
    
    private func didDeletePictures() {
        UIView.animateWithDuration(0.3, animations: { 
            self.deleteBtn.frame.origin.y = UIScreen.height
            }) { (finished) in
                self.deleteBtn.removeFromSuperview()
        }
    }
    
}

extension PictureLibraryViewController: UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.picturesCount() + 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if indexPath.item == viewModel.picturesCount() {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(ReuseIdentifier.addPictureCell, forIndexPath: indexPath)
            if cell.contentView.subviews.count == 0 {
                let bg = UIImageView(image: UIImage(named: "pictures_add_btn"))
                cell.contentView.addSubview(bg)
                bg.snp_makeConstraints(closure: { (make) in
                    make.edges.equalTo(cell.contentView)
                        .offset(EdgeInsetsMake(2, left: 2, bottom: -2, right: -2))
                })
            }
            return cell
        }
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(ReuseIdentifier.pictureCell, forIndexPath: indexPath) as! LibraryPictureCell
        cell.responseSelectedState(viewModel.isSelected(indexPath.item))
        cell.tag = ReuseIdentifier.pictureCellBaseTag + indexPath.item
        cell.pictureView.yy_setImageWithURL(viewModel.pictureURL(indexPath.item), options: .SetImageWithFadeAnimation)
        cell.longPress.filter { [weak self] (tag) -> Bool in
            return !(self?.viewModel.isSelected(tag - ReuseIdentifier.pictureCellBaseTag) ?? true)
        }.subscribeNext { [weak self] (tag) in
            self?.select(tag - ReuseIdentifier.pictureCellBaseTag)
        }.addDisposableTo(cell.disposeBag)
        return cell
    }
    
}

extension PictureLibraryViewController: UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if indexPath.item == viewModel.picturesCount() {
            view.showMsgHUD("逻辑有点多, 暂时不做这里")
            return
        }
        if viewModel.isSelected(indexPath.item) {
            return select(indexPath.item)
        }
        let broswer = PicturesBroswerViewController.init(dataSource: viewModel.pictures, index: indexPath.item)
        navigationController?.pushViewController(broswer, animated: true)
        broswer.addEditToolsBar()
        broswer.addDescriptionView()
    }
    
}
