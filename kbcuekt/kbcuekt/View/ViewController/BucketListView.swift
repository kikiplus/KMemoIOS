//
//  BucketListView.swift
//  완료 가지 리스트 목록
//
//  Created by grapegirl on 2017. 9. 01..
//  Copyright © 2017년 kikiplus. All rights reserved.
//

import UIKit
import RealmSwift

class BucketListView: UIViewController , IHttpReceive ,  UITableViewDelegate, UITableViewDataSource , EventProtocol {

    private let TAG : String = "BucketListView"

    private let TOAST_MASSEGE : Int                = 10
    private let UPLOAD_IMAGE : Int                 = 20
    private let UPLOAD_BUCKET : Int                = 30
    private let SELECT_BUCKET_CATEGORY : Int       = 40

    private var mDataList = Array<PostData>()
    private var mSqlQuery  : SQLQuery? = nil

    private var mShareIdx : Int = -1
    private var mImageIdx : Int = -1
    private var mCategory : Int = 1

    @IBOutlet weak var mTableView: UITableView!
    @IBOutlet weak var btBack: UIButton!
    let mBackColor : String = UserDefault.read(key: ContextUtils.BACK_MEMO)
    // private CardViewListAdpater mListAdapter = null;
    // private ConfirmPopup mConfirmPopup = null;
    // private SpinnerListPopup mCategoryPopup = null;

    override func viewDidLoad() {
        super.viewDidLoad()
        KLog.d(tag: TAG, msg: "viewDidLoad")
        initialize()
    }
    
    func initialize(){
        mSqlQuery = SQLQuery()
        setListData()
        mTableView.delegate = self
        mTableView.dataSource = self
        setBackgroundColor()
        AppUtils.sendTrackerScreen(screen: "완료가지화면")
    }

    private func setBackgroundColor() {
        if mBackColor.count > 0 {
            let uColor = UIColor(hexRGB: mBackColor)
            view.backgroundColor = uColor
            mTableView.backgroundColor = uColor
        }
    }
    
    func finish(){
            KLog.d(tag: TAG, msg: "finish")
            //deleteImageResource()
            let uvc = self.storyboard?.instantiateViewController(withIdentifier: ContextUtils.MAIN_VIEW)
            uvc?.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal //페이지 전환시 에니메이션 효과 설정
            present(uvc!, animated: true, completion: nil)
    }
   
    /**
     * DB 데이타 불러와서 데이타 표시하기
     */
    private func setListData() {
         if(mSqlQuery != nil){
            var bucketList : Results<Bucket>? = nil

            bucketList = mSqlQuery?.selectKbucket()

            let strCount = String(describing: bucketList?.count)
            KLog.d(tag: TAG, msg: "realm DB count : " + strCount)
            for kbucket in bucketList!
            {
                KLog.d(tag: TAG, msg: "realm DB mContent : " + kbucket.mContent)
                KLog.d(tag: TAG, msg: "realm DB mCompleteYN : " + kbucket.mCompleteYN)
                KLog.d(tag: TAG, msg: "realm DB mImage : " + kbucket.mImageURl)
                KLog.d(tag: TAG, msg: "realm DB date : " + kbucket.mDate)
                
                if  (kbucket.mCompleteYN != "Y") {
                    continue
                }
                let postData = PostData(contents : kbucket.mContent, complete : kbucket.mCompleteYN)
                postData.setImage(imagePath: kbucket.mImageURl)
                postData.setDate(date: kbucket.mDate)
                KLog.d(tag: TAG, msg: "realm DB postData : " + postData.description)
                mDataList.append(postData)
            }
        }
    }

   @IBAction func onClick(_ sender: Any) {

        switch(sender  as! UIButton ){
//            let index = 0
//            let uvc = self.storyboard?.instantiateViewController(withIdentifier: "WriteDetailView")
//            uvc?.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal //페이지 전환시 에니메이션 효과 설정
//            uvc?.CONTENTS = mDataList[index].mContent
//            uvc?.BACK = ContextUtils.VIEW_COMPLETE_LIST
//            present(uvc!, animated: true, completion: nil)
//
//            finish()
        case btBack:
            KLog.d(tag: TAG, msg: "onBackPressed")
            ViewUtils.changeView(strView: ContextUtils.MAIN_VIEW, viewCtrl: self)
            break;
        default:
            break;
        }

    }

    // @Override
    // public boolean onLongClick(View v) {
    //     mShareIdx = v.getId();
    //     String memo = mDataList.get(mShareIdx).getContents();

