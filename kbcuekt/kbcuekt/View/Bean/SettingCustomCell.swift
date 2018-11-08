//
//  SettingCustomCell.swift
//  kbucket
//
//  Created by 김미혜 on 2018. 9. 14..
//  Copyright © 2018년 kikiplus. All rights reserved.
//

import Foundation
import UIKit

class SettingCustomCell : UITableViewCell {
    
    private let TAG : String = "SettingCustomCell"
    @IBOutlet weak var lbContents: UILabel!
    public var mIdx : Int = 0
    
    private var mListenr : EventProtocol? = nil
    
    @IBAction func onClick(_ sender: Any)
    {
        mListenr?.receiveEventFromViewItem(gbn: mIdx, data: "")
    }
    
    public func setOnEventListener(listenr : EventProtocol)
    {
        mListenr = listenr
    }
}
