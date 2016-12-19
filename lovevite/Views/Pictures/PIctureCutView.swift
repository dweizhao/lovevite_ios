//
//  PIctureCutView.swift
//  lovevite
//
//  Created by Eason Leo on 2016/11/14.
//  Copyright © 2016年 lovevite. All rights reserved.
//

import Foundation

class PictureCutView: UIView {
    
    private let selectView = UIView()
    
    private let maskLayer = CAShapeLayer()
    
    private let disposeBag = DisposeBag()
    
    private let translationInteractiveInset: CGFloat = 20.0
    
    private var minSelectBounds: CGRect {
        return CGRectMake(translationInteractiveInset, translationInteractiveInset, selectRect.width - translationInteractiveInset * 2.0, selectRect.height - translationInteractiveInset * 2.0)
    }
    
    var selectRect: CGRect = CGRectMake((UIScreen.width - 160.0) / 2.0, (UIScreen.width - 160.0) / 2.0, 160.0, 160.0) {
        willSet {
            updateSelectRect(newValue)
        }
    }
    
    private var selectCenter: CGPoint = CGPointZero {
        willSet {
            let newRect = CGRectMake(newValue.x - selectRect.width / 2.0, newValue.y - selectRect.height / 2.0, selectRect.width, selectRect.height)
            selectRect = newRect
        }
    }
    
    private struct Record {
        static var startOrigin: CGPoint = CGPointZero
        static var startCenter: CGPoint = CGPointZero
        static var startSize: CGSize = CGSizeZero
        static var isTranslation: Bool = true
        static var startLocation: CGPoint = CGPointZero
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: CGRectMake(0, 0, UIScreen.width, UIScreen.width))
        backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.4)

        selectView.layer.contents = UIImage(named: "pic_cut_dash_border")?.CGImage
        addSubview(selectView)
        
        maskLayer.fillColor = UIColor.blackColor().CGColor
        maskLayer.fillRule = kCAFillRuleEvenOdd
        
        updateSelectRect(selectRect)
        
        layer.mask = maskLayer
        
        let pan = UIPanGestureRecognizer.init(target: self, action: #selector(responsePan(_:)))
        selectView.addGestureRecognizer(pan)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PictureCutView {
    
    @objc private func responsePan(gesture: UIPanGestureRecognizer) {
        if gesture.state == .Began {
            Record.startOrigin = self.selectRect.origin
            Record.startCenter = self.selectView.center
            Record.startSize = self.selectRect.size
            let location = gesture.locationInView(gesture.view)
            Record.isTranslation = CGRectContainsPoint(self.minSelectBounds, location)
            Record.startLocation = gesture.locationInView(self)
        } else if gesture.state == .Changed {
            let locating = gesture.locationInView(self)
            if Record.isTranslation {
                self.selectCenter = CGPoint.init(x: Record.startCenter.x + locating.x - Record.startLocation.x, y: Record.startCenter.y + locating.y - Record.startLocation.y)
            } else {
                let sx = (locating.x - Record.startLocation.x) / UIScreen.width + 1
                let sy = (locating.y - Record.startLocation.y) / UIScreen.width + 1
                let maxScale = max(sx, sy)
                var length = maxScale * Record.startSize.width
                if length > UIScreen.width - 4 {
                    length = UIScreen.width - 4
                } else if length < 160.0 {
                    length = 160.0
                }
                self.selectRect = CGRectMake(Record.startOrigin.x, Record.startOrigin.y, length, length)
            }
        }
        var newRect = selectRect
        if selectRect.origin.y < 2 {
            newRect.origin.y = 2
        } else if CGRectGetMaxY(selectRect) > UIScreen.width - 2 {
            newRect.origin.y = UIScreen.width - 2 - selectRect.height
        } else if selectRect.origin.x < 2 {
            newRect.origin.x = 2
        } else if CGRectGetMaxX(selectRect) > UIScreen.width - 2 {
            newRect.origin.x = UIScreen.width - 2 - selectRect.width
        } else {
            return
        }
        self.selectRect = newRect
    }
    
    private func updateSelectRect(rect: CGRect) {
        selectView.frame = CGRectMake(rect.origin.x - 2.0, rect.origin.y - 2.0, rect.width + 4.0, rect.height + 4.0)
        let maskPath = CGPathCreateMutable()
        CGPathAddRect(maskPath, nil, CGRectMake(0, 0, UIScreen.width, UIScreen.width))
        CGPathAddRect(maskPath, nil, rect)
        maskLayer.path = maskPath
    }
    
}
