//
//  AbideProtocolView.swift
//  lovevite
//
//  Created by Eason Leo on 2016/10/31.
//  Copyright © 2016年 lovevite. All rights reserved.
//

import UIKit

class AbideProtocolView: UIView {
    
    dynamic var isAbide: Bool = true


    private let abideBtn: UIButton = {
        let btn = UIButton.init(type: UIButtonType.System)
        btn.layer.cornerRadius = 2
        btn.layer.masksToBounds = true
        btn.layer.borderWidth = UIScreen.onePix
        btn.layer.borderColor = UIColor.text.CGColor
        btn.setImage(UIImage(named: "choose")?.imageWithRenderingMode(.AlwaysOriginal), forState: .Selected)
        btn.tintColor = UIColor.clearColor()
        btn.selected = true
        return btn
    }()
    
    private let disposeBag = DisposeBag()
    
    var tapProtocol1: AnyObserver<Void>?
    
    var tapProtocol2: AnyObserver<Void>?
    
}

extension AbideProtocolView {
    
    convenience init(note: String, protocol1Name: String, protocol2Name: String? = nil) {
        self.init(frame: CGRectZero)
        
        addSubview(abideBtn)
        abideBtn.snp_makeConstraints { (make) in
            make.left.centerY.equalTo(0)
            make.width.height.equalTo(20)
        }
        
        let noteLabel: UILabel = {
            let label = UILabel.init()
            label.textColor = UIColor.textGray
            label.font = UIFont.body
            label.textAlignment = .Left
            label.userInteractionEnabled = true
            label.text = note
            return label
        }()
        
        addSubview(noteLabel)
        noteLabel.snp_makeConstraints { (make) in
            make.left.equalTo(abideBtn.snp_right).offset(4)
            make.centerY.equalTo(0)
        }
        
        let protocol1Btn: UIButton = {
            let btn = UIButton.init(type: UIButtonType.System)
            btn.tintColor = UIColor.main
            btn.setTitle(protocol1Name, forState: .Normal)
            return btn
        }()
        
        addSubview(protocol1Btn)
        protocol1Btn.snp_makeConstraints { (make) in
            make.left.equalTo(noteLabel.snp_right).offset(2)
            make.top.bottom.equalTo(0)
            make.right.lessThanOrEqualTo(0)
        }
        
        abideBtn.rx_tap.subscribeNext { [weak self] _ in
            self?.abideBtn.selected =
                !(self?.abideBtn.selected ?? false)
            self?.isAbide = self?.abideBtn.selected ?? true
            }.addDisposableTo(disposeBag)
        
        let tap = UITapGestureRecognizer()
        tap.rx_event.filter { (gesture) -> Bool in
            return gesture.state == .Ended
        }.subscribeNext { [weak self] _ in
            self?.abideBtn.selected =
                !(self?.abideBtn.selected ?? false)
            self?.isAbide = self?.abideBtn.selected ?? true
        }.addDisposableTo(disposeBag)
        noteLabel.addGestureRecognizer(tap)
        
        protocol1Btn.rx_tap.subscribeNext { [weak self] _ in
            self?.tapProtocol1?.onNext()
        }.addDisposableTo(disposeBag)
        
        if let name = protocol2Name {
            let label = UILabel.init()
            label.textColor = UIColor.textGray
            label.font = UIFont.body
            label.textAlignment = .Left
            label.text = "和".es_ml()
            
            addSubview(label)
            label.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(protocol1Btn.snp_right).offset(2)
                make.centerY.equalTo(noteLabel)
            })
            
            let protocol2Btn: UIButton = {
                let btn = UIButton.init(type: UIButtonType.System)
                btn.tintColor = UIColor.main
                btn.setTitle(name, forState: .Normal)
                return btn
            }()
            
            addSubview(protocol2Btn)
            protocol2Btn.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(label.snp_right).offset(2)
                make.top.bottom.equalTo(0)
                make.right.equalTo(0)
            })
            
        }
    }
    
}
