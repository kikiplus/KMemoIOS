//
//  TutorialView.swift
//  뷰 플리퍼를 이용하여 튜토리얼
//
//  Created by grapegirl on 2018. 9. 03..
//  Copyright © 2017년 kikiplus. All rights reserved.
//

import UIKit

class TutorialView: UIViewController {

    private let TAG : String = "TutorialView"
    private var mPreTouchPosX : Int = 0
    private var mCurrentPage : Int = 0
    private var mMacPage : Int = 0

    @IBOutlet var backView: UIView!
    @IBOutlet weak var btnMain1: UIButton!
    @IBOutlet weak var btnMain2: UIButton!
    @IBOutlet weak var btnMain3: UIButton!
    @IBOutlet weak var btnMain4: UIButton!
    @IBOutlet weak var btnMain5: UIButton!
    @IBOutlet weak var currentView: UIImageView!
    private var mButton = Array<UIButton>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        KLog.d(tag: TAG, msg: "viewDidLoad")
        setBackgroundColor()
     
        mButton.append(btnMain1)
        mButton.append(btnMain2)
        mButton.append(btnMain3)
        mButton.append(btnMain4)
        mButton.append(btnMain5)
        
        currentView.isUserInteractionEnabled = true
        currentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTapped)))
        mCurrentPage = 0
        mMacPage = 5
        setViewImgData(index: 1)
        setPageCheck()
        AppUtils.sendTrackerScreen(screen:  "가이드화면")
    }
    
    private func setBackgroundColor() {
        let color : String = UserDefault.read(key: ContextUtils.BACK_MEMO)
        KLog.d(tag: TAG, msg: "color : " + color)
        if color.count > 0 {
            let uColor = UIColor(hexRGB: color)
            backView.backgroundColor = uColor
        }
    }
    
    @IBAction func onBackPressed(_ sender: Any) {
        KLog.d(tag: TAG, msg: "onBackPressed")
        ViewUtils.changeView(strView: ContextUtils.MAIN_VIEW, viewCtrl: self)
    }
    
    @IBAction func onClick(_ sender: UIButton) {
        switch sender {
        case btnMain1:
            setViewImgData(index: 1)
            break
        case btnMain2:
            setViewImgData(index: 2)
            break
        case btnMain3:
            setViewImgData(index: 3)
            break
        case btnMain4:
            setViewImgData(index: 4)
            break
        case btnMain5:
            setViewImgData(index: 5)
            break
        default:
            break
        }
    }
    
    @objc private func imageTapped(_ recognizer: UITapGestureRecognizer) {
        if (recognizer.state == .ended) {
            //터치한 이미지뷰의 좌표를 가져온다.
            let point = recognizer.location(in: recognizer.view)
            let nTouchPosX : Int = Int(point.x)
            //print("@@ nTouchPosX :  " +  String(nTouchPosX)  + ", mPreTouchPosX : " + String(mPreTouchPosX) )
            if (nTouchPosX < mPreTouchPosX){
                MovePreviousView()
            } else if (nTouchPosX > mPreTouchPosX){
                 MoveNextView()
            }
            mPreTouchPosX = nTouchPosX
        }
    }
    
  /**
   * 화면 설정 메소드
   */
    public func setViewImgData(index : Int) {
        switch index {
        case 0:
            currentView.image = UIImage(named: "tutorial01")
            break
        case 1:
             currentView.image = UIImage(named: "tutorial02")
            break
        case 2:
             currentView.image = UIImage(named: "tutorial03")
            break
        case 3:
             currentView.image = UIImage(named: "tutorial04")
            break
        case 4:
             currentView.image = UIImage(named: "tutorial05")
            break
        default:
            break
        }
     }

    /**
      * 다음 화면 호출 메소드
      */
     private func MoveNextView() {
         if (mCurrentPage + 1 < mMacPage) {
             mCurrentPage = mCurrentPage + 1
             setPageCheck()
         }
     }

     /**
      * 이전 화면 호출 메소드
      */
     private func MovePreviousView() {
         if (mCurrentPage - 1 >= 0) {
             mCurrentPage = mCurrentPage - 1
             setPageCheck()
         }
     }

     /**
      * 현재 페이지 라디오 버튼 설정 메소드
      */
     private func setPageCheck() {
        KLog.d(tag: TAG, msg: "setPageCheck Page : " + String(mCurrentPage))
        setViewImgData(index: mCurrentPage)
        
        for index in 0 ..< mMacPage {
            if index == mCurrentPage {
                mButton[index].setImage( UIImage(named: "yellow_dot"), for: .normal)
            }else{
              mButton[index].setImage( UIImage(named: "dot"), for: .normal)
            }
        }
     }
}
