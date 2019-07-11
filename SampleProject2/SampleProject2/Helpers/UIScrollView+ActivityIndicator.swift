//
//  UIScrollView+ActivityIndicator.swift
//  SampleProject2
//
//  Created by Saurabh on 11/07/19.
//  Copyright © 2019 Saurabh. All rights reserved.
//

import Foundation
import UIKit

// MARK: UIScrollview Extension

public extension UIScrollView {
    
    private var refreshControlIsAnimatingTag: Int { return 999 }
    
    func addRefreshControll(actionTarget: Any?, action: Selector) {
        let _refreshControl = UIRefreshControl()
        _refreshControl.attributedTitle = NSAttributedString(string: Refresh_Title)
        _refreshControl.addTarget(actionTarget, action: action, for: .valueChanged)
        refreshControl = _refreshControl
    }
    
    func endRefreshing(deadline: DispatchTime? = nil) {
        refreshControl?.tag = 0
        guard let deadline = deadline else { refreshControl?.endRefreshing(); return }
        DispatchQueue.main.asyncAfter(deadline: deadline) { [weak self] in
            self?.refreshControl?.endRefreshing()
        }
    }
}
