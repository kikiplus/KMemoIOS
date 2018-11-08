//
//  AddBucketView.swift
//   버킷 추가
//
//  Created by grapegirl on 2017. 9. 01..
//  Copyright © 2017년 kikiplus. All rights reserved.
//

import UIKit


class AddBucketView: UIViewController,  UITableViewDelegate, UITableViewDataSource,
EventProtocol {

    private let TAG : String = "AddBucketView"

    private var mBucketDataList = Array<PostData>()
    private var mDataList  = Array<String>()

    private var mSqlQuery  : SQLQuery? = nil
    private var mbVisible : Bool  = true

    @IBOutlet weak var btBack: UIButton!
    @IBOutlet weak var btListAdd: UIButton!
    @IBOutlet weak var mTableView: UITableView!
    
    let mBackColor : String = UserDefault.read(key: ContextUtils.BACK_MEMO)
    
    // private ConfirmPopup mConfirmPopup = null;

    override func viewDidLoad() {
        super.viewDidLoad()
        KLog.d(tag: TAG, msg: "viewDidLoad")
        initialize()
    }

    func initialize(){
        mTableView.delegate = self
        mTableView.dataSource = self
        setBackgroundColor()
        AppUtils.sendTrackerScreen(screen: "관심버킷추가호면")
        setListData()
        mSqlQuery = SQLQuery()
    }

    private func setBackgroundColor() {
        if mBackColor.count > 0 {
            let uColor = UIColor(hexRGB: mBackColor)
            view.backgroundColor = uColor
            mTableView.backgroundColor = uColor
        }
    }
    
    func setListData(){
        let dreamString = AppUtils.localizedString(forKey: "dream100")
        let strArray = dreamString.split(separator: ",")
        for item in strArray {
            mDataList.append(String(item))
        }
       
    }
    func finish(){
        KLog.d(tag: TAG, msg: "finish")
        //deleteImageResource()
        let uvc = self.storyboard?.instantiateViewController(withIdentifier: ContextUtils.MAIN_VIEW)
        uvc?.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal //페이지 전환시 에니메이션 효과 설정
        present(uvc!, animated: true, completion: nil)
    }

    
    @IBAction func onClick(_ sender : Any) {
        switch(sender as! UIButton){
        case btBack:
            finish()
            break
        
        case btListAdd:
            mbVisible = !mbVisible
            setButtonTitle()
            mTableView.reloadData()
            break
        
        default:
            break
        }
    }
    
    func setButtonTitle(){
        if(mbVisible){
            let btnName = AppUtils.localizedString(forKey : "interest_bucket_list_add")
            btListAdd.setTitle(btnName, for: .normal)
        }else{
            let btnName = AppUtils.localizedString(forKey : "interest_bucket_list_view")
            btListAdd.setTitle(btnName, for: .normal)
        }
    }

    /**
     * DB 데이타 동기화하기(삭제)
     */
    func removeDBData(Content : String) {
        KLog.d(tag: TAG, msg: "@@ remove Data Contents : " + Content);
        if(mSqlQuery != nil){
           mSqlQuery?.deleteUserBucket(contents: Content)
        }
        
        let inContainsBucket : Bool = mSqlQuery?.containsKbucket(memoContents: Content) ?? false
        if(!inContainsBucket){
            let message = AppUtils.localizedString(forKey: "share_delete_popup_ok")
            Toast.showToast(message: message)
        }
    }

    /**
     * DB 데이타 동기화하기(추가)
     *
     * @param Content 내용
     */
    func addDBData(Content : String) {
        KLog.d(tag: TAG, msg: "addDBData data : " + Content)
        let inContainsBucket : Bool = mSqlQuery?.containsKbucket(memoContents: Content) ?? false
        var message = ""
        if(!inContainsBucket){
            message = AppUtils.localizedString(forKey: "share_add_popup_ok")
            if(mSqlQuery != nil){
                let date = DateUtils.getStringDateFormat(pattern: DateUtils.DATE_YYMMDD_PATTER)
                mSqlQuery?.insertUserSetting(contents: Content, date: date, completeYN: "N", completedDate: "")
            }
        }else{
            message = AppUtils.localizedString(forKey: "check_input_bucket_string")
        }
        Toast.showToast(message: message)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        KLog.d(tag: TAG, msg: "@@ tableView count : " + String(mDataList.count))
        return mDataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mTableView.dequeueReusableCell(withIdentifier: "FirstCustomCell", for: indexPath) as! FirstCustomCell

        cell.mData = mDataList[indexPath.row]
        setButtonTitle()
        KLog.d(tag: TAG, msg: "@@ tableview adpater visible : " + String(mbVisible))
        if(mbVisible){
            cell.btMod.isHidden = false
            cell.btDel.isHidden = false
            cell.btEditFull.isHidden = true
            cell.btEdt.text = mDataList[indexPath.row]
        }else{
            cell.btMod.isHidden = true
            cell.btDel.isHidden = true
            cell.btEditFull.isHidden = false
            cell.btEditFull.text = mDataList[indexPath.row]
        }
        
        cell.selectionStyle = .none
        if mBackColor.count > 0 {
            let uColor = UIColor(hexRGB: mBackColor)
            cell.backgroundColor = uColor
        }
        cell.setOnEventListener(listenr: self)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        KLog.d(tag: TAG, msg: "row: \(indexPath.row)")
    }
    
    func receiveEventFromViewItem(gbn : Int, data : String) {
        KLog.d(tag: TAG, msg: "receiveEventFromViewItem data : " + data)
        switch(gbn){
        case 0://추가
            addDBData(Content: data)
            break
        case 1://삭제
            removeDBData(Content: data)
            break
        default:
            break
        }
    }
}