    //     String title = getString(R.string.share_popup_title);
    //     String content = getString(R.string.share_popup_content);
    //     mConfirmPopup = new ConfirmPopup(this, title, ": " + memo + "\n\n " + content, R.layout.popup_confirm, this, OnPopupEventListener.POPUP_BUCKET_SHARE);
    //     mConfirmPopup.showDialog();
    //     return true;
    // }

    // @Override
    // public void onPopupAction(int popId, int what, Object obj) {
    //     if (popId == OnPopupEventListener.POPUP_BUCKET_SHARE) {
    //         if (what == POPUP_BTN_OK) {
    //             mHandler.sendEmptyMessage(SELECT_BUCKET_CATEGORY);
    //         }
    //         mConfirmPopup.closeDialog();
    //     } else if (popId == OnPopupEventListener.POPUP_BUCKET_CATEGORY) {
    //         if (what == POPUP_BTN_OK) {
    //             JSONObject json = (JSONObject) obj;
    //             try {
    //                 mCategory = Integer.valueOf(json.getString("styleCode"));
    //             } catch (JSONException e) {
    //                 mCategory = 1;
    //             }
    //             Log.d(TAG, "@@ mCategory : " + mCategory);
    //             mHandler.sendEmptyMessage(UPLOAD_BUCKET);
    //         }
    //         mCategoryPopup.closeDialog();
    //     }
    // }

