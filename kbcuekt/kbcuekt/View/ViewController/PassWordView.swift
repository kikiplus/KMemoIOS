//
//  PassWordView.swift
//  패스워드
//
//  Created by grapegirl on 2018. 8. 26..
//  Copyright © 2017년 kikiplus. All rights reserved.
//

import UIKit

class PassWordView : UIViewController {

    private let TAG : String = "PassWordView"
    private var mPasswordData = Array<String>()
    private var isPasswordset : Bool = false
    public var mSetting : String = ""
    public var mStartView : String = ""
    private var mButton = Array<UIButton>()

    @IBOutlet weak var num0: UIButton!
    @IBOutlet weak var num1: UIButton!
    @IBOutlet weak var num2: UIButton!
    @IBOutlet weak var num3: UIButton!
    @IBOutlet weak var num4: UIButton!
    @IBOutlet weak var num5: UIButton!
    @IBOutlet weak var num6: UIButton!
    @IBOutlet weak var num7: UIButton!
    @IBOutlet weak var num8: UIButton!
    @IBOutlet weak var num9: UIButton!
    
    @IBOutlet weak var btnClear: UIButton!
    @IBOutlet weak var btnPass1: UIButton!
    @IBOutlet weak var btnPass2: UIButton!
    @IBOutlet weak var btnPass3: UIButton!
    @IBOutlet weak var btnPass4: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        KLog.d(tag: TAG, msg: "viewDidLoad")
        initialize()
    }

    func initialize(){
        mButton.append(btnClear)
        mButton.append(btnPass1)
        mButton.append(btnPass2)
        mButton.append(btnPass3)
        mButton.append(btnPass4)
        mButton.append(num0)
        mButton.append(num1)
        mButton.append(num2)
        mButton.append(num3)
        mButton.append(num4)
        mButton.append(num5)
        mButton.append(num6)
        mButton.append(num7)
        mButton.append(num8)
        mButton.append(num9)
        
        //암호 설정
        if mSetting == "SET" {
            isPasswordset = true
        }
        // 암호 맞추기
        else if mSetting == "GET" {
            isPasswordset = false
        }
  
//        AppUtils.sendTrackerScreen(this, "암호설정화면");
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
    
     @IBAction func onClick(_ sender: Any) {
          switch(sender  as! UIButton ){
          case num0, num1, num2, num3, num4, num5, num6, num7, num8, num9:
                 if (mPasswordData.count < 4) {
                    let data = (sender as AnyObject).title(for: .normal)!
                    KLog.d(tag: TAG, msg: "@@ data : " + data)
                     mPasswordData.append(data)
                     printPassword()
                     setButtonText()
                 }
                 break;
             case btnClear:
                 let size = mPasswordData.count
                 if (size > 0 && size <= 4) {
                    mPasswordData.remove(at: size-1)
                     printPassword()
                     setButtonText()
                 }
                 break;
          default:
            break;
        }
    }

    private func printPassword() {
        for index in mPasswordData {
            KLog.d(tag: TAG, msg: "@@ item:" + index)
        }
    }

    private func setButtonText() {
        KLog.d(tag: TAG, msg: "@@ mPasswordData size : " + String( mPasswordData.count))
        
        if mPasswordData.count > 1 {
            for index in 1...mPasswordData.count {
                mButton[index].setTitle("*", for: UIControl.State.normal)
            }
        }
        
        if mPasswordData.count < 4 {
            for index in 1...4 - mPasswordData.count {
                mButton[5-index].setTitle(" ", for: UIControl.State.normal)
            }
        }
       
        if (mPasswordData.count == 4) {
            let pswd = mPasswordData[0] + "" + mPasswordData[1] + "" + mPasswordData[2] + "" + mPasswordData[3]
            UserDefault.write(key: ContextUtils.KEY_CONF_PASSWORD, value: pswd)
        
            if (isPasswordset) {
                back(strBack: ContextUtils.MAIN_VIEW)
            } else {
                let password = UserDefault.read(key: ContextUtils.KEY_CONF_PASSWORD)
            
                if (pswd != password) {
                    let message = AppUtils.localizedString(forKey : "password_fail_string")
                    Toast.showToast(message: message)
                    mPasswordData.removeAll()
                    for index in 1...4 {
                        mButton[index].setTitle("", for: UIControl.State.normal)
                    }
                    
                } else {
                    if mStartView == ContextUtils.WIDGET_WRITE_BUCKET {
                        back(strBack: ContextUtils.WRITE_VIEW)
                    }
                    else if mStartView == ContextUtils.WIDGET_BUCKET_LIST {
                        back(strBack: ContextUtils.BUCKET_LIST_VIEW)
                    }
                    else if mStartView == ContextUtils.WIDGET_OURS_BUCKET {
                        back(strBack: ContextUtils.SHARE_VIEW)
                    }
                    else if mStartView == ContextUtils.WIDGET_SHARE {
                        let uvc = self.storyboard?.instantiateViewController(withIdentifier : ContextUtils.MAIN_VIEW) as! ViewController
                        uvc.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal //페이지 전환시 에니메이션 효과 설정
                        uvc.mWidgetSendData = ContextUtils.WIDGET_SHARE
                        self.present(uvc, animated: true, completion: nil)
                    }else{
                        back(strBack: ContextUtils.MAIN_VIEW)
                    }
                }
             }
         }
    }
}
