//
//  ConfirmPopup.swift
//  kbucket
//
//  Created by 김미혜 on 2018. 10. 1..
//  Copyright © 2018년 kikiplus. All rights reserved.
//

import Foundation
import UIKit

class ConfirmPopup  {
    
    /**
     * 타이틀
     */
    private var mTitle : String = "";
    /**
     * 내용
     */
    private var mContent : String = "";
    /**
     * 팝업 아이디
     */
    private var mPopupId : Int = 0;
    /**
     * 팝업 다이얼로그뷰
     */
    private var mDialogView : UIAlertController = UIAlertController();
    
    init() {
        mTitle = ""
        mContent = ""
        mPopupId = 0
    }
    
    private func setData() -> Void {
        self.mDialogView = UIAlertController(title: mTitle, message: mContent, preferredStyle: UIAlertController.Style.alert)
        self.mDialogView.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { action in
            self.mDialogView.dismiss(animated: true, completion: nil)
        }))
        self.mDialogView.addAction(UIAlertAction(title: "Cancle", style: UIAlertAction.Style.default, handler: { action in
            self.mDialogView.dismiss(animated: true, completion: nil)
        }))
    }
    
    public func showMessage(title : String, content : String, vc : ViewController, id : Int)-> Void {
        mTitle = title
        mContent = content
        mPopupId = id
        setData()
        vc.present(mDialogView, animated: true, completion: nil)
    }
    
}
