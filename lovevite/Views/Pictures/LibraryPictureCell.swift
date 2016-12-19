//
//  LibraryPictureCell.swift
//  lovevite
//
//  Created by Eason Leo on 2016/11/10.
//  Copyright © 2016年 lovevite. All rights reserved.
//

import Foundation

class LibraryPictureCell: UICollectionViewCell {
    
    let disposeBag = DisposeBag()
    
    let longPress = PublishSubject<Int>()
    
    let pictureView = UIImageView()
    
    private let selectedMarkView: UIView = {
        let view = UIView()
        view.hidden = true
        view.userInteractionEnabled = true
        view.backgroundColor = UIColor.main(0.3)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor.customBlack
        
        let frame = CGRect.init(x: 1.0, y: 2.0, width: contentView.bounds.width - 2.0, height: contentView.bounds.height - 4.0)
        
        pictureView.frame = frame
        contentView.addSubview(pictureView)
        
        selectedMarkView.frame = frame
        contentView.addSubview(selectedMarkView)
        
        let long = UILongPressGestureRecognizer()
        long.rx_event.filter { (gesture) -> Bool in
            return gesture.state == .Ended
            }.subscribeNext { [weak self] (_) in
                guard let `self` = self else {
                    return
                }
                self.longPress.onNext(self.tag)
            }.addDisposableTo(disposeBag)
        contentView.addGestureRecognizer(long)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension LibraryPictureCell {
    
    func responseSelectedState(isSelected: Bool) {
        if isSelected {
            selectedMarkView.hidden = false
        } else {
            selectedMarkView.hidden = true
        }
    }
    
    func changeSelectState(isSelected: Bool) {
        if isSelected {
            self.selectedMarkView.hidden = false
        } else {
            UIView.animateWithDuration(0.25, animations: {
                self.selectedMarkView.alpha = 0
                }, completion: { (finished) in
                    if finished {
                        self.selectedMarkView.hidden = true
                        self.selectedMarkView.alpha = 1
                    }
            })
        }
    }
    
}
