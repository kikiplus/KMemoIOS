//
//  DBMgrView.swift
//  kbucket
//
//  Created by 김미혜 on 2018. 8. 31..
//  Copyright © 2018년 kikiplus. All rights reserved.
//

import Foundation
import UIKit

class DBMgrView : UIViewController {
    
    private let TAG : String = "DBMgrView"
    private var mSqlQuery  : SQLQuery? = nil
    
    @IBOutlet weak var btDBMenu01: UIButton!
    @IBOutlet weak var btDBMenu02: UIButton!
    @IBOutlet weak var btDBMenu03: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        KLog.d(tag: TAG, msg: "viewDidLoad");
         mSqlQuery = SQLQuery()
        
    }
    
    @IBAction func onBackPressed(_ sender: Any) {
        KLog.d(tag: TAG, msg: "onBackPressed")
        ViewUtils.changeView(strView: ContextUtils.MAIN_VIEW, viewCtrl: self)
    }
    
    @IBAction func onClick(_ sender: Any) {
        switch sender as! UIButton {
        case btDBMenu01://DB 원복
            KLog.d(tag: TAG, msg: "onclick ReBack")
            let message = AppUtils.localizedString(forKey : "popup_prepare_string")
            Toast.showToast(message: message)
            break
        case btDBMenu02://DB 백업
            KLog.d(tag: TAG, msg: "onclick Backup")
//            let newDBName = DateUtils.getStringDateFormat(pattern: DateUtils.KBUCKET_DB_DATE_PATTER)
//            var isResult : Bool = DataUtils.exportDB(NewdbName: newDBName)
//            KLog.d(tag: TAG, msg: "BackUp isResult : " + String(isResult))
//            if (isResult) {
//                let message = AppUtils.localizedString(forKey : "db_backup_path_string")
//                let path = DataUtils.getProjectFilePath() + newDBName + ".db";
//                KLog.d(tag: TAG, msg: "BackUp path : " + path)
//                //mHandler.sendMessage(mHandler.obtainMessage(UPLOAD_DB, path));
//
//                let message2 = message + "\n" + ContextUtils.KEY_FILE_FOLDER + "/" + newDBName + ".db"
//                Toast.showToast(message: message2 )
//            } else {
//                let message = AppUtils.localizedString(forKey : "db_backup_faile_string")
//                Toast.showToast(message: message)
//            }
            let message = AppUtils.localizedString(forKey : "popup_prepare_string")
            Toast.showToast(message: message)
            break
        case btDBMenu03://Table 삭제
            KLog.d(tag: TAG, msg: "onclick Reset")
            mSqlQuery?.DeleteBucketContents()
            let message = AppUtils.localizedString(forKey : "db_delete_bucket")
            Toast.showToast(message: message)
           break
        default:
            break
        }
        
    }
    
}

