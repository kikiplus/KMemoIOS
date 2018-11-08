//
//  SetNickNameView.swift
//  사용자 닉네임 설정
//
//  Created by grapegirl on 2018. 8. 23..
//  Copyright © 2017년 kikiplus. All rights reserved.
//

import UIKit

class SetNickNameView : UIViewController {

    private let TAG : String = "SetNickNameView"
    private var mSqlQuery : SQLQuery? = nil
    @IBOutlet weak var etName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        KLog.d(tag: TAG, msg: "viewDidLoad")
        initialize()
    }

    func initialize(){
        mSqlQuery = SQLQuery()
        let nickname = UserDefault.read(key:ContextUtils.KEY_USER_NICKNAME)
        if(nickname.count > 0 ){
            etName.becomeFirstResponder()
            etName.text = nickname
        }
        AppUtils.sendTrackerScreen(screen: "닉네임변경화면");
    }
    
    @IBAction func onClick(_ sender: Any) {
        var name =  etName.text
        if(name == "" || name == nil){
            let message = AppUtils.localizedString(forKey : "nickname_fail_string")
            Toast.showToast(message: message)
            return
        }
        name = name?.replacingOccurrences(of: " ", with: "")
        UserDefault.write(key: ContextUtils.KEY_USER_NICKNAME, value: name!)
        mSqlQuery?.updateUserNickName(nickanme: name!)
        back(strBack: ContextUtils.MAIN_VIEW)
    }
    
    @IBAction func onBackPressed(_ sender: Any) {
        back(strBack: ContextUtils.MAIN_VIEW)
    }
    
    private func back(strBack : String){
        KLog.d(tag: TAG, msg: "back : " + strBack)
        if(strBack == ContextUtils.VIEW_COMPLETE_LIST){
            ViewUtils.changeView(strView: ContextUtils.VIEW_COMPLETE_LIST, viewCtrl: self)
        }else{
            ViewUtils.changeView(strView: ContextUtils.MAIN_VIEW, viewCtrl: self)
        }
    }
}
