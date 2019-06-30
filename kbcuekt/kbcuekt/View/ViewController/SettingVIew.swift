//
//  SettingView.swift
//  설정
//
//  Created by grapegirl on 2018. 9. 14..
//  Copyright © 2018년 kikiplus. All rights reserved.
//

import UIKit


class SettingView: UIViewController,  UITableViewDelegate, UITableViewDataSource, EventProtocol {
    
    private let TAG : String = "SettingView"
    
    private let TOAST_MASSEGE : Int             = 10
    private let LOAD_NOTICE_LIST : Int          = 20
    private let SET_NOTICE_LIST : Int           = 30
    private let SERVER_LOADING_FAIL : Int       = 40
    
    private var mList = Array<String>()
    private var mGroupList = Array<String>()
    private var mChildList = Array<String>()
    private var mChildListContent = Array<String>()
    
    var expandedRows = Set<Int>()
    @IBOutlet weak var mTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        KLog.d(tag: TAG, msg: "viewDidLoad");
        initialize()
    }
    
    func initialize(){
        //    KProgressDialog.setDataLoadingDialog(this, true, this.getString(R.string.loading_string), true);
        mTableView.delegate = self
        mTableView.dataSource = self
        mTableView.separatorStyle = .none
        setBackgroundColor()
        setListData()
        handleMessage(what: SET_NOTICE_LIST, obj: "")
    }
    
    func setListData(){
        let confString = AppUtils.localizedString(forKey: "confList")
        let strArray = confString.split(separator: ",")
        for item in strArray {
            mList.append(String(item))
        }
        
    }
    
    private func setBackgroundColor() {
        let mBackColor : String = UserDefault.read(key: ContextUtils.BACK_MEMO)
        
        if (mBackColor.count > 0){
            let uColor = UIColor(hexRGB: mBackColor)
            view.backgroundColor = uColor
            mTableView.backgroundColor = uColor
        }
    }
    
    @IBAction func onBackPressed(_ sender: Any) {
        KLog.d(tag: TAG, msg: "onBackPressed")
        ViewUtils.changeView(strView: ContextUtils.MAIN_VIEW, viewCtrl: self)
    }
    
    
   
    func handleMessage(what : Int, obj : String) {
        switch(what){
        case TOAST_MASSEGE:
            Toast.showToast(message: obj)
            break;
        case SET_NOTICE_LIST:
            // KProgressDialog.setDataLoadingDialog(this, false, null, false);
            DispatchQueue.main.async {
                self.mTableView.reloadData()
            }
            break;
        case SERVER_LOADING_FAIL:
            //KProgressDialog.setDataLoadingDialog(this, false, null, false);
            let message = AppUtils.localizedString(forKey : "server_fail_string")
            handleMessage(what: TOAST_MASSEGE, obj: message)
            break;
        default:
            break;
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = mTableView.dequeueReusableCell(withIdentifier: "SettingCustomCell", for: indexPath) as! SettingCustomCell
   
        cell.lbContents.text = mList[indexPath.row]
        cell.mIdx = indexPath.row
        cell.selectionStyle = .none
        cell.setOnEventListener(listenr: self)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        KLog.d(tag: TAG, msg: "@@ row: \(indexPath.row)")
    }
    
    func receiveEventFromViewItem(gbn : Int, data : String) {
        KLog.d(tag: TAG, msg: "receiveEventFromViewItem gbn : " + String(gbn))
        changeMenuView(menu: gbn)
    }
    
    func changeMenuView(menu : Int){
          KLog.d(tag: TAG, msg: "changeMenuView menu : " + String(menu))
        switch menu {
        case 0://암호설정
            changeView(viewName: "PassWordView")
            break
        case 1://암호해제
            let message = AppUtils.localizedString(forKey : "password_cancle_string")
            Toast.showToast(message: message)
            UserDefault.write(key: ContextUtils.KEY_CONF_PASSWORD, value: "")
            break
        case 2://DB관리
            changeView(viewName: "DBMgrView")
            break
        case 3://별명설정
            changeView(viewName: "SetNickNameView")
            break
        case 4://배경설정
            changeView(viewName: "SetBackColorView")
            break
        case 5://튜토리얼
            changeView(viewName: "TutorialView")
            break
        case 6://문의하기
            changeView(viewName: "QuestionView")
            break
        case 7://관리자 블로그
            if let url = URL(string: ContextUtils.KBUCKET_BLOG) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: [:])
                } else {
                    // Fallback on earlier versions
                }
            }
            break
        case 8://공유하기
            break
        case 9://버킷리스트 100
            changeView(viewName: "AddBucketView")
            break
        default:
            break
        }
    }
    
    func changeView(viewName : String){
        KLog.d(tag: TAG, msg: "changeView : " + viewName)
        let uvc = self.storyboard?.instantiateViewController(withIdentifier: viewName)
        uvc?.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal //페이지 전환시 에니메이션 효과 설정
        present(uvc!, animated: true, completion: nil)
    }

}
