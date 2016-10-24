//
//  UITableView+extension.swift
//  lovevite
//
//  Created by Eason Leo on 2016/9/27.
//  Copyright © 2016年 lovevite. All rights reserved.
//

import UIKit

extension UITableView {
    
    func addTableHeaderView(height: CGFloat = CGFloat.min) {
        self.tableHeaderView = UIView.init(frame: CGRectMake(0, 0, 0, height))
    }
    
    func addTableFooterView(height: CGFloat = CGFloat.min) {
        self.tableFooterView = UIView.init(frame: CGRectMake(0, 0, 0, height))
    }
    
    func dequeueStaticCell<T: UITableViewCell>(indexPath: NSIndexPath) -> T {
        let reuseIdentifier = "\(T.description()) - \(indexPath.description)"
        if let cell = self.dequeueReusableCellWithIdentifier(reuseIdentifier) as? T {
            return cell
        }else {
            let cell = T(style: .Default, reuseIdentifier: reuseIdentifier)
            return cell
        }
    }
    
    func dequeueStaticHeaderFooterView<T: UITableViewHeaderFooterView>(section: Int, isHeader: Bool) -> T {
        let reuseIdentifier = "\(T.description()) - \(isHeader ? "Header" : "Footer") - section:\(section)"
        if let header = self.dequeueReusableHeaderFooterViewWithIdentifier(reuseIdentifier) as? T {
            return header
        } else {
            let header = T(reuseIdentifier: reuseIdentifier)
            return header
        }
    }
    
    func dequeueStaticHeaderView<T: UITableViewHeaderFooterView>(section: Int) -> T {
        let header: T = dequeueStaticHeaderFooterView(section, isHeader: true)
        return header
    }
    
    func dequeueStaticFooterView<T: UITableViewHeaderFooterView>(section: Int) -> T {
        let footer: T = dequeueStaticHeaderFooterView(section, isHeader: false)
        return footer
    }
    
}
