//
//  ShareDetailView.swift
//  공유 싱세 화면
//
//  Created by grapegirl on 2018. 08. 21..
//  Copyright © 2017년 kikiplus. All rights reserved.
//

import UIKit


class ShareDetailView : UIViewController , IHttpReceive , UITableViewDelegate, UITableViewDataSource {

    private let TAG : String = "ShareDetailView"
   
    private let TOAST_MASSEGE : Int             = 10
    private let DOWNLOAD_IMAGE : Int            = 20
    private let LOAD_COMMENT_LIST : Int         = 30
    private let SERVER_LOADING_FAIL : Int       = 40
    private let SET_COMMENT_LIST : Int          = 50
    private let SET_IMAGE : Int                 = 60
   
    private var mCommentList = Array<Comment>()
    private var mBucketDataList = Array<PostData>()
    public var mUserNickname :  String = ""
    public var mDetailImageFileName :  String = ""

    private var mSqlQuery : SQLQuery? = nil
    public var mBucket  = Bucket()

    @IBOutlet var etComment: UITextField!
    @IBOutlet var btSend: UIButton!
    // private CommentListAdpater mListAdapter = null;
   // private ListView mListView = null;
   // private ConfirmPopup mConfirmPopup = null;
    
    public var idx : String = ""
    @IBOutlet weak var mEtShareContent: UITextField!
    @IBOutlet weak var mBtShareDate: UIButton!
    @IBOutlet weak var mIvShareImage: UIImageView!
    @IBOutlet weak var mTableView: UITableView!
    
    override func viewDidLoad() {
       super.viewDidLoad()
       KLog.d(tag: TAG, msg: "viewDidLoad");
       initialize()
   }

    func initialize(){
        mSqlQuery = SQLQuery()
        KLog.d(tag: TAG, msg: "@@ idx : " + idx)
        mUserNickname = UserDefault.read(key: ContextUtils.KEY_USER_NICKNAME)
        handleMessage(what: LOAD_COMMENT_LIST, obj: idx)
        setData(bucket : mBucket)
        mTableView.delegate = self
        mTableView.dataSource = self
        AppUtils.sendTrackerScreen(screen: "모두가지상세화면");
    }
    
    @IBAction func onBackPressed(_ sender: Any) {
        KLog.d(tag: TAG, msg: "onBackPressed");
        let uvc = self.storyboard?.instantiateViewController(withIdentifier: ContextUtils.SHARE_VIEW)
        uvc?.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal //페이지 전환시 에니메이션 효과 설정
        present(uvc!, animated: true, completion: nil)
    }
    

   /**
    * 데이타 초기화
    */
   func setData( bucket : Bucket) {
        KLog.d(tag : TAG, msg : "@@ image url : " + bucket.mImageURl)
        if (bucket.mImageURl != "N" && bucket.mImageURl.count > 0) {
           handleMessage(what: DOWNLOAD_IMAGE, obj: "")
        }else{
            mIvShareImage.image = UIImage(named: "nophoto")
        }
    
    mBtShareDate.setTitle(mBucket.mDate, for: UIControl.State.normal)
        mBtShareDate.tintColor = .black
        mEtShareContent.text = mBucket.mContent
    
    
    }

    func onHttpReceive(type: Int, actionId: Int, data: Data) {
        KLog.d(tag : TAG, msg : "@@ onHttpReceive actionId: " + String(actionId))
        KLog.d(tag : TAG, msg : "@@ onHttpReceive  type: " + String(type))
    
        var isValid : Bool  = false
        print(data)
        do {
            if let jsonString = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] {
                if jsonString.count > 0 {
                    isValid = jsonString["isValid"] as! Bool
                    print(jsonString)
                }
            }
        } catch {
            print("JSON 파상 에러")
        }
        
