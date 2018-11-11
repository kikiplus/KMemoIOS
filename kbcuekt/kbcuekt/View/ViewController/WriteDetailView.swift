//
//  WriteDetailView.swift
//  버킷 상세 클래스
//
//  Created by grapegirl on 2017. 9. 01..
//  Copyright © 2017년 kikiplus. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation
import RealmSwift

class WriteDetailView: UIViewController , IHttpReceive, AVCapturePhotoCaptureDelegate , UIImagePickerControllerDelegate,
UIPopoverControllerDelegate,UINavigationControllerDelegate {
    
    private let TAG : String = "WriteDetailView"
    private var mContents : String = ""
    private var mDate : String = ""
    private var mDeadLineDate : String = ""
    private var mPhotoPath : String = ""
    public var CONTENTS  = String()
    public var BACK  = String()
    
    private var mImageIdx : Int = -1
    private var mCategory : Int = 1
    
    private let TOAST_MASSEGE : Int = 10
    private let UPLOAD_IMAGE : Int = 20
    private let UPLOAD_BUCKET : Int = 30
    private let SELECT_BUCKET_CATEGORY : Int = 40
    
    /*카메라 호출 리턴값*/
    private let REQ_CODE_PICKCUTRE : Int = 1000
    /*갤러리 호출 리턴값*/
    private let REQ_CODE_GALLERY : Int = 1001
    
    @IBOutlet weak var btShare: UIButton!
    @IBOutlet weak var btSave: UIButton!
    @IBOutlet weak var btDel: UIButton!
    @IBOutlet weak var ckComplete: UISwitch!
    @IBOutlet weak var btGallery: UIButton!
    @IBOutlet weak var btCamera: UIButton!
    
    @IBOutlet weak var btCheckbox: UISwitch!
    private var mSqlQuery  : SQLQuery? = nil
    
    @IBOutlet weak var etDate: UITextField!
    @IBOutlet weak var etContent: UITextField!
    @IBOutlet weak var etCompleteDate: UITextField!
    
    @IBOutlet weak var ivImage: UIImageView!
    @IBOutlet weak var btRemoveImage: UIButton!
    // private ConfirmPopup mConfirmPopup = null;
    // private SpinnerListPopup mCategoryPopup = null;
    
    var picker:UIImagePickerController? = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        KLog.d(tag: TAG, msg: "viewDidLoad");
        KLog.d(tag: TAG, msg: "viewDidLoad CONTENTS : "  + CONTENTS);
        KLog.d(tag: TAG, msg: "viewDidLoad BACK : "  + BACK);
        mContents = CONTENTS
        initialize()
    }
    
    func initialize(){
        KLog.d(tag: TAG, msg: "initialize");
        mSqlQuery = SQLQuery()
        setData()
        picker?.delegate = self
        AppUtils.sendTrackerScreen(screen: "가지상세화면");
    }
    
    /**
     * 이미지 첨부 버튼 보이게 하기/숨기기 메소드
     *
     * @param ishide 숨기기 여부 (true - 숨기기)
     */
    private func hideImageAttachButton(ishide : Bool) {
        if (ishide) {
            btCamera.isHidden = true
            btGallery.isHidden = true
            btRemoveImage.isHidden = false
            ivImage.isHidden = false
        } else {
            btCamera.isHidden = false
            btGallery.isHidden = false
            btRemoveImage.isHidden = true
            ivImage.isHidden = true
        }
    }
    
    /**
     * DB 데이타 불러와서 데이타 표시하기
     */
    private func setData() {
        if(mSqlQuery != nil){
            var bucketList : Results<Bucket>? = nil
            bucketList = mSqlQuery?.selectKbucket(memoContents: mContents)
            let strCount = String(describing: bucketList?.count)
            KLog.d(tag: TAG, msg: "realm DB count : " + strCount)
            for kbucket in bucketList! {
                KLog.d(tag: TAG, msg: "realm DB mContent : " + kbucket.mContent)
                KLog.d(tag: TAG, msg: "realm DB mCompleteDate : " + kbucket.mCompleteDate)
                KLog.d(tag: TAG, msg: "realm DB mCompleteYN : " + kbucket.mCompleteYN)
                KLog.d(tag: TAG, msg: "realm DB mImageURl : " + kbucket.mImageURl)
                
                if(kbucket.mCompleteYN == "Y"){
                    btCheckbox.isOn = true
                }else{
                    btCheckbox.isOn = false
                }
                
                if(kbucket.mImageURl.count > 0 ){
                    hideImageAttachButton(ishide: true)
                    mPhotoPath = kbucket.mImageURl
                    let image = DataUtils.load(fileName: mPhotoPath)
                    ivImage.image = image
                }else{
                    hideImageAttachButton(ishide: false)
                }
                etContent.text = kbucket.mContent
                
                if(kbucket.mDate.count > 0){
                    etDate.text = kbucket.mDate
                }else{
                    let strDate = DateUtils.getStringDateFormat(pattern: "yy-MM-dd")
                    etDate.text = strDate
                }
                if(kbucket.mCompleteDate.count > 0){
                      etCompleteDate.text = kbucket.mCompleteDate
                }else{
                    let strDate = DateUtils.getStringDateFormat(pattern: "yy-MM-dd")
                    etCompleteDate.text = strDate
                }
              
            }
        }
    }
    
    /**
     * DB 데이타 동기화하기
     */
    private func updateDBDate() {
        let NewContents = etContent.text!
        let completeYN = btCheckbox.isOn ? "Y" : "N"
        let imagePath = mPhotoPath.count > 0 ? mPhotoPath : ""
        let date = etDate.text != nil ?  etDate.text! : ""
        let completeDate = etCompleteDate.text != nil ? etCompleteDate.text! : ""
        
        let newBucket : Bucket = Bucket()
        newBucket.mContent = NewContents
        newBucket.mCompleteYN = completeYN
        newBucket.mImageURl = imagePath
        newBucket.mDate = date
        newBucket.mCompleteDate = completeDate
        
        if(mSqlQuery != nil){
            mSqlQuery?.updateMemoContent(newBucket: newBucket, cotents: mContents)
        }
    }
    
    /**
     * DB 데이타 동기화하기(삭제)
     */
    private func removeDBData(Content : String) {
        KLog.d(tag : TAG, msg: "@@ remove Data Contents : " + Content);
        if(mSqlQuery != nil){
            mSqlQuery?.deleteUserBucket(contents: Content)
        }
    }
    
    @IBAction func onBackPressed(_ sender: Any) {
        back(strBack : BACK)
    }
    
    private func back(strBack : String){
        KLog.d(tag: TAG, msg: "back : " + strBack)
        if(BACK == ContextUtils.VIEW_COMPLETE_LIST){
            ViewUtils.changeView(strView: ContextUtils.VIEW_COMPLETE_LIST, viewCtrl: self)
        }else{
            ViewUtils.changeView(strView: ContextUtils.MAIN_VIEW, viewCtrl: self)
        }
    }
    
    @IBAction func onClickEditor(_ sender2: Any){
        switch (sender2  as! UITextField )  {
        case etDate:
            KLog.d(tag: TAG, msg: "onClick etDate")
            let datePickerView : UIDatePicker = UIDatePicker()
            datePickerView.datePickerMode = UIDatePicker.Mode.date
            etDate.inputView = datePickerView
            datePickerView.addTarget(self, action: #selector(datePickerValueChanged),
                                     for: UIControl.Event.valueChanged)
            break;
        case etCompleteDate:
            KLog.d(tag: TAG, msg: "onClick etCompleteDate")
            let datePickerView : UIDatePicker = UIDatePicker()
            datePickerView.datePickerMode = UIDatePicker.Mode.date
            etCompleteDate.inputView = datePickerView
            datePickerView.addTarget(self, action: #selector(datePickerValueChanged2),
                                     for: UIControl.Event.valueChanged)
            break;
        default:
            break;
        }
    }
    @IBAction func onClick(_ sender: Any) {
        switch (sender  as! UIButton )  {
        case btSave:
            KLog.d(tag: TAG, msg: "onClick btSave")
            updateDBDate()
            back(strBack : BACK)
            break;
        case btDel:
            KLog.d(tag: TAG, msg: "onClick btDel")
            let title = AppUtils.localizedString(forKey : "delete_popup_title")
            let content = AppUtils.localizedString(forKey : "delete_popup_content")
            //             mConfirmPopup = new ConfirmPopup(this, title, ": " + mContents + "\n\n " + content, R.layout.popup_confirm, this, OnPopupEventListener.POPUP_BUCKET_DELETE);
            //             mConfirmPopup.showDialog()
            
            removeDBData(Content: mContents)
            back(strBack : BACK)
            break;
        case btShare:
            KLog.d(tag: TAG, msg: "onClick btShare")
            let title = AppUtils.localizedString(forKey : "share_popup_title")
            let content = AppUtils.localizedString(forKey : "share_popup_content")
            //             mConfirmPopup = new ConfirmPopup(this, title, ": " + mContents + "\n\n " + content, R.layout.popup_confirm, this, OnPopupEventListener.POPUP_BUCKET_SHARE);
            //             mConfirmPopup.showDialog();
            handleMessage(what: UPLOAD_BUCKET, obj: "")
            break
        case btCamera:
            KLog.d(tag: TAG, msg: "onClick btCamera")
            //startCamera()
            //             mPhotoPath = DataUtils.getNewFileName();
            //             Intent intent = new Intent(MediaStore.ACTION_IMAGE_CAPTURE);
            //             intent.putExtra(MediaStore.EXTRA_OUTPUT, Uri.fromFile(new File(mPhotoPath)));
            //             startActivityForResult(intent, REQ_CODE_PICKCUTRE);
            break;
        case btGallery:
            KLog.d(tag: TAG, msg: "onClick btGallery")
            openGallary()
            break;
        case btRemoveImage:
            KLog.d(tag: TAG, msg: "onClick btRemoveImage")
            mPhotoPath = ""
            hideImageAttachButton(ishide : false)
            ivImage.isHidden = true
            btRemoveImage.isHidden = true
            break;
        default:
            break;
        }
        
    }
    
    @objc func datePickerValueChanged(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.dateFormat = "yy-MM-dd"
        dateFormatter.timeZone = TimeZone.init(secondsFromGMT: 0)
        KLog.d(tag: TAG, msg: "@@ datePickerValueChanged ")
        etDate.text = dateFormatter.string(from: sender.date)
        etDate.resignFirstResponder()
    }
    @objc func datePickerValueChanged2(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.dateFormat = "YY-MM-dd"
        dateFormatter.timeZone = TimeZone.init(secondsFromGMT: 0)
        KLog.d(tag: TAG, msg: "@@ datePickerValueChanged2")
        etCompleteDate.text = dateFormatter.string(from: sender.date)
        etCompleteDate.resignFirstResponder()
    }
    
    // @Override
    // protected void onActivityResult(int requestCode, int resultCode, Intent data) {
    //     if (requestCode == REQ_CODE_PICKCUTRE) {
    //         if (resultCode == Activity.RESULT_OK) {
    //             Bitmap bm = ByteUtils.getFileBitmap(mPhotoPath);
    //             if (bm != null) {
    //                 hideImageAttachButton(true);
    //                 mImageView.setVisibility(View.VISIBLE);
    //                 mImageView.setScaleType(ImageView.ScaleType.FIT_XY);
    //                 mImageView.setImageBitmap(bm);
    //                 ((Button) findViewById(R.id.write_image_remove)).setVisibility(View.VISIBLE);
    //             }
    //         }
    //     }
    // }
    
    // @Override
    // public void onPopupAction(int popId, int what, Object obj) {
    //     if (popId == OnPopupEventListener.POPUP_BUCKET_SHARE) {
    //         if (what == POPUP_BTN_OK) {
    //             mHandler.sendEmptyMessage(SELECT_BUCKET_CATEGORY);
    //         }
    //         mConfirmPopup.closeDialog();
    //     } else if (popId == OnPopupEventListener.POPUP_BUCKET_DELETE) {
    //         if (what == POPUP_BTN_OK) {
    //             removeDBData(mContents);
    //             onBackPressed();
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
    //             mHandler.sendEmptyMessage(UPLOAD_BUCKET);
    //         }
    //         mCategoryPopup.closeDialog();
    //     }
    // }
    
    func onHttpReceive(type : Int, actionId: Int,  data : Data){
        KLog.d(tag : TAG, msg : "@@ onHttpReceive actionId: " + String(actionId));
        KLog.d(tag : TAG, msg : "@@ onHttpReceive  type: " + String(type));
        
        var isValid : Bool  = false
        
        if (actionId == ConstHTTP.INSERT_BUCKET) {
            if (type == ConstHTTP.HTTP_FAIL) {
                let message = AppUtils.localizedString(forKey : "write_bucekt_fail_string")
                handleMessage(what: TOAST_MASSEGE, obj: message)
            } else {
                if (data != nil) {
                    do {
                        if let jsonString = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                            //mImageIdx = json.getInt("idx")
                        }
                    } catch {
                        KLog.d(tag : TAG, msg : "@@ Exception ")
                    }
                    
                    if (isValid == true) {
                        // 이미지가 있는 경우 전송함
                        if (mPhotoPath != nil && mPhotoPath.count > 0 ) {
                            handleMessage(what: UPLOAD_IMAGE, obj: "")
                        } else {
                            let message = AppUtils.localizedString(forKey : "write_bucekt_success_string")
                            handleMessage(what: TOAST_MASSEGE, obj: message)
                        }
                    }
                }
            }
        }// 이미지 업로드 결과
        else if (actionId == ConstHTTP.INSERT_IMAGE) {
            if (type == ConstHTTP.HTTP_FAIL) {
                let message = AppUtils.localizedString(forKey : "upload_image_fail_string")
                handleMessage(what: TOAST_MASSEGE, obj: message)
            } else {
                if (isValid == true) {
                    let message = AppUtils.localizedString(forKey : "write_bucekt_success_string")
                    handleMessage(what: TOAST_MASSEGE, obj: message)
                }
            }
        }
    }
    
    func handleMessage(what : Int, obj : String) {
        switch (what) {
        case TOAST_MASSEGE:
            Toast.showToast(message: obj)
            break;
        case UPLOAD_IMAGE:
            let photoPath = mPhotoPath
            KLog.d(tag : TAG, msg : "handleMessage UPLOAD_IMAGE photoPath : " + photoPath)
            if(photoPath.count > 0 ){
                let  httpUrlFileUploadManager : HttpUrlFileUploadManager = HttpUrlFileUploadManager(url : ContextUtils.KBUCKET_UPLOAD_IMAGE_URL, post : true, receive : self, id : ConstHTTP.INSERT_IMAGE)
                let fileName : String = DateUtils.getStringDateFormat(pattern: "yyyyMMdd_hhmmss")
                KLog.d(tag : TAG, msg : "handleMessage UPLOAD_IMAGE fileName : " + fileName)
                let imageData = ivImage.image!.pngData()
                KLog.d(tag : TAG, msg : "handleMessage UPLOAD_IMAGE imageData : " )
                httpUrlFileUploadManager.actionTask(filePath : photoPath, setValue: "idx", reqValue : String(mImageIdx), fileName : fileName + ".jpg",
                                                    image : imageData!)
                
            }else{
                KLog.d(tag : TAG, msg : "@@ UPLOAD IMAGE NO !")
            }
            break;
        case UPLOAD_BUCKET:
            let url  = ContextUtils.KBUCKET_INSERT_BUCKET_URL
            let httpUrlTaskManager : HttpUrlTaskManager =  HttpUrlTaskManager(url : url, post : true, receive : self, id : ConstHTTP.INSERT_BUCKET)
            let data = StringUtils.getHTTPPostSendData(sendData : shareBucketImage())
            httpUrlTaskManager.actionTaskWithData(data : data)
            break;
        case SELECT_BUCKET_CATEGORY:
            let title = AppUtils.localizedString(forKey : "category_popup_title")
            let content = AppUtils.localizedString(forKey : "category_popup_content")
            
            var list : Array<Category> = Array()
            list.append(Category(name : "LIEF", code : 1))
            list.append(Category(name : "LOVE", code : 2))
            list.append(Category(name : "WORK", code : 3))
            list.append(Category(name : "EDUCATION", code : 4))
            list.append(Category(name : "FAMILY", code : 5))
            list.append(Category(name : "FINANCE", code : 6))
            list.append(Category(name : "DEVELOP", code : 7))
            list.append(Category(name : "HEALTH", code : 8))
            list.append(Category(name : "ETC", code : 9))
            //             mCategoryPopup = new SpinnerListPopup(this, title, "", list, R.layout.popupview_spinner_list, this, OnPopupEventListener.POPUP_BUCKET_CATEGORY);
            //             mCategoryPopup.showDialog();
            break;
        default:
            break;
        }
    }
