//
//  RankListView.swift
//  버킷 랭킹 목록
//
//  Created by grapegirl on 2017. 9. 01..
//  Copyright © 2017년 kikiplus. All rights reserved.
//

import UIKit

class RankListView : UIViewController , IHttpReceive , UITableViewDelegate, UITableViewDataSource, EventProtocol{

    private let TAG : String = "RankListView"

    private let TOAST_MASSEGE : Int         = 10
    private let SERVER_LOADING_FAIL : Int   = 20
    private let LOAD_BUCKET_RANK : Int      = 30
    private let SET_LIST : Int              = 40
    private let SEND_BUCKET_RANK : Int      = 50
 
    private var mBucketDataList = Array<BucketRank>()
    private var mBucketRankComment : Int = -1
    private var mBucketRankIdx : Int = -1

    @IBOutlet weak var mTableView: UITableView!
    let mBackColor : String = UserDefault.read(key: ContextUtils.BACK_MEMO)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        KLog.d(tag: TAG, msg: "viewDidLoad")
        initialize()
    }

    func initialize(){
        mTableView.delegate = self
        mTableView.dataSource = self
        AppUtils.sendTrackerScreen(screen : "버킷랭킹화면")
        handleMessage(what: LOAD_BUCKET_RANK, obj: "")
    }
    
    private func setBackgroundColor() {
        if mBackColor.count > 0 {
            let uColor = UIColor(hexRGB: mBackColor)
            view.backgroundColor = uColor
            mTableView.backgroundColor = uColor
        }
    }
  
    @IBAction func onBackPressed(_ sender: Any) {
        KLog.d(tag: TAG, msg: "onBackPressed");
        let uvc = self.storyboard?.instantiateViewController(withIdentifier: ContextUtils.MAIN_VIEW)
        uvc?.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal //페이지 전환시 에니메이션 효과 설정
        present(uvc!, animated: true, completion: nil)
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

        if (actionId == ConstHTTP.RANK_LIST) {
        // KProgressDialog.setDataLoadingDialog(this, false, null, false);
                if (type == ConstHTTP.HTTP_OK && isValid == true) {
                      do {
                        if let jsonString = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                                let List : NSArray = jsonString["bucketList"] as! NSArray
                                let size : Int = List.count
                                if size > 0 {
                                mBucketDataList.removeAll()
                                for index in 0...size-1  {
                                    let aObject = List[index] as! [String : AnyObject]
                                    let bucket : BucketRank = BucketRank()
                                    bucket.mCategoryCode = aObject["categoryCode"] as! Int
                                    bucket.mContent = aObject["content"] as! String
                                    bucket.mIdx = aObject["idx"] as! Int
                                    bucket.mBestCnt = aObject["bestCnt"] as! Int
                                    bucket.mGoodCnt = aObject["goodCnt"] as! Int
                                    bucket.mSoSoCnt = aObject["ssoCnt"] as! Int
                                    bucket.mComment = aObject["comment"] as! Int

                                    mBucketDataList.append(bucket)
                                }
                            }
                        }
                        handleMessage(what: SET_LIST, obj: "")
                    } catch {
                        KLog.d(tag : TAG, msg : "@@ Exception : ")
                        handleMessage(what: SERVER_LOADING_FAIL, obj: "")
                    }
                } else {
                    handleMessage(what: SERVER_LOADING_FAIL, obj: "")
                }
        }else if (actionId == ConstHTTP.RANK_UPDATE_COMMENT) {
            //KProgressDialog.setDataLoadingDialog(this, false, null, false);
            if (type == ConstHTTP.HTTP_OK && isValid == true) {
                mBucketDataList.removeAll()
                handleMessage(what: LOAD_BUCKET_RANK, obj: "")
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
                finish()
                break
            case LOAD_BUCKET_RANK:
//    //        KProgressDialog.setDataLoadingDialog(this, true, this.getString(R.string.loading_string), true);
                let url  = ContextUtils.KBUCKET_RANK_LIST_URL
                let userNickName = UserDefault.read(key: ContextUtils.KEY_USER_NICKNAME)
                let  httpUrlTaskManager : HttpUrlTaskManager =  HttpUrlTaskManager(url : url, post : true, receive : self, id : ConstHTTP.RANK_LIST)
                let data = "pageNm=1&nickname=" + userNickName
                httpUrlTaskManager.actionTaskWithData(data: data)
                break
            case SET_LIST:
                DispatchQueue.main.async {
                    self.mTableView.reloadData()
                }
                break
            case SEND_BUCKET_RANK:
//    //             KProgressDialog.setDataLoadingDialog(this, true, this.getString(R.string.loading_string), true);
                let url  = ContextUtils.KBUCKET_RANK_COMMENT
                let userNickName2 = UserDefault.read(key: ContextUtils.KEY_USER_NICKNAME)
                let  httpUrlTaskManager : HttpUrlTaskManager =  HttpUrlTaskManager(url : url, post : true, receive : self, id : ConstHTTP.RANK_UPDATE_COMMENT)
                let sendData = "idx=" + String(mBucketRankIdx) + "&comment=" + String(mBucketRankComment) + "&nickname=" + userNickName2
                httpUrlTaskManager.actionTaskWithData(data: sendData)
                break
          default:
                break
        }
     }
  
    private func getCommentCount( index : Int ) -> Bool {
        if (mBucketDataList != nil) {
            for bucket in mBucketDataList {
                if (bucket.mIdx == index) {
                    let comment = bucket.mComment
                    if(comment != 0){
                        return true
                    }
                }
            }
        }
        return false
    }

    private func finish(){
        KLog.d(tag: TAG, msg: "finish")
        ViewUtils.changeView(strView: ContextUtils.MAIN_VIEW, viewCtrl: self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        KLog.d(tag: TAG, msg: "mBucketDataList count : " + String(mBucketDataList.count))
        return mBucketDataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mTableView.dequeueReusableCell(withIdentifier: "RankCustomCell", for: indexPath) as! RankCustomCell
        cell.etContens.text = mBucketDataList[indexPath.row].mContent
        cell.lbBest.text = String(mBucketDataList[indexPath.row].mBestCnt)
        cell.lbGood.text = String(mBucketDataList[indexPath.row].mGoodCnt)
        cell.lbSoso.text = String(mBucketDataList[indexPath.row].mSoSoCnt)
        
        cell.mData = String(mBucketDataList[indexPath.row].mIdx)
        
        let comment : Int = mBucketDataList[indexPath.row].mComment
        if (comment == 3) {
            cell.btBest.backgroundColor = UIColor.white
            cell.btBest.setTitleColor(UIColor(hexRGB: "#FFCC0000"), for: .normal)
            cell.btGood.backgroundColor = UIColor(hexRGB: "#FF33B5E5")
            cell.btGood.setTitleColor(UIColor.black, for: .normal)
            cell.btSoso.backgroundColor = UIColor(hexRGB: "#FF99CC00")
            cell.btSoso.setTitleColor(UIColor.black, for: .normal)
        } else if (comment == 2) {
            cell.btBest.backgroundColor = UIColor(hexRGB: "#FFCC0000")
            cell.btBest.setTitleColor(UIColor.black, for: .normal)
            cell.btGood.backgroundColor = UIColor.white
            cell.btGood.setTitleColor(UIColor(hexRGB: "#FF33B5E5"), for: .normal)
            cell.btSoso.backgroundColor = UIColor(hexRGB: "#FF99CC00")
            cell.btSoso.setTitleColor(UIColor.black, for: .normal)
        } else if (comment == 1) {
            cell.btBest.backgroundColor = UIColor(hexRGB: "#FFCC0000")
            cell.btBest.setTitleColor(UIColor.black, for: .normal)
            cell.btGood.backgroundColor = UIColor(hexRGB: "#FF33B5E5")
            cell.btGood.setTitleColor(UIColor.black, for: .normal)
            cell.btSoso.backgroundColor = UIColor.white
            cell.btSoso.setTitleColor(UIColor(hexRGB: "#FF99CC00"), for: .normal)
        } else {
            cell.btBest.backgroundColor = UIColor(hexRGB: "#FFCC0000")
            cell.btBest.setTitleColor(UIColor.black, for: .normal)
            cell.btGood.backgroundColor = UIColor(hexRGB: "#FF33B5E5")
            cell.btGood.setTitleColor(UIColor.black, for: .normal)
            cell.btSoso.backgroundColor = UIColor(hexRGB: "#FF99CC00")
            cell.btSoso.setTitleColor(UIColor.black, for: .normal)
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
        case 3://최고
            mBucketRankComment = 3
            break
        case 2://좋아요
            mBucketRankComment = 2
            break
        case 1://괜찮아요
            mBucketRankComment = 1
            break
        default:
            break
        }
        
        let nIdx : Int = Int(data)!
        let isSendSever = getCommentCount(index: nIdx)
          KLog.d(tag: TAG, msg: "receiveEventFromViewItem isSendSever : " + String(isSendSever))
        if( !isSendSever){
            mBucketRankIdx = nIdx
            handleMessage(what: SEND_BUCKET_RANK, obj: "")
        }else{
            handleMessage(what: TOAST_MASSEGE, obj: "이미 의견을 반영했습니다! ")
        }
    }
}
