//
//  CustomPopup.swift
//  kbucket
//
//  Created by 김미혜 on 2018. 9. 4..
//  Copyright © 2018년 kikiplus. All rights reserved.
//

import Foundation
import UIKit

class CustomPopup {
    
    var backView : UIView!
    var centerView : UILabel!
    var exitButton : UIButton!
    var mPopupLiener : PopupProtocol? = nil
    
    /**
     * 내용
     */
    private var mContent : String = "";
    /**
     * 팝업 아이디
     */
    private var mPopupId : Int = 0;
    
    public init(listener : PopupProtocol) {
        self.mPopupLiener = listener
    }
    
    public func showDialog(message : String, id : Int) {
        mPopupId = id
        mContent = message
        setData()
        if(self.mPopupLiener != nil){
//            self.mPopupLiener?.onPopupAction(popId : id, what : ConfirmPopup.POPUP_BTN_OK, data : "")
        }
    
    }
    
    private func setData(){
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        self.backView = UIView(frame: CGRect(x: 0, y: 0, width: appDelegate.window!.frame.size.width, height: appDelegate.window!.frame.size.height))
        self.backView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        self.backView.isUserInteractionEnabled = true
        
        appDelegate.window!.addSubview(self.backView)
        
        self.centerView = UILabel(frame: CGRect(x: appDelegate.window!.frame.size.width/4, y: appDelegate.window!.frame.size.height/2, width: appDelegate.window!.frame.size.width/2, height: 100))
        self.centerView.backgroundColor = UIColor.red
        self.centerView.textColor = UIColor.white
        self.centerView.textAlignment = .center
        self.centerView.text = mContent
        self.centerView.numberOfLines = 5
        self.centerView.font = UIFont(name: "Montserrat-Light", size: 15.0)
        self.centerView.alpha = 1.0
        self.centerView.layer.cornerRadius = 10;
        self.centerView.clipsToBounds  =  true
        
        appDelegate.window!.addSubview(self.centerView)
        
        self.exitButton = UIButton(frame: CGRect(x: 0, y: 0, width : 100, height : 50))
        self.exitButton.setTitle("exit", for: .normal)
        self.exitButton.backgroundColor = UIColor.gray
        self.exitButton.addTarget(self, action: #selector(click(_:)), for: .touchUpInside)
        
        appDelegate.window!.addSubview(self.exitButton)
        
    }
    
    @objc public func click(_ sender: UIButton!) {
        self.backView.removeFromSuperview()
        self.centerView.removeFromSuperview()
        self.exitButton.removeFromSuperview()
    }
    
}
