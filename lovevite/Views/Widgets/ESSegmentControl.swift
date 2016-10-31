//
//  ESSegmentView.swift
//  lovevite
//
//  Created by Eason Leo on 2016/10/26.
//  Copyright © 2016年 lovevite. All rights reserved.
//

import Foundation

class ESSegmentControl: UIView {
    
    var segmentBackgroundColor: UIColor! = UIColor.clearColor()
    
    var currentSegmentBackgroundColor: UIColor! = UIColor.clearColor()
    
    var segmentTintColor: UIColor! = UIColor.whiteColor()
    
    var currentSegmentTintColor: UIColor! = UIColor.main
    
    var titles: Array<String> = [] {
        willSet {
            configButtons(newValue)
        }
    }
    
    private let segmentBaseTag = 82932
    
    convenience init(titles: Array<String>) {
        self.init(frame: CGRectZero)
        self.titles = titles
        configButtons(titles)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var buttons: Array<UIButton> = []
    
    private lazy var indexLayer: CAShapeLayer = {
        let l = CAShapeLayer.init()
        let h = self.bounds.height
        let w = self.bounds.width
        l.strokeColor = self.currentSegmentTintColor.CGColor
        l.lineWidth = 3
        let line = UIBezierPath.init()
        line.moveToPoint(CGPointMake(0, h - 1.5))
        line.addLineToPoint(CGPointMake(w, h - 1.5))
        l.path = line.CGPath
        return l
    }()
    
    private var currentIndex = 0
    
    private let disposeBag = DisposeBag()
    
}

extension ESSegmentControl {
    
    override func updateConstraintsIfNeeded() {
        super.updateConstraintsIfNeeded()
        var placeholder: UIButton? = nil
        for btn in buttons {
            btn.snp_makeConstraints(closure: { (make) in
                make.top.bottom.equalTo(self)
                if placeholder != nil {
                    make.left.equalTo(placeholder!.snp_right)
                    make.width.equalTo(placeholder!)
                } else {
                    make.left.equalTo(0)
                    make.width.equalTo(self).dividedBy(titles.count)
                }
                placeholder = btn
            })
        }
    }
    
    private func configButtons(titles: Array<String>) {
        subviews.forEach{ $0.removeFromSuperview() }
        for (index, title) in titles.enumerate() {
            let btn = UIButton.custom(title)
            btn.tag = segmentBaseTag + index
            btn.tintColor = UIColor.clearColor()
            btn.backgroundColor = segmentBackgroundColor
            btn.setTitleColor(segmentTintColor, forState: .Normal)
            btn.setTitleColor(currentSegmentTintColor, forState: .Selected)
            btn.setBackgroundImage(UIImage.yy_imageWithColor(currentSegmentBackgroundColor), forState: .Selected)
            btn.rx_tap
                .filter({
                    return !btn.selected
                })
                .subscribeNext({ [weak self] in
                    self?.index = index
                })
                .addDisposableTo(disposeBag)
            buttons.append(btn)
            addSubview(btn)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if indexLayer.superlayer == nil {
            layer.addSublayer(indexLayer)
        }
    }
    
}

extension ESSegmentControl {
    
    var index: Int {
        set {
            let old = buttons[index]
            old.selected = false
            old.userInteractionEnabled = true
            indexLayerAnimation(index, newIndex: newValue)
            currentIndex = newValue
            let new = buttons[index]
            new.selected = true
            new.userInteractionEnabled = false
        }
        get {
            return currentIndex
        }
    }
    
    private func indexLayerAnimation(oldIndex: Int, newIndex: Int) {
        if oldIndex == newIndex {
            return
        }
        if oldIndex > newIndex {
            strokeToForwardsAnimation(newIndex)
        } else {
            strokeToBackwardsAnimation(newIndex)
        }
    }
    
    private func strokeToForwardsAnimation(newIndex: Int) {
        let start = ESAnimation.init(keyPath: "strokeStart", duration: 0.2, fromValue: indexLayer.strokeStart) { (finished) in
            if finished {
                let end = ESAnimation.init(keyPath: "strokeEnd", duration: 0.2, fromValue: self.indexLayer.strokeEnd, completion: nil)
                self.indexLayer.strokeEnd = CGFloat(newIndex + 1) / CGFloat(self.titles.count)
                self.indexLayer.addAnimation(end.animation, forKey: nil)
            }
        }
        indexLayer.strokeStart = CGFloat(newIndex) / CGFloat(titles.count)
        indexLayer.addAnimation(start.animation, forKey: nil)
    }
    
    private func strokeToBackwardsAnimation(newIndex: Int) {
        let end = ESAnimation.init(keyPath: "strokeEnd", duration: 0.2, fromValue: indexLayer.strokeEnd) { (finished) in
            if finished {
                let start = ESAnimation.init(keyPath: "strokeStart", duration: 0.2, fromValue: self.indexLayer.strokeStart, completion: nil)
                self.indexLayer.strokeStart = CGFloat(newIndex) / CGFloat(self.titles.count)
                self.indexLayer.addAnimation(start.animation, forKey: nil)
            }
        }
        indexLayer.strokeEnd = CGFloat(newIndex + 1) / CGFloat(titles.count)
        indexLayer.addAnimation(end.animation, forKey: nil)
    }
    
}
