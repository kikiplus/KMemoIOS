//
//  ViewController.swift
//  kbucket
//
//  Created by 김미혜 on 2017. 6. 16..
//  Copyright © 2017년 kikiplus. All rights reserved.
//

import UIKit
import GoogleMobileAds

class ViewController: UIViewController , IHttpReceive , PopupProtocol {
   
    private let TAG : String = "ViewController"

    @IBOutlet weak var btWrite: UIButton!
    @IBOutlet weak var btComplete: UIButton!
    @IBOutlet weak var btShare: UIButton!
    @IBOutlet weak var btRank: UIButton!
    @IBOutlet weak var btSetting: UIButton!
    @IBOutlet weak var btAI: UIButton!
    @IBOutlet weak var btNotice: UIButton!
    @IBOutlet var backView: UIView!
    
    private let TOAST_MASSEGE : Int         = 0
    private let SHARE_THE_WORLD : Int       = 40
    private let UPDATE_USER : Int           = 60
    private let REQUEST_AI : Int            = 70
    private let FAIL_AI : Int               = 71
    private let RESPOND_AI : Int            = 72
    private let CHECK_VERSION : Int         = 80
  
    private var mSqlQuery  : SQLQuery? = nil
    private var bannerView: GADBannerView!
    public var mWidgetSendData : String = ""
    private var mAIPopup : CustomPopup?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        KLog.d(tag: "ViewController", msg: "viewDidLoad")
        initialize()
    }

    func initialize(){
        mSqlQuery = SQLQuery()
         setBackgroundColor()
 
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        addBannerViewToView(bannerView)
        bannerView.adUnitID = ContextUtils.KBUCKET_AD_UNIT_ID
        bannerView.rootViewController = self
        bannerView.load(GADRequest())

        let isConnect : Bool = NetworkUtils.isConnectivityStatus()
                        if (isConnect == true) {
            handleMessage(what: CHECK_VERSION, obj: "")
        }
        AppUtils.sendTrackerScreen(screen: "메인화면")
    }

    private func setBackgroundColor() {
        let color : String = UserDefault.read(key: ContextUtils.BACK_MEMO)
        KLog.d(tag: TAG, msg: "color : " + color)
        if (color.count > 0) {
            let uColor = UIColor(hexRGB: color)
            view.backgroundColor = uColor
        }else{
            UserDefault.write(key: ContextUtils.BACK_MEMO, value: "#FFE452")
            let uColor = UIColor(hexRGB: "#FFE452")
            view.backgroundColor = uColor
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
         KLog.d(tag: "ViewController", msg: "viewWillAppear");
    }
    
    override func viewDidAppear(_ animated: Bool) {
        KLog.d(tag: "ViewController", msg: "viewDidAppear");
        let nickname = UserDefault.read(key:ContextUtils.KEY_USER_NICKNAME)
        KLog.d(tag: TAG, msg: "nickname : " + nickname)
        if(nickname.count == 0 ){
            let  uv  =  self.storyboard?.instantiateViewController(withIdentifier: ContextUtils.SET_NICKNAME_VIEW)
            UIApplication.shared.delegate?.window!!.rootViewController?.present(uv!, animated: true, completion: nil)
        }else{
            let isConnect : Bool = NetworkUtils.isConnectivityStatus()
            if (isConnect == true) {
                handleMessage(what: UPDATE_USER, obj: "")
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        KLog.d(tag: "ViewController", msg: "viewWillDisappear");
    }
    
    override func viewDidDisappear(_ animated: Bool) {
         KLog.d(tag: "ViewController", msg: "viewDidDisappear");
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        KLog.d(tag: "ViewController", msg: "didReceiveMemoryWarning");
    }

    @IBAction func onClick(_ sender: UIButton) {
        switch sender {
        case btWrite:
            changeView(viewName: "WriteView")
            break
        case btComplete:
            changeView(viewName: "BucketListView")
            break
        case btShare:
            changeView(viewName: "ShareListView")
            break
        case btRank:
            KLog.d(tag: "ViewController", msg: "onClickRank");
            changeView(viewName: "RankListView")
            break
        case btSetting:
            changeView(viewName: "SettingView")
            break
        case btAI:
            KLog.d(tag: "ViewController", msg: "onClickAI");
            handleMessage(what: REQUEST_AI, obj: "")
            break
        case btNotice:
            changeView(viewName: "NoticeView")
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

    func handleMessage(what : Int, obj : String) {
        
        switch (what) {
            case TOAST_MASSEGE:
                DispatchQueue.main.async {
                    Toast.showToast(message: obj)
                }
                break
            case SHARE_THE_WORLD://공유화면 보여주기
                changeView(viewName: "ShareListViewCtlr")
                break
            case UPDATE_USER://사용자 정보 없데이트
                let userUpdateTask : UserUpdateTask = UserUpdateTask(url: ContextUtils.KBUCKET_UPDATE_USER, post: true, receive: self)
                let user = getUserData()
                let sendData = StringUtils.getHTTPPostSendData(sendData: user.toDictionary() )
                userUpdateTask.actionTaskWithData(data : sendData )
                break
            case REQUEST_AI:
                 let isConnect : Bool = NetworkUtils.isConnectivityStatus()
                if (isConnect == true) {
                    let userNickName : String = UserDefault.read(key: ContextUtils.KEY_USER_NICKNAME)
                    let url  = ContextUtils.KBUCKET_AI
                    let  httpUrlTaskManager : HttpUrlTaskManager =  HttpUrlTaskManager(url : url, post : true, receive : self, id : ConstHTTP.REQUEST_AI)
                    let data : String = "nickname=" + userNickName
                    httpUrlTaskManager.actionTaskWithData(data: data)
                }else{
                    let connectMsg = AppUtils.localizedString(forKey :"check_network")
                    handleMessage(what: TOAST_MASSEGE, obj: connectMsg)
                }
                break
            case FAIL_AI:
//    //             KProgressDialog.setDataLoadingDialog(this, false, null, false);
//    //             String title = getString(R.string.popup_title);
//    //             String content = getString(R.string.popup_prepare_string);
//    //             mBasicPopup = new BasicPopup(this, title, content, R.layout.popup_basic, this, OnPopupEventListener.POPUP_BASIC);
//    //             mBasicPopup.showDialog();
                break
            case RESPOND_AI:// AI 대답
//    //             KProgressDialog.setDataLoadingDialog(this, false, null, false);
                DispatchQueue.main.async {
                    self.mAIPopup = CustomPopup(listener: self)
                    self.mAIPopup?.showDialog(message: obj, id: ConstPopup.POPUP_AI)
                    }
                break
            case CHECK_VERSION://버전 체크
                let url  = ContextUtils.KBUCKET_VERSION_UPDATE_URL
                let  httpUrlTaskManager : HttpUrlTaskManager =  HttpUrlTaskManager(url : url, post : true, receive : self, id : ConstHTTP.UPDATE_VERSION)
                let data : String = "version=" + ContextUtils.VERSION_NAME
                httpUrlTaskManager.actionTaskWithData(data: data)
                break
        default:
            break
        }
    }

    
    func onHttpReceive(type: Int, actionId: Int, data: Data) {
        KLog.d(tag : TAG, msg : "@@ onHttpReceive actionId: " + String(actionId))
        KLog.d(tag : TAG, msg : "@@ onHttpReceive  type: " + String(type))
        if (actionId == ConstHTTP.REQUEST_AI) {
            if (type == ConstHTTP.HTTP_OK) {
                do {
                        if let jsonString = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] {
                            let message = jsonString["replay"] as! String
                            handleMessage(what: RESPOND_AI, obj: message)
                    }
                } catch {
                    print("JSON 파상 에러")
                     handleMessage(what: FAIL_AI, obj: "")
                }
               
            } else {
                handleMessage(what: FAIL_AI, obj: "")
            }
        } else if (actionId == ConstHTTP.UPLOAD_DB) {
            if (type == ConstHTTP.HTTP_OK) {
                handleMessage(what: TOAST_MASSEGE, obj: "메모가지 서버에 DB를 업로드하였습니다\nDB 파일이 필요하시면 문의해주세요")
             } else {
                handleMessage(what: TOAST_MASSEGE, obj: "메모가지 서버에 DB를 업로드하는데 실패하였습니다")
             }
        } else if (actionId == ConstHTTP.UPDATE_VERSION){
            if (type == ConstHTTP.HTTP_OK) {
                do {
                    if let jsonString = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] {
                        
                        if jsonString.count > 0 {
                            let versionName = jsonString["versionName"] as! String
                            let forceYN =  jsonString["forceYN"] as! String
                           
                            if (versionName.count > 0 ) {
                                if (StringUtils.compareVersion(srcVersion: ContextUtils.VERSION_NAME, newVersion: versionName) > 0) {
                                    print("0")
                                    if (forceYN == "Y") {
                                        let title = AppUtils.localizedString(forKey : "update_popup_title")
                                        let content = AppUtils.localizedString(forKey : "update_popup_content_y")
                                        
                                        let basicPopup = BasicPopup()
                                        basicPopup.showMessage(title: title, content: content, vc: self, id: ConstPopup.POPUP_UPDATE_FORCE)
                                    } else {
                                        let title = AppUtils.localizedString(forKey : "update_popup_title")
                                        let content = AppUtils.localizedString(forKey : "update_popup_content_n")
                                        
                                        let confirmPopup = ConfirmPopup()
                                        confirmPopup.showMessage(title: title, content: content, vc: self, id : ConstPopup.POPUP_UPDATE_SELECT)
                                      
                                    }
                                } else {
                                    let message = AppUtils.localizedString(forKey : "check_version_lasted")
                                    handleMessage(what: TOAST_MASSEGE, obj: message)
                                }
                            }
                        }
                    }
                } catch {
                    print("JSON 파상 에러")
                    handleMessage(what: FAIL_AI, obj: "")
                }
            }else{
                
            }
        }
    }
    
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
            [NSLayoutConstraint(item: bannerView,
                                attribute: .bottom,
                                relatedBy: .equal,
                                toItem: bottomLayoutGuide,
                                attribute: .top,
                                multiplier: 0.9,
                                constant: 0),
             NSLayoutConstraint(item: bannerView,
                                attribute: .centerX,
                                relatedBy: .equal,
                                toItem: view,
                                attribute: .centerX,
                                multiplier: 1,
                                constant: 0)
            ])
    }

    /**
     * 사용자 정보업데이트 가공 데이타 만드는 메소드
     *
     * @return 사용자 정보
     */
    private func getUserData() -> MobileUser {
        let mobileUser = MobileUser()
        mobileUser.mUserNickName = UserDefault.read(key: ContextUtils.KEY_USER_NICKNAME)
        mobileUser.mVersionName = ContextUtils.VERSION_NAME
        mobileUser.mLanguage = AppUtils.getUserPhoneLanuage()
        mobileUser.mCountry = AppUtils.getUserPhoneLanuage()
        mobileUser.mGcmToken = UserDefault.read(key: ContextUtils.KEY_USER_FCM)
        return mobileUser;
    }
    
    func onPopupAction(popId: Int, what: Int, data: String) {
        KLog.d(tag: TAG, msg: "@@ onPopupAction popId : " + String(popId))
        KLog.d(tag: TAG, msg: "@@ onPopupAction what : " + String(what))
       // mAIPopup?.closePopup()
    }
}

