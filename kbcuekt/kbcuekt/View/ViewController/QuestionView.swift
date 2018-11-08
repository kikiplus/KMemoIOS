//
//  QuestionView.swift
//  문의하기
//
//  Created by grapegirl on 2017. 9. 01..
//  Copyright © 2017년 kikiplus. All rights reserved.
//

import UIKit

class QuestionView : UIViewController , UITextViewDelegate {
    private let TAG : String = "QuestionView"
    private var mTitleIndex : Int = 1

    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnSend: UIButton!
    
    @IBOutlet weak var btnTitle1: UIButton!
    @IBOutlet weak var btnTitle2: UIButton!
    @IBOutlet weak var btnTitle3: UIButton!
    
    @IBOutlet weak var tvContents: UITextView!
    let tvPlaceHolder = AppUtils.localizedString(forKey : "question_layout_hint")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        KLog.d(tag: TAG, msg: "viewDidLoad")
        
        tvContents.text = tvPlaceHolder
        tvContents.textColor = UIColor.lightGray
        tvContents.font = UIFont(name: "verdana", size: 13.0)
        tvContents.returnKeyType = .done
        tvContents.delegate = self
        
        setTitleIndex(index: 1)
        AppUtils.sendTrackerScreen(screen: "문의화면");
    }
    
   private func finish(){
        KLog.d(tag: TAG, msg: "finish")
        let uvc = self.storyboard?.instantiateViewController(withIdentifier: ContextUtils.MAIN_VIEW)
        uvc?.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal //페이지 전환시 에니메이션 효과 설정
        present(uvc!, animated: true, completion: nil)
    }

    @IBAction func onClick(_ sender: UIButton) {
          switch(sender){
          case btnSend:
            let title = getTitleIndex(index: mTitleIndex)
            let content = tvContents.text
            sendEmail(name: title, content: content!)
            finish()
            break
          case btnBack:
            finish()
            break
          case btnTitle1:
            setTitleIndex(index: 1)
            break
          case btnTitle2:
            setTitleIndex(index: 2)
            break
          case btnTitle3:
            setTitleIndex(index: 3)
            break
          default:
            break;
          }
    }
  
    /***
     * 메일 보내기
     *
     * @param name    제목
     * @param content 내용
     */
     private func sendEmail(name : String, content : String){
        KLog.d(tag: TAG, msg: "@@ sendEmail name : " + name + ", content : " + content)
        let msg = content
        let activityViewController = UIActivityViewController(activityItems:
            ["Whatever you want to share!"], applicationActivities: nil)
        
        activityViewController.excludedActivityTypes = [UIActivity.ActivityType.print, UIActivity.ActivityType.postToWeibo, UIActivity.ActivityType.copyToPasteboard, UIActivity.ActivityType.addToReadingList, UIActivity.ActivityType.postToVimeo]
        
        let shareSheet = UIActivityViewController(activityItems: [ msg ], applicationActivities: nil)
        shareSheet.popoverPresentationController?.sourceView = self.view
        present(activityViewController, animated: true, completion: nil)
     }

    private func setTitleIndex(index : Int){
       mTitleIndex = index
        switch (index) {
            case 1:
                btnTitle1.backgroundColor = UIColor.white
                btnTitle2.setTitleColor(UIColor.white, for: .normal)
                btnTitle3.setTitleColor(UIColor.white, for: .normal)
                btnTitle1.setTitleColor(UIColor.init(hexRGB: "#FF99CC00"), for: .normal)
                btnTitle2.backgroundColor = UIColor.init(hexRGB: "#FF99CC00")
                btnTitle3.backgroundColor = UIColor.init(hexRGB: "#FF99CC00")
                break
            case 2:
                btnTitle2.backgroundColor = UIColor.white
                btnTitle1.setTitleColor(UIColor.white, for: .normal)
                btnTitle3.setTitleColor(UIColor.white, for: .normal)
                btnTitle2.setTitleColor(UIColor.init(hexRGB: "#FF99CC00"), for: .normal)
                btnTitle1.backgroundColor = UIColor.init(hexRGB: "#FF99CC00")
                btnTitle3.backgroundColor = UIColor.init(hexRGB: "#FF99CC00")
                break
            case 3:
                btnTitle3.backgroundColor = UIColor.white
                btnTitle1.setTitleColor(UIColor.white, for: .normal)
                btnTitle2.setTitleColor(UIColor.white, for: .normal)
                btnTitle3.setTitleColor(UIColor.init(hexRGB: "#FF99CC00"), for: .normal)
                btnTitle1.backgroundColor = UIColor.init(hexRGB: "#FF99CC00")
                btnTitle2.backgroundColor = UIColor.init(hexRGB: "#FF99CC00")
                break
            default:
                break
        }
    }

    private func getTitleIndex(index : Int) -> String {
        switch (index) {
            case 1:
                return "오류"
            case 2:
                return "개선"
            case 3:
                return "문의"
            default:
                return "기타"
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == tvPlaceHolder {
            textView.text = ""
            textView.textColor = UIColor.black
            textView.font = UIFont(name: "verdana", size: 18.0)
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = tvPlaceHolder
            textView.textColor = UIColor.lightGray
            textView.font = UIFont(name: "verdana", size: 13.0)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
