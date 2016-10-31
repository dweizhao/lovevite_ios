//
//  IntroduceViewController.swift
//  lovevite
//
//  Created by Eason Leo on 2016/10/31.
//  Copyright © 2016年 lovevite. All rights reserved.
//

import Foundation

class IntroduceViewController: BaseViewController {
    
    private let backgroundView = MultipleTabsView()
    
    private let introImageNames = ["1", "2", "3", "4"].map({
        return "intro_bg_" + $0
    })
    
    struct ReuseIdentifier {
        static let introduceImageCell = "introduceImageCell"
    }
    
}

extension IntroduceViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    override func initialize() {
        backgroundView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: ReuseIdentifier.introduceImageCell)
        backgroundView.dataSource = self
        view.addSubview(backgroundView)
        
        let pageC = UIPageControl()
        pageC.numberOfPages = introImageNames.count
        pageC.pageIndicatorTintColor = UIColor.lightGrayColor()
        pageC.currentPageIndicatorTintColor = UIColor.main
        
        view.addSubview(pageC)
        pageC.snp_makeConstraints { (make) in
            make.centerX.equalTo(0)
            make.bottom.equalTo(-Scale.height(100))
            make.width.equalTo(50)
            make.height.equalTo(10)
        }
        
        backgroundView.rx_contentOffset
            .map({
                return Int(round($0.x / UIScreen.width))
            })
            .distinctUntilChanged()
            .subscribeNext({
                pageC.currentPage = $0
            })
            .addDisposableTo(disposeBag)
        
        let signinBtn = UIButton.init(type: UIButtonType.System)
        signinBtn.setAttributedTitle(NSAttributedString.init(string: "注  册".es_ml(), attributes: [NSForegroundColorAttributeName:UIColor.main]), forState: .Normal)
        signinBtn.setBackgroundImage(UIImage.yy_imageWithColor(UIColor.bgGray), forState: .Normal)
        signinBtn.layer.cornerRadius = 4
        signinBtn.layer.masksToBounds = true
        signinBtn.alpha = ApplicationHandler.isFirstLaunch ? 0 : 1
        
        signinBtn.rx_tap
            .subscribeNext({
                self.responseSignin()
            })
            .addDisposableTo(disposeBag)
        
        view.addSubview(signinBtn)
        signinBtn.snp_makeConstraints { (make) in
            make.centerX.equalTo(view).multipliedBy(0.5).offset(10)
            make.centerY.equalTo(view.snp_bottom).offset(-Scale.height(50))
            make.width.equalTo(Scale.width(100))
            make.height.equalTo(Scale.height(40))
        }
        
        let loginBtn = UIButton.init(type: UIButtonType.System)
        loginBtn.setAttributedTitle(NSAttributedString.init(string: "登  录".es_ml(), attributes: [NSForegroundColorAttributeName:UIColor.whiteColor()]), forState: .Normal)
        loginBtn.setBackgroundImage(UIImage.yy_imageWithColor(UIColor.main), forState: .Normal)
        loginBtn.layer.cornerRadius = 4
        loginBtn.layer.masksToBounds = true
        loginBtn.alpha = ApplicationHandler.isFirstLaunch ? 0 : 1
        
        loginBtn.rx_tap
            .subscribeNext({
                self.responseLogin()
            })
            .addDisposableTo(disposeBag)
        
        view.addSubview(loginBtn)
        loginBtn.snp_makeConstraints { (make) in
            make.centerX.equalTo(view).multipliedBy(1.5).offset(-10)
            make.centerY.width.height.equalTo(signinBtn)
        }
        
        if ApplicationHandler.isFirstLaunch {
            pageC.rx_observe(Int.self, "currentPage")
                .filter({
                    return $0 == pageC.numberOfPages - 1
                })
                .take(1)
                .subscribeNext({ _ in
                    UIView.animateWithDuration(0.3, animations: {
                        signinBtn.alpha = 1
                        loginBtn.alpha = 1
                    })
                })
                .addDisposableTo(disposeBag)
        }
    }
    
}

extension IntroduceViewController {
    
    private func operatingAnimation() {
        
    }
    
    private func responseLogin() {
        operatingAnimation()
        let vc = LoginViewController()
        vc.setBackgroundBlur(UIScreen.capture(backgroundView, size: backgroundView.frame.size)?.commonBlur())
        navigationController?.pushViewController(vc, animated: false)
    }
    
    private func responseSignin() {
        operatingAnimation()
    }
    
}

extension IntroduceViewController: UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return introImageNames.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(ReuseIdentifier.introduceImageCell, forIndexPath: indexPath)
        cell.layer.contents = UIImage(named: introImageNames[indexPath.item])?.CGImage
        return cell
    }
    
}
