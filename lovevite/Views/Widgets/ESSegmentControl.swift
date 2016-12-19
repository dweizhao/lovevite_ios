//
//  ESSegmentView.swift
//  lovevite
//
//  Created by Eason Leo on 2016/10/26.
//  Copyright © 2016年 lovevite. All rights reserved.
//

import Foundation

class ESSegmentControl: UIView {
    
    convenience init(titles: Array<String>) {
        self.init(frame: CGRectZero)
        self.titles = titles
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
    
    private let segmentBaseTag = 82932
    
    private let disposeBag = DisposeBag()
    
    var segmentBackgroundColor: UIColor! = UIColor.clearColor()
    
    var currentSegmentBackgroundColor: UIColor! = UIColor.clearColor()
    
    var segmentTintColor: UIColor! = UIColor.whiteColor()
    
    var currentSegmentTintColor: UIColor! = UIColor.main
    
    var titles: Array<String>?
    
    private lazy var bottomMargin: CAShapeLayer = {
        let layer = CAShapeLayer()
        let line = UIBezierPath()
        line.moveToPoint(CGPoint.init(x: 0, y: self.bounds.height))
        line.addLineToPoint(CGPoint.init(x: UIScreen.width, y: self.bounds.height))
        layer.path = line.CGPath
        layer.strokeColor = UIColor.customGray.CGColor
        layer.lineWidth = 1
        return layer
    }()
    
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
                    make.width.equalTo(self).dividedBy(titles!.count)
                }
                placeholder = btn
            })
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if indexLayer.superlayer == nil {
            configButtons()
            updateConstraintsIfNeeded()
            index = 0
            strokeToForwardsAnimation(index)
            layer.addSublayer(bottomMargin)
            layer.addSublayer(indexLayer)
        }
    }
    
}

extension ESSegmentControl {
    
    func configButtons() {
        subviews.forEach{ $0.removeFromSuperview() }
        guard let titles = titles else {
            return
        }
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
                self.indexLayer.strokeEnd = CGFloat(newIndex + 1) / CGFloat(self.buttons.count)
                self.indexLayer.addAnimation(end.animation, forKey: nil)
            }
        }
        indexLayer.strokeStart = CGFloat(newIndex) / CGFloat(buttons.count)
        indexLayer.addAnimation(start.animation, forKey: nil)
    }
    
    private func strokeToBackwardsAnimation(newIndex: Int) {
        let end = ESAnimation.init(keyPath: "strokeEnd", duration: 0.2, fromValue: indexLayer.strokeEnd) { (finished) in
            if finished {
                let start = ESAnimation.init(keyPath: "strokeStart", duration: 0.2, fromValue: self.indexLayer.strokeStart, completion: nil)
                self.indexLayer.strokeStart = CGFloat(newIndex) / CGFloat(self.buttons.count)
                self.indexLayer.addAnimation(start.animation, forKey: nil)
            }
        }
        indexLayer.strokeEnd = CGFloat(newIndex + 1) / CGFloat(buttons.count)
        indexLayer.addAnimation(end.animation, forKey: nil)
    }
    
}
