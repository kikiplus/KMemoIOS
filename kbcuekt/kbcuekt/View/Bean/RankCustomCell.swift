//
//  RankCustomCell
//  kbucket
//
//  Created by 김미혜 on 2018. 09. 10..
//  Copyright © 2018년 kikiplus. All rights reserved.
//

import Foundation
import UIKit

class RankCustomCell : UITableViewCell{
    
    private let TAG : String = "RankCustomCell"
    
    @IBOutlet weak var btBest: UIButton!
    @IBOutlet weak var btGood: UIButton!
    @IBOutlet weak var btSoso: UIButton!
    
    @IBOutlet weak var lbBest: UILabel!
    @IBOutlet weak var lbGood: UILabel!
    @IBOutlet weak var lbSoso: UILabel!
    
    @IBOutlet weak var etContens: UITextField!
    
    public var mData : String = ""
    private var mListenr : EventProtocol? = nil
    
    @IBAction func onClick(_ sender: Any)
    {
        switch((sender  as! UIButton))
        {
        case btBest:
            mListenr?.receiveEventFromViewItem(gbn: 3, data: mData)
            break
        case btGood:
            mListenr?.receiveEventFromViewItem(gbn: 2, data: mData)
            break
        case btSoso:
            mListenr?.receiveEventFromViewItem(gbn: 1, data: mData)
            break
        default:
            break
        }
        
    }
    
    
    public func setOnEventListener(listenr : EventProtocol)
    {
        mListenr = listenr
    }
}

