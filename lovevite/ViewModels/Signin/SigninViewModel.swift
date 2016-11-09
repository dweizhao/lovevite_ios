//
//  SigninViewModel.swift
//  lovevite
//
//  Created by Eason Leo on 2016/10/31.
//  Copyright © 2016年 lovevite. All rights reserved.
//

import UIKit

class SigninViewModel: Response {
    
    static let username: UITextField = {
        let field = UITextField()
        field.setLikeUserNameStyle("仅用作账号认证和登录".es_ml())
        return field
    }()
    
    static let nickname: UITextField = {
        let field = UITextField()
        field.setLikeUserNameStyle("")
        field.keyboardType = .Default
        return field
    }()
    
    static let password: UITextField = {
        let field = UITextField()
        field.setLikePasswordStyle("")
        return field
    }()
    
    static let resurePassword: UITextField = {
        let field = UITextField()
        field.setLikePasswordStyle("请确认密码".es_ml())
        return field
    }()
    
    private static var commonLabel: UILabel {
        let label = UILabel()
        label.textColor = UIColor.textGray
        label.font = UIFont.defaultWithSize(12)
        label.textAlignment = .Right
        label.text = "点击选择".es_ml()
        return label
    }
    
    static let gender: UILabel = {
        return commonLabel
    }()
    
    static let birthday: UILabel = {
        return commonLabel
    }()
    
    static let country: UILabel = {
        return commonLabel
    }()
    
}

extension SigninViewModel {
    
    func title() -> String {
        return SigninUIContent.viewControllerTitle.es_ml()
    }
    
    func cellsCount(section: Int) -> Int {
        switch section {
        case 0:
            return SigninUIContent.baseInfoTitles.count
        case 1:
            return SigninUIContent.detailInfoTitles.count
        default:
            return 0
        }
    }
    
    func cellTitle(indexPath: NSIndexPath) -> String? {
        switch indexPath.section {
        case 0:
            return SigninUIContent.baseInfoTitles[indexPath.item].es_ml()
        case 1:
            return SigninUIContent.detailInfoTitles[indexPath.item].es_ml()
        default:
            return nil
        }
    }
    
    func baseInfoTextField(indexPath: NSIndexPath) -> UITextField {
        switch indexPath.row {
        case 0:
            return SigninViewModel.username
        case 1:
            return SigninViewModel.nickname
        case 2:
            return SigninViewModel.password
        case 3:
            return SigninViewModel.resurePassword
        default:
            return UITextField()
        }
    }
    
    func detailsInfoRightView(indexPath: NSIndexPath) -> UIView {
        switch indexPath.row {
        case 0:
            return SigninViewModel.gender
        case 1:
            return SigninViewModel.birthday
        case 2:
            return SigninViewModel.country
        default:
            return UILabel()
        }
    }
    
}