   func onHttpReceive(type: Int, actionId: Int, data: Data) {
        KLog.d(tag : TAG, msg : "@@ onHttpReceive actionId: " + String(actionId))
        KLog.d(tag : TAG, msg : "@@ onHttpReceive  type: " + String(type))
        var isValid : Bool  = false

         if (actionId == ConstHTTP.INSERT_BUCKET) {
            if (type == ConstHTTP.HTTP_FAIL) {
                let message = AppUtils.localizedString(forKey : "write_bucekt_fail_string")
                handleMessage(what: TOAST_MASSEGE, obj: message)
            } else {
                do {
                    if let jsonString = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        isValid = jsonString["isValid"] as! Bool
                        mImageIdx = jsonString["idx"] as! Int
                    }

                    if (isValid == true) {
                        // 이미지가 있는 경우 전송함
                        if (mDataList[mShareIdx].mImageName.count > 0) {
                            handleMessage(what: UPLOAD_IMAGE, obj: "")
                        } else {
                            let message = AppUtils.localizedString(forKey : "write_bucekt_success_string")
                            handleMessage(what: TOAST_MASSEGE, obj: message)
                        }
                    }
                } catch  {
                        KLog.d(tag : TAG, msg : "@@ jsonException message ");
                        //handleMessage(what: SERVER_LOADING_FAIL, obj: "")
                }
            }
        }// 이미지 업로드 결과
        else if (actionId == ConstHTTP.INSERT_IMAGE) {
            if (type == ConstHTTP.HTTP_FAIL) {
                let message = AppUtils.localizedString(forKey : "upload_image_fail_string")
                handleMessage(what: TOAST_MASSEGE, obj: message)
            } else {
                let message = AppUtils.localizedString(forKey : "write_bucekt_success_string")
                handleMessage(what: TOAST_MASSEGE, obj: message)
            }
        }
    }

    // /**
    //  * 서버로 전송할 데이타 만들기
    //  *
    //  * @return 전송 데이타
    //  */
    // private HashMap<String, Object> shareBucket() {
    //     Bucket bucket = new Bucket();
    //     bucket.setCategoryCode(1);
    //     String userNickName = (String) SharedPreferenceUtils.read(this, ContextUtils.KEY_USER_NICKNAME, SharedPreferenceUtils.SHARED_PREF_VALUE_STRING);
    //     bucket.setNickName(userNickName);
    //     bucket.setContent(mDataList.get(mShareIdx).getContents());
    //     bucket.setImageUrl("");
    //     bucket.setDate(mDataList.get(mShareIdx).getDate());
    //     return bucket.toHasnMap();
    // }

    // /**
    //  * 서버로 전송할 데이타 만들기
    //  *
    //  * @return 전송 데이타
    //  */
    // private HashMap<String, Object> shareBucketImage() {
    //     Bucket bucket = new Bucket();
    //     String userNickName = (String) SharedPreferenceUtils.read(this, ContextUtils.KEY_USER_NICKNAME, SharedPreferenceUtils.SHARED_PREF_VALUE_STRING);
    //     bucket.setNickName(userNickName);
    //     bucket.setContent(mDataList.get(mShareIdx).getContents());
    //     bucket.setImageUrl("");
    //     bucket.setDate(mDataList.get(mShareIdx).getDate());
    //     bucket.setCategoryCode(mCategory);
    //     return bucket.toHasnMap();
    // }

    func handleMessage(what : Int, obj : String) {

//        switch (what) {
//            case TOAST_MASSEGE:
//                Toast.showToast(message: obj)
//                break;
//            case UPLOAD_IMAGE:
//    //             String photoPath = mDataList.get(mShareIdx).getImageName();
//    //             KLog.d(TAG, "@@ UPLOAD IMAGE 전송 시작 !");
//    //             if (photoPath != null && !photoPath.equals("")) {
//    //                 Bitmap bitmap = ByteUtils.getFileBitmap(photoPath);
//    //                 Calendar calendar = Calendar.getInstance();
//    //                 SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd_hhmmss");
//    //                 String fileName = sdf.format(calendar.getTime());
//
//    //                 byte[] bytes = ByteUtils.getByteArrayFromBitmap(bitmap);
//    //                 HttpUrlFileUploadManager httpUrlFileUploadManager = new HttpUrlFileUploadManager(ContextUtils.KBUCKET_UPLOAD_IMAGE_URL, this, IHttpReceive.INSERT_IMAGE, bytes);
//    //                 httpUrlFileUploadManager.execute(photoPath, "idx", mImageIdx + "", fileName + ".jpg");
//    //             } else {
//    //                 KLog.d(TAG, "@@ UPLOAD IMAGE NO !");
//    //             }
//                break;
//            case UPLOAD_BUCKET:
//                let url  = ContextUtils.KBUCKET_INSERT_BUCKET_URL
//                let  httpUrlTaskManager : HttpUrlTaskManager =  HttpUrlTaskManager(url : url, post : true, receive : self, id : ConstHTTP.INSERT_BUCKET);
//                httpUrlTaskManager.actionTask()
//                break;
//            case SELECT_BUCKET_CATEGORY:
//                let title = AppUtils.localizedString(forKey : "category_popup_title")
//                let content = AppUtils.localizedString(forKey : "category_popup_content")
//
//                var list = Array<Category>()
//                list.append(Category(name : "LIEF", code: 1))
//                list.append(Category(name : "LOVE", code : 2))
//                list.append(Category(name : "WORK", code : 3))
//                list.append(Category(name : "EDUCATION", code : 4))
//                list.append(Category(name : "FAMILY", code : 5))
//                list.append(Category(name : "FINANCE", code : 6))
//                list.append(Category(name : "DEVELOP", code : 7))
//                list.append(Category(name : "HEALTH", code : 8))
//                list.append(Category(name : "ETC", code : 9))
//    
//    //           mCategoryPopup = new SpinnerListPopup(this, title, "", list, R.layout.popupview_spinner_list, this, OnPopupEventListener.POPUP_BUCKET_CATEGORY);
//    //           mCategoryPopup.showDialog();
//                break;
//        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         KLog.d(tag: TAG, msg: "@@ tableView count : " + String(mDataList.count))
        return mDataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mTableView.dequeueReusableCell(withIdentifier: "BucketCustomCell", for: indexPath) as! BucketCustomCell
        
        let postData = mDataList[indexPath.row]
        KLog.d(tag: ContextUtils.TAG, msg: "@@ date : " + postData.m_date)
        cell.mBtDate.setTitle(postData.m_date, for: UIControl.State.normal)
        cell.mBtDate.tintColor = .black
        
        cell.mEtContent.text = postData.m_contents
        cell.mBtDate.setTitle(postData.m_date, for: UIControl.State.normal)
        cell.mData = String(indexPath.row)
        
        if(postData.mImageName.count > 0){
            let image = DataUtils.load(fileName: postData.mImageName)
            cell.ivImage.image = image
        }
        cell.selectionStyle = .none
        if mBackColor.count > 0 {
            let uColor = UIColor(hexRGB: mBackColor)
            cell.backgroundColor = uColor
        }
        cell.setOnEventListener(listener: self)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        KLog.d(tag: TAG, msg: "row: \(indexPath.row)")
        changeDetailView(index: indexPath.row)
    }

    func receiveEventFromViewItem(gbn : Int, data : String) {
        KLog.d(tag: TAG, msg: "receiveEventFromViewItem data : " + data)
        switch(gbn){
        case 0://상세 화면 이동
            let index:Int! = Int(data)
            changeDetailView(index: index)
            break;
        default:
            break;
        }
    }
    
    private func changeDetailView(index : Int){
        KLog.d(tag: TAG, msg: "changeDetailView");
        let uvc = self.storyboard?.instantiateViewController(withIdentifier: "WriteDetailView") as! WriteDetailView
        uvc.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal //페이지 전환시 에니메이션 효과 설정
        uvc.CONTENTS = mDataList[index].getContent()
        uvc.BACK = ContextUtils.VIEW_COMPLETE_LIST
        present(uvc, animated: true, completion: nil)
    }
}
