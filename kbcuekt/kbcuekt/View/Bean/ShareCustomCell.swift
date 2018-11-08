//
//  ShareCustomCell.swift
//  kbucket
//
//  Created by 김미혜 on 2017. 11. 25..
//  Copyright © 2017년 kikiplus. All rights reserved.
//

import Foundation
import UIKit

class ShareCustomCell : UITableViewCell{
    
    private let TAG : String = "ShareCustomCell"
    
    @IBOutlet public var btDetail: UIButton!
    @IBOutlet public var etEdit: UITextField!
    
    public var mData : String = ""
    private var mListenr : EventProtocol? = nil
    
    @IBAction func onClick(_ sender: Any)
    {
        switch((sender  as! UIButton))
        {
            case btDetail:
                mListenr?.receiveEventFromViewItem(gbn: 0, data: mData)
                break;
            default:
                break;
        }
        
    }
    
    
    public func setOnEventListener(listenr : EventProtocol)
    {
        mListenr = listenr
    }
}

