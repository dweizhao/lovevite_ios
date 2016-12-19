//
//  PicturesLibraryViewModel.swift
//  lovevite
//
//  Created by Eason Leo on 2016/11/10.
//  Copyright © 2016年 lovevite. All rights reserved.
//

import Foundation

class PicturesLibraryViewModel: PicturesViewModel {
    
    private var selectedIndex: Set<Int> = []
    
    private var unselectForAllSelectState: Set<Int> = []
    
    private var isAllSelect = false
    
}

extension PicturesLibraryViewModel {
    
    func isSelected(index: Int) -> Bool {
        if isAllSelect {
            return !unselectForAllSelectState.contains(index)
        }
        return selectedIndex.contains(index)
    }
    
    // if return true, delete button should hide.
    func select(index: Int) -> Bool {
        if isAllSelect {
            if isSelected(index) {
                unselectForAllSelectState.insert(index)
            } else {
                unselectForAllSelectState.remove(index)
            }
        } else {
            if isSelected(index) {
                selectedIndex.remove(index)
            } else {
                selectedIndex.insert(index)
            }
        }
        return unselectForAllSelectState.count + selectedIndex.count != 0 && unselectForAllSelectState.count != picturesCount()
    }
    
    func allSelect() {
        isAllSelect = true
        unselectForAllSelectState.removeAll()
    }
    
    func cancelAllSelect() {
        isAllSelect = false
        selectedIndex.removeAll()
        unselectForAllSelectState.removeAll()
    }
    
}
