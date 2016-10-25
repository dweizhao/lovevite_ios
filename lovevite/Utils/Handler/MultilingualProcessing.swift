//
//  MultilingualProcessing.swift
//  lovevite
//
//  Created by Eason Leo on 2016/9/26.
//  Copyright © 2016年 lovevite. All rights reserved.
//

import Foundation

class MultilingualTool: NSObject {
    
    enum LanguageType {
        case english
        case simplifiedCN
        case traditionalCN
    }
    
    private static let onlyFile = MultilingualTool()
    
    private var languageBundle: NSBundle?
    
    private override init() {
        super.init()
        if languageBundle == nil {
            reselectLanguage(destionation: .english)
        }
    }
    
    private func getString(originalString str: String) -> String {
        if let currentBundle = languageBundle {
            return NSLocalizedString(str, tableName: nil, bundle: currentBundle, value: "", comment: "")
        } else {
            return NSLocalizedString(str, comment: "")
        }
    }
    
}

// MARK: public methods

extension MultilingualTool {
    
    func reselectLanguage(destionation type: LanguageType) {
        var path: String?
        switch type {
        case .english:
            path = NSBundle.mainBundle().pathForResource("en", ofType: ".lproj")
        case .simplifiedCN:
            path = NSBundle.mainBundle().pathForResource("zh-Hans", ofType: ".lproj")
        case .traditionalCN:
            path = NSBundle.mainBundle().pathForResource("zh-Hant", ofType: ".lproj")
        }
        languageBundle = NSBundle.init(path: path!)
    }
    
}

protocol Multilingual {
    
    func es_ml() -> String
    
}

extension String: Multilingual {
    
    func es_ml() -> String {
        return MultilingualTool.onlyFile.getString(originalString: self)
    }
    
}
