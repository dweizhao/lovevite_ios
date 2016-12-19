//
//  SearchViewModel.swift
//  lovevite
//
//  Created by Eason Leo on 2016/11/24.
//  Copyright © 2016年 lovevite. All rights reserved.
//

import ObjectMapper

class SearchViewModel: Response {
    
    private var users: Array<OtherUserModel> = []
    
    private var hasMore: String?
    
    override func mapping(map: Map) {
        super.mapping(map)
        hasMore <- map["hasMore"]
        users   <- map["users"]
    }
    
}

extension SearchViewModel: ShowOtherUsersListTableViewModel {
    
    func cellsCount(section: Int) -> Int {
        return users.count
    }
    
    func userAvatarURL(idx: Int) -> NSURL? {
        return NSURL.init(string: NetworkManager.completeImageURL(users[idx].photomp ?? ""))
    }
    
    func userBaseInfoString(idx: Int) -> String {
        return (users[idx].name ?? " ") + ", " + (users[idx].age ?? " ")
    }
    
    func userLocationString(idx: Int) -> String {
        return users[idx].location ?? " "
    }
    
    func userIntroduce(idx: Int) -> String? {
        return users[idx].introduction
    }
    
}
