//
//  NoticeView.swift
//  공지사항
//
//  Created by grapegirl on 2017. 9. 01..
//  Copyright © 2017년 kikiplus. All rights reserved.
//

import UIKit


class NoticeView: UIViewController , IHttpReceive ,  UITableViewDelegate, UITableViewDataSource {
    
    private let TAG : String = "NoticeView"

    private let TOAST_MASSEGE : Int             = 10
    private let LOAD_NOTICE_LIST : Int          = 20
    private let SET_NOTICE_LIST : Int           = 30
    private let SERVER_LOADING_FAIL : Int       = 40

    private var mList = Array<UpdateApp>()
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
        self.mTableView.rowHeight = UITableView.automaticDimension
        handleMessage(what: LOAD_NOTICE_LIST, obj: "")
        AppUtils.sendTrackerScreen(screen: "공지화면");
    }

    @IBAction func onBackPressed(_ sender: Any) {
        KLog.d(tag: TAG, msg: "onBackPressed")
        ViewUtils.changeView(strView: ContextUtils.MAIN_VIEW, viewCtrl: self)
    }
    

    func onHttpReceive(type: Int, actionId: Int, data: Data) {
        KLog.d(tag : TAG, msg : "@@ onHttpReceive actionId: " + String(actionId))
        KLog.d(tag : TAG, msg : "@@ onHttpReceive  type: " + String(type))

        var isValid : Bool  = false
        do {
            if let jsonString = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] {
                if jsonString != nil {
                    isValid = jsonString["isValid"] as! Bool
                    // print(jsonString)
                }
            }
        } catch {
            print("JSON 파상 에러")
        }

        if (actionId == ConstHTTP.NOTICE_LIST) {
         if (type == ConstHTTP.HTTP_OK && isValid == true) {

              do {
                      if let jsonString = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                            let List : NSArray = jsonString["updateVOList"] as! NSArray
                            let size : Int = List.count
                            if size > 0 {
                            mList.removeAll()
                            mGroupList.removeAll()
                            mChildList.removeAll()
                            for index in 0...size-1  {
                                let aObject = List[index] as! [String : AnyObject]
                                let updateApp : UpdateApp = UpdateApp()
                                updateApp.mVersionCode = aObject["versionCode"] as! Int
                                updateApp.mContent = aObject["updateContent"] as! String
                                mList.append(updateApp)

                                let mTitle = aObject["updateContent"] as! String
                                mGroupList.append(mTitle)
                                mChildListContent = Array<String>()
                                mChildListContent.append(aObject["updateContent"] as! String)
                                
                                print(mTitle)
                            }
                            handleMessage(what: SET_NOTICE_LIST, obj: "")
                        }
                    }
                
                } catch {
                    KLog.d(tag : TAG, msg : "@@ Exception : ")
                    handleMessage(what: SERVER_LOADING_FAIL, obj: "")
                }
        	} 
    	}
	}

    func handleMessage(what : Int, obj : String) {
        switch(what){
        case TOAST_MASSEGE:
            Toast.showToast(message: obj)
            break;
        case LOAD_NOTICE_LIST:
            let url  = ContextUtils.KBUCKET_NOTICE_URL
            let  httpUrlTaskManager : HttpUrlTaskManager =  HttpUrlTaskManager(url : url, post : false, receive : self, id : ConstHTTP.NOTICE_LIST)
            httpUrlTaskManager.actionTask()
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
        
        let cell = mTableView.dequeueReusableCell(withIdentifier: "NoticeCustomCell", for: indexPath) as! NoticeCustomCell
        cell.lbNotice.text = mList[indexPath.row].mContent
        cell.lbContents.text = mList[indexPath.row].mContent
        
        cell.isExpanded = self.expandedRows.contains(indexPath.row)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        KLog.d(tag: TAG, msg: "@@ row: \(indexPath.row)")
        print(indexPath.row)
        
        guard let cell = mTableView.cellForRow(at: indexPath) as? NoticeCustomCell
        else { return }
        switch cell.isExpanded
        {
        case true:
            self.expandedRows.remove(indexPath.row)
        case false:
            self.expandedRows.insert(indexPath.row)
        }
        cell.isExpanded = !cell.isExpanded
        self.mTableView.beginUpdates()
        self.mTableView.endUpdates()
    }

}
