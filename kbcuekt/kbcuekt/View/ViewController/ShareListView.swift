//
//  ShareListView.swift
//  공유 목록
//
//  Created by grapegirl on 2017. 11. 04..
//  Copyright © 2017년 kikiplus. All rights reserved.
//

import UIKit
import Foundation

class ShareListView: UIViewController , IHttpReceive, UITableViewDelegate, UITableViewDataSource, EventProtocol {
    
    private let TAG : String = "ShareListView"
    
    private let TOAST_MASSEGE : Int             = 10
    private let CATEGORY_LIST : Int             = 20
    private let SET_CATEGORY : Int              = 30
    private let SERVER_LOADING_FAIL : Int       = 40
    private let SHARE_BUCKET_LIST : Int         = 50
    private let SET_BUCKETLIST : Int            = 60
    private let CHECK_NETWORK : Int             = 70
    
    private var mCategoryList = Array<Category>()
    private var mBucketDataList = Array<Bucket>()
    private var mButtonList = Array<UIButton>()
    
    @IBOutlet weak var btCategory0: UIButton!
    @IBOutlet weak var btCategory1: UIButton!
    @IBOutlet weak var btCategory2: UIButton!
    @IBOutlet weak var btCategory3: UIButton!
    @IBOutlet weak var btCategory4: UIButton!
    @IBOutlet weak var btCategory5: UIButton!
    @IBOutlet weak var btCategory6: UIButton!
    @IBOutlet weak var btCategory7: UIButton!
    @IBOutlet weak var btCategory8: UIButton!
    @IBOutlet weak var mTableView: UITableView!
    
    @IBOutlet var backView: UIView!
    private let uColor = UIColor(hexRGB: "#67D91A")
    let mBackColor : String = UserDefault.read(key: ContextUtils.BACK_MEMO)

    override func viewDidLoad() {
        super.viewDidLoad()
        KLog.d(tag: TAG, msg: "viewDidLoad");
        AppUtils.sendTrackerScreen(screen: "모두가지화면");
        initialize()
    }
    
    func initialize(){
        mTableView.delegate = self
        mTableView.dataSource = self
        mButtonList.append(btCategory0)
        mButtonList.append(btCategory1)
        mButtonList.append(btCategory2)
        mButtonList.append(btCategory3)
        mButtonList.append(btCategory4)
        mButtonList.append(btCategory5)
        mButtonList.append(btCategory6)
        mButtonList.append(btCategory7)
        mButtonList.append(btCategory8)
        handleMessage(what: SHARE_BUCKET_LIST, obj : "1")
        btCategory0.setTitleColor(uColor, for: .normal)
        btCategory0.backgroundColor = UIColor.white
        setBackgroundColor()
    }
    
    private func setBackgroundColor() {
        if mBackColor != nil {
            let uColor = UIColor(hexRGB: mBackColor)
            view.backgroundColor = uColor
            backView.backgroundColor = uColor
            mTableView.backgroundColor = uColor
        }
    }
    func setCategoryList() {
        mCategoryList.append(Category(name : "LIEF", code: 1))
        mCategoryList.append(Category(name : "LOVE", code : 2))
        mCategoryList.append(Category(name : "WORK", code : 3))
        mCategoryList.append(Category(name : "EDUCATION", code : 4))
        mCategoryList.append(Category(name : "FAMILY", code : 5))
        mCategoryList.append(Category(name : "FINANCE", code : 6))
        mCategoryList.append(Category(name : "DEVELOP", code : 7))
        mCategoryList.append(Category(name : "HEALTH", code : 8))
        mCategoryList.append(Category(name : "ETC", code : 9))
    }
    
    @IBAction func onBackPressed(_ sender: Any) {
        KLog.d(tag: TAG, msg: "onBackPressed");
        let uvc = self.storyboard?.instantiateViewController(withIdentifier: ContextUtils.MAIN_VIEW)
        uvc?.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal //페이지 전환시 에니메이션 효과 설정
        present(uvc!, animated: true, completion: nil)
    }
    
    @IBAction func onClick(_ sender: Any) {
        var categoryCode : String = "1"
        switch(sender  as! UIButton ){
        case btCategory0:
            categoryCode = "1"
        case btCategory1:
            categoryCode = "2"
        case btCategory2:
            categoryCode = "3"
        case btCategory3:
            categoryCode = "4"
        case btCategory4:
            categoryCode = "5"
        case btCategory5:
            categoryCode = "6"
        case btCategory6:
            categoryCode = "7"
        case btCategory7:
            categoryCode = "8"
        case btCategory8:
            categoryCode = "9"
            break;
        default:
            break;
        }
      
        KLog.d(tag: TAG, msg: "Category" + categoryCode)
        setAllButtonReset()
        let button : UIButton = sender as! UIButton
        button.setTitleColor(uColor, for: .normal)
        button.backgroundColor = UIColor.white
        
        handleMessage(what: SHARE_BUCKET_LIST, obj : categoryCode)
    }
    