//
//    func startCamera(){
//        var captureSesssion: AVCaptureSession!
//        var stillImageOutput: AVCapturePhotoOutput?
//        var previewLayer: AVCaptureVideoPreviewLayer?
//
//        captureSesssion = AVCaptureSession()
//        if #available(iOS 10.0, *) {
//            stillImageOutput = AVCapturePhotoOutput()
//        } else {
//            // Fallback on earlier versions
//        }
//        captureSesssion.sessionPreset = AVCaptureSession.Preset.hd1920x1080 // 해상도설정
//
//        let device = AVCaptureDevice.default(for: AVMediaType.video)
//        do {
//            let input = try AVCaptureDeviceInput(device: device!)
//
//            // 입력
//            if (captureSesssion.canAddInput(input)) {
//                captureSesssion.addInput(input)
//
//                // 출력
//                if (captureSesssion.canAddOutput(stillImageOutput!)) {
//                    captureSesssion.addOutput(stillImageOutput!)
//                    captureSesssion.startRunning() // 카메라 시작
//
//                    previewLayer = AVCaptureVideoPreviewLayer(session: captureSesssion)
//                    previewLayer?.videoGravity = AVLayerVideoGravity.resizeAspect //화면 조절
//                    previewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait // 카메라 방향
//
//                    ivImage.layer.addSublayer(previewLayer!)
//
//                    // 뷰 크기 조절
//                    previewLayer?.position = CGPoint(x: self.ivImage.frame.width / 2, y: self.ivImage.frame.height / 2)
//                    previewLayer?.bounds = self.ivImage.frame
//                }
//            }
//        }
//        catch {
//            print(error)
//        }
//    }
    
