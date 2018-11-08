//
//  NoticeCustomCell.swift
//  kbucket
//
//  Created by 김미혜 on 2018. 8. 24..
//  Copyright © 2018년 kikiplus. All rights reserved.
//

import Foundation
import UIKit

class NoticeCustomCell : UITableViewCell {
    
    private let TAG : String = "NoticeCustomCell"
    @IBOutlet weak var lbNotice: UILabel!
    @IBOutlet weak var lbContents: UILabel!
    
    
    @IBOutlet weak var imgHeightConstraint: NSLayoutConstraint!
    
    var isExpanded:Bool = false
    {
        didSet
        {
            if !isExpanded {
                self.imgHeightConstraint.constant = 0.0
                
            } else {
                self.imgHeightConstraint.constant = 128.0
            }
        }
    }
    
}