    func setAllButtonReset(){
        for item in mButtonList {
            item.setTitleColor(UIColor.white, for: .normal)
            item.backgroundColor = uColor
        }
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

        
        if (actionId == ConstHTTP.CATEGORY_LIST) {
//         KProgressDialog.setDataLoadingDialog(this, false, null, false);
            if (type == ConstHTTP.HTTP_OK && isValid == true) {
                do {
                      if let jsonString = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                            let List : NSArray = jsonString["categoryVOList"] as! NSArray
                            let size : Int = List.count
                            if size > 0 {
                            for index in 0...size-1  {
                                let aObject = List[index] as! [String : AnyObject]
                                let code = aObject["categoryCode"] as! Int
                                let name = aObject["categoryName"] as! String
                                mCategoryList.append(Category(name : name, code: code))
                             }
                        }
                    }
                    handleMessage(what: SET_CATEGORY, obj: "")
                } catch {
                    KLog.d(tag : TAG, msg : "@@ Exception ")
                    handleMessage(what: SERVER_LOADING_FAIL, obj: "")
                }
            } else {
                  handleMessage(what: SERVER_LOADING_FAIL, obj: "")
            }
        } else if (actionId == ConstHTTP.BUCKET_LIST) {
            //         KProgressDialog.setDataLoadingDialog(this, false, null, false);
            if (type == ConstHTTP.HTTP_OK && isValid == true) {
                    do {
                        if let jsonString = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                            let bucketList : NSArray = jsonString["bucketList"] as! NSArray
                            let size : Int = bucketList.count
                            mBucketDataList.removeAll()
                            if size > 0 {
                                for index in 0...bucketList.count-1  {
                                    
                                    let aObject = bucketList[index] as! [String : AnyObject]
                                    let bucket : Bucket = Bucket()
                                    bucket.mContent = aObject["content"] as! String
                                    bucket.mDate = aObject["createDt"] as! String
                                    bucket.mPhone = aObject["phone"] as! String
                                    bucket.mIdx = aObject["idx"] as! Int
                                    bucket.mPhone = aObject["phone"] as! String
                                    bucket.mImageURl = aObject["imageUrl"] as! String
                                    bucket.mNickName = aObject["nickName"] as! String
                                    bucket.mCategoryCode = aObject["categoryCode"] as! Int
                                    bucket.mCompleteDate = aObject["createDt"] as! String
                                    
                                    //KLog.d(tag: TAG, msg: bucket.toString())
                                    mBucketDataList.append(bucket)
                                }
                            }
                        handleMessage(what: SET_BUCKETLIST, obj: "")
                        }
                } catch  {
                        KLog.d(tag : TAG, msg : "@@ jsonException message ");
                        handleMessage(what: SERVER_LOADING_FAIL, obj: "")
                }
            } else {
                handleMessage(what: SERVER_LOADING_FAIL, obj: "")
            }
        }
    }
    
    func handleMessage(what : Int, obj : String) {
        switch (what) {
            case TOAST_MASSEGE:
                Toast.showToast(message: obj)
                break
            case SERVER_LOADING_FAIL:
                let message = AppUtils.localizedString(forKey : "server_fail_string")
                handleMessage(what: TOAST_MASSEGE, obj: message)
                //  finish();
               
                UIView.animate(withDuration: 0, delay: 0.0, options: [.curveLinear, .allowUserInteraction, .beginFromCurrentState], animations: {
                   // animation code
                }) { (finished) in
                    // completion code
                }
                break
            case SHARE_BUCKET_LIST:
                var data : String = String(obj)
                if (data == nil) {
                    data = ContextUtils.DEFULAT_SHARE_BUCKET_IDX
                }
                //  KProgressDialog.setDataLoadingDialog(this, true, this.getString(R.string.loading_string), true);
                let url  = ContextUtils.KBUCKET_BUCKET_LIST_URL
                let  httpUrlTaskManager : HttpUrlTaskManager =  HttpUrlTaskManager(url : url, post : true, receive : self, id : ConstHTTP.BUCKET_LIST)
                data = "idx=" + data
                httpUrlTaskManager.actionTaskWithData(data: data)
                break
            case SET_BUCKETLIST:
                DispatchQueue.main.async {
                    self.mTableView.reloadData()
                }
                break
            case CHECK_NETWORK:
                let isConnect  : Bool = true //NetworkUtils.isConnectivityStatus(this)
                if (isConnect == false) {
                    let connectMsg = AppUtils.localizedString(forKey :"check_network")
                    handleMessage(what: TOAST_MASSEGE, obj: connectMsg)
                } else {
                    handleMessage(what: CATEGORY_LIST, obj: "")
                }
                break
            default:
                break
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mBucketDataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mTableView.dequeueReusableCell(withIdentifier: "ShareCustomCell", for: indexPath) as! ShareCustomCell
        
        cell.etEdit.text = mBucketDataList[indexPath.row].mContent
        cell.mData = String(indexPath.row)
        cell.selectionStyle = .none
        if (mBackColor.count > 0) {
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
        case 0://상세보기
           KLog.d(tag: TAG, msg: "receiveEventFromViewItem mod");
           let index:Int! = Int(data)
           let uvc = self.storyboard?.instantiateViewController(withIdentifier: "ShareDetailView") as! ShareDetailView
           uvc.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal //페이지 전환시 에니메이션 효과 설정
           uvc.idx = String(mBucketDataList[index].mIdx)
           uvc.mBucket.mIdx =  mBucketDataList[index].mIdx
           uvc.mBucket.mContent = mBucketDataList[index].mContent
           uvc.mBucket.mDate = mBucketDataList[index].mDate
           uvc.mBucket.mImageURl = mBucketDataList[index].mImageURl
           present(uvc, animated: true, completion: nil)
           
           break;
        default:
            break;
        }
    }
    
}