//    func photoOutput(_ captureOutput: AVCapturePhotoOutput, didFinishProcessingPhoto photoSampleBuffer: CMSampleBuffer?, previewPhoto previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?) {
//
//        if let photoSampleBuffer = photoSampleBuffer {
//            // JPEG형식으로 이미지데이터 검색
//            let photoData = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: photoSampleBuffer, previewPhotoSampleBuffer: previewPhotoSampleBuffer)
//            let image = UIImage(data: photoData!)
//
//            // 사진보관함에 저장
//            UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
//        }
//    }
    
    func openGallary(){
        if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary)){
            picker!.allowsEditing = false
            picker!.sourceType = UIImagePickerController.SourceType.photoLibrary
            present(picker!, animated: true, completion: nil)
        }else{
            let alert = UIAlertController(title: "Camera Not Found", message: "This device has no Camera", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style:.default, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
       
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
   @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        KLog.d(tag: TAG, msg: "imagePickerController" )
        let chosenImage = info["UIImagePickerControllerOriginalImage"] as! UIImage
        hideImageAttachButton(ishide: true)
        ivImage.image = chosenImage
        ivImage.isHidden = false
        
        let fileName = DateUtils.getStringDateFormat(pattern: "yyyyMMdd_hhmmss")
        let tempImageName  = DataUtils.save(image: chosenImage, fileName: fileName)
        mPhotoPath = tempImageName!.count > 0 ? tempImageName! : ""
        KLog.d(tag: TAG, msg: "imagePickerController mPhotoPath : " + mPhotoPath )
        dismiss(animated: true, completion: nil)
    }
    
    /**
     * 서버로 전송할 데이타 만들기
     *
     * @return 전송 데이타
     */
    private func shareBucketImage() -> [String:String] {
        let bucket = Bucket()
        let userNickName = UserDefault.read(key: ContextUtils.KEY_USER_NICKNAME)
        bucket.mNickName = userNickName
        bucket.mContent = mContents
        bucket.mImageURl = mPhotoPath
        bucket.mCompleteDate = mDate
        bucket.mCategoryCode = 9
        return bucket.toDictionary()
    }
    
}