        if (actionId == ConstHTTP.COMMENT_LIST)
        {
            //  KProgressDialog.setDataLoadingDialog(this, false, null, false);
           if (type == ConstHTTP.HTTP_OK && isValid == true) {
                do {
                      if let jsonString = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        let List : NSArray = jsonString["CommentVOList"] as! NSArray
                        mCommentList.removeAll()
                        if(List.count > 0){
                            for index in 0...List.count-1  {
                                let aObject = List[index] as! [String : AnyObject]
                                let comment : Comment = Comment()
                                comment.mNickName = aObject["nickName"] as! String
                                comment.mDate = aObject["createDt"] as! String
                                comment.mContent = aObject["content"] as! String
                                comment.mIdx = aObject["idx"] as! Int
                                comment.mBucketNo = aObject["bucketNo"] as! Int
                                
                                mCommentList.append(comment)
                            }
                        }
                    }
                    handleMessage(what: SET_COMMENT_LIST, obj: "")
                } catch {
                    KLog.d(tag : TAG, msg : "@@ Exception ")
                    handleMessage(what: SERVER_LOADING_FAIL, obj: "")
                }
           } else {
                 handleMessage(what: SERVER_LOADING_FAIL, obj: "")
           }
        }else if(actionId == ConstHTTP.INSERT_COMMENT){
          if (type == ConstHTTP.HTTP_OK){
            handleMessage(what: LOAD_COMMENT_LIST, obj: "")
          }else{
            handleMessage(what: SERVER_LOADING_FAIL, obj: "")
          }
        }
    }

        @IBAction func onClick(_ sender: Any) {
            switch(sender  as! UIButton ){
            case btSend:
                let text = etComment.text!.replace(target: " ", withString: "")
                if (text.count > 0){
                    //    //             KProgressDialog.setDataLoadingDialog(this, true, this.getString(R.string.loading_string), true);
                    
                    let url : String = ContextUtils.INSERT_COMMENT_URL
                    let httpUrlTaskManager : HttpUrlTaskManager = HttpUrlTaskManager(url : url, post : true, receive : self,
                        id: ConstHTTP.INSERT_COMMENT)
                    let sender : [String: String] = [
                        "NICKNAME" : String(mUserNickname),
                        "CONTENT" : String(text),
                        "BUCKET_NO" : String(idx)
                    ]
                    let data : String = StringUtils.getHTTPPostSendData(sendData : sender)
                    httpUrlTaskManager.actionTaskWithData(data : data)
                    etComment.text = ""
                }
                break

//    //         case R.id.share_contents_imageview:
//    //             if (mDetailImageFileName != null) {
//    //                 ImagePopup popup = new ImagePopup(this, R.layout.popup_img, mDetailImageFileName, getWindow());
//    //                 popup.showDialog();
//    //             }
//    //             break;
//    //         case R.id.share_add:
//    //             String title = getString(R.string.share_add_popup_title);
//    //             String content = getString(R.string.share_add_popup_content);
//    //             mConfirmPopup = new ConfirmPopup(this, title, content, R.layout.popup_confirm, this, OnPopupEventListener.POPUP_BUCKET_ADD);
//    //             mConfirmPopup.showDialog();
//    //             break;
            default:
                break;
            }
        }

    func finish(){
        KLog.d(tag: TAG, msg: "finish")
        let uvc = self.storyboard?.instantiateViewController(withIdentifier: ContextUtils.MAIN_VIEW)
        uvc?.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal //페이지 전환시 에니메이션 효과 설정
        present(uvc!, animated: true, completion: nil)
    }

    func handleMessage(what : Int, obj : String) {
            switch (what) {
                case TOAST_MASSEGE:
                    Toast.showToast(message: obj)
                    break;
                case DOWNLOAD_IMAGE:
                    let url = URL(string: ContextUtils.KBUCKET_DOWNLOAD_IAMGE + "?idx=" + idx)
                    let data = try? Data(contentsOf: url!)
                    mIvShareImage.image = UIImage(data : data!)
                    break;
                case LOAD_COMMENT_LIST:
                    let url : String = ContextUtils.KBUCKET_COMMENT_URL
                    //KProgressDialog.setDataLoadingDialog(this, true, this.getString(R.string.loading_string));
                    let httpUrlTaskManager : HttpUrlTaskManager = HttpUrlTaskManager(url : url, post : true, receive : self,
                                                                                     id: ConstHTTP.COMMENT_LIST);
                    let sender : [String: String] = ["idx" : String(idx) ]
                    let data : String = StringUtils.getHTTPPostSendData(sendData : sender)
                    httpUrlTaskManager.actionTaskWithData(data : data)
                    break;
                case SET_COMMENT_LIST:
                    DispatchQueue.main.async {
                        self.mTableView.reloadData()
                    }
                    break;
                case SERVER_LOADING_FAIL:
                    let message = AppUtils.localizedString(forKey : "server_fail_string")
                    handleMessage(what: TOAST_MASSEGE, obj: message)
                    finish()
                    break;
            default:
                break;
        }
    }
            

   // @Override
   // public void onPopupAction(int popId, int what, Object obj) {
   //     if (popId == OnPopupEventListener.POPUP_BUCKET_ADD) {
   //         if (what == POPUP_BTN_OK) {
   //             String contents = ((TextView) findViewById(R.id.share_contents_textview)).getText().toString();
   //             boolean inContainsBucket = mSqlQuery.containsKbucket(getApplicationContext(), contents);
   //             if (!inContainsBucket) {
   //                 Date dateTime = new Date();
   //                 String date = DateUtils.getStringDateFormat(DateUtils.DATE_YYMMDD_PATTER, dateTime);
   //                 mSqlQuery.insertUserSetting(getApplicationContext(), contents, date, "N", "");
   //                 realmMgr.insertPostData(new PostData(contents, date));

   //                 mConfirmPopup.closeDialog();

   //                 String message = getString(R.string.share_add_popup_ok);
   //                 mHandler.sendMessage(mHandler.obtainMessage(TOAST_MASSEGE, message));
   //             } else {
   //                 String message = getString(R.string.check_input_bucket_string);
   //                 mHandler.sendMessage(mHandler.obtainMessage(TOAST_MASSEGE, message));
   //             }
   //         } else {
   //             mConfirmPopup.closeDialog();
   //         }
   //     }
   // }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        KLog.d(tag: TAG, msg: "@@ mCommentList count: \(mCommentList.count)")
        return mCommentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = mTableView.dequeueReusableCell(withIdentifier: "ShareCommentCell", for: indexPath) as! ShareCommentCell
        
        cell.tvContent.text = mCommentList[indexPath.row].mContent
        let nickname : String = mCommentList[indexPath.row].mNickName
        cell.btName.setTitle( nickname  , for: .normal)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        KLog.d(tag: TAG, msg: "@@ row: \(indexPath.row)")
    }
}
