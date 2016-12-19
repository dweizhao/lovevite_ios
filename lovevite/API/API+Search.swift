//
//  API+Search.swift
//  lovevite
//
//  Created by Eason Leo on 2016/11/24.
//  Copyright © 2016年 lovevite. All rights reserved.
//

import Foundation

extension API {
    
    enum SearchSortType: Int {
        case popular        = 4
        case stillOnline    = 1
        case recentJoin     = 6
    }
    
    static func searchResult(sort: SearchSortType, lastUserID: String?) -> RxSwift.Observable<SearchViewModel> {
        let config = RequestConfig<SearchViewModel>(URLPath: "/api/users/search")
        config.method = .Get
        if sort == .popular {
            config.codeEventIgnore = true
        }
        config.addParameter("sort", value: sort.rawValue)
        config.addParameter("start", value: 0)
        config.addParameter("last-id", value: lastUserID)
        return NetworkManager().rx_request(config)
    }
    
}
