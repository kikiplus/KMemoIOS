//
//  SetBackColorView.swift
//  사용자 테마 설정
//
//  Created by grapegirl on 2018. 8. 29..
//  Copyright © 2017년 kikiplus. All rights reserved.
//

import UIKit

class SetBackColorView : UIViewController {

    private let TAG : String = "SetBackColorView"
    private var mImageButton = Array<UIButton>()
    
    @IBOutlet weak var btnBack1: UIButton!
    @IBOutlet weak var btnBack2: UIButton!
    @IBOutlet weak var btnBack3: UIButton!
    @IBOutlet weak var btnBack4: UIButton!
    @IBOutlet weak var btnBack5: UIButton!
    @IBOutlet weak var btnBack6: UIButton!
    @IBOutlet weak var btnBack7: UIButton!
    @IBOutlet weak var btnBack8: UIButton!
    @IBOutlet weak var btnBack9: UIButton!
    @IBOutlet weak var btnBack10: UIButton!
    @IBOutlet weak var btnBack11: UIButton!
    @IBOutlet weak var btnBack12: UIButton!
    @IBOutlet weak var btnBack13: UIButton!
    @IBOutlet weak var btnBack14: UIButton!
    @IBOutlet weak var btnBack15: UIButton!
    @IBOutlet weak var btnBack16: UIButton!
    @IBOutlet weak var btnBack17: UIButton!
    @IBOutlet weak var btnBack18: UIButton!
    
    @IBOutlet var backView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        KLog.d(tag: TAG, msg: "viewDidLoad")
        initialize()
    }
    
    func initialize(){
        setButtons()
    //     AppUtils.sendTrackerScreen(this, "테마변경화면");
    }

    private func setButtons() {
        mImageButton.append(btnBack1)
        mImageButton.append(btnBack2)
        mImageButton.append(btnBack3)
        mImageButton.append(btnBack4)
        mImageButton.append(btnBack5)
        mImageButton.append(btnBack6)
        mImageButton.append(btnBack7)
        mImageButton.append(btnBack8)
        mImageButton.append(btnBack9)
        mImageButton.append(btnBack10)
        mImageButton.append(btnBack11)
        mImageButton.append(btnBack12)
        mImageButton.append(btnBack13)
        mImageButton.append(btnBack14)
        mImageButton.append(btnBack15)
        mImageButton.append(btnBack16)
        mImageButton.append(btnBack17)
        mImageButton.append(btnBack18)
    }

    @IBAction func onClick(_ sender: UIButton) {
        switch sender {
        case btnBack1, btnBack2, btnBack3, btnBack4, btnBack5,
             btnBack6, btnBack7, btnBack8, btnBack9, btnBack10,
             btnBack11, btnBack12, btnBack13, btnBack14, btnBack15,
             btnBack16, btnBack17, btnBack18:
            
            let backColor : UIColor = sender.backgroundColor!
            KLog.d(tag: TAG, msg: "@@ hexString : " + backColor.hexString)
            UserDefault.write(key: ContextUtils.BACK_MEMO, value: backColor.hexString)
            checkButton(button: sender)
            setBackgroundColor()
            break
        default:
            break
        }

    }

    private func checkButton( button : UIButton) {
        for item in mImageButton {
            if item == button {
                item.setImage(UIImage(named: "mark.png"), for: .normal)
            }else{
                item.setImage(nil, for: .normal)
            }
        }
    }

   @IBAction func onBackPressed(_ sender: Any) {
        let uvc = self.storyboard?.instantiateViewController(withIdentifier: ContextUtils.MAIN_VIEW)
        uvc?.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal //페이지 전환시 에니메이션 효과 설정
        present(uvc!, animated: true, completion: nil)
    }
    
    private func setBackgroundColor() {
        let color : String = UserDefault.read(key: ContextUtils.BACK_MEMO)
        KLog.d(tag: TAG, msg: "color : " + color)
        if color.count > 0 {
            let uColor = UIColor(hexRGB: color)
            backView.backgroundColor = uColor
        }
    }
    
}
