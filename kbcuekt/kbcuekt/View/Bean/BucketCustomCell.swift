
//
//  BucketCustomCell.swift
//  kbucket
//
//  Created by 김미혜 on 2017. 12. 11..
//  Copyright © 2017년 kikiplus. All rights reserved.
//

import Foundation
import UIKit

class BucketCustomCell  : UITableViewCell { 
    
    private let TAG : String = "BucketCustomCell"
    public var mData : String = ""
    
    @IBOutlet weak var mEtContent: UITextField!
    @IBOutlet weak var mBtDate: UIButton!
    @IBOutlet weak var ivImage: UIImageView!
    
    private var mListener : EventProtocol? = nil
    
    @IBAction func onClick(_ sender: Any)
    {
         mListener?.receiveEventFromViewItem(gbn: 0, data: mData)
    }
    
    public func setOnEventListener(listener : EventProtocol)
    {
        mListener = listener
    }
}

