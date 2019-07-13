//
//  TableViewHelper.swift
//  SampleProject2
//
//  Created by orangemac05 on 13/07/19.
//  Copyright © 2019 Saurabh. All rights reserved.
//

import Foundation
import UIKit

class TableViewHelper {
    
    class func EmptyMessage(message:String, table:UITableView) {
        let rect = CGRect(x: 0, y: 0, width: table.frame.width-70, height: table.frame.height)
        let messageLabel = UILabel(frame: rect)
        messageLabel.text = message
        messageLabel.textColor = UIColor.black
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont.boldSystemFont(ofSize: 21)
        messageLabel.sizeToFit()
        
        table.backgroundView = messageLabel;
        table.separatorStyle = .none;
    }
}
