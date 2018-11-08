//
//  FirstCustomCell.swift
//  kbucket
//
//  Created by 김미혜 on 2017. 8. 26..
//  Copyright © 2017년 kikiplus. All rights reserved.
//

import Foundation
import UIKit

class FirstCustomCell : UITableViewCell{
    
    private let TAG : String = "FirstCustomCell"
    
    @IBOutlet public var btDel: UIButton!
    @IBOutlet public var btMod: UIButton!
    @IBOutlet public var btEdt: UITextField!
    @IBOutlet weak var btEditFull: UITextField!
    
    public var mData : String = ""
    private var mListenr : EventProtocol? = nil
    
    @IBAction func onClick(_ sender: Any)
    {
        switch((sender  as! UIButton))
        {
        case btDel:
            mListenr?.receiveEventFromViewItem(gbn: 1, data: mData)
            break;
        case btMod:
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

