
/***
 * @author grapegirl
 * @version 1.0
 * @Class Name : ViewUtils.swift
 * @Description : Log 클래스
 * @since 2017.12.04
 */
import UIKit

class ViewUtils {
    
    let TAG : String = "ViewUtils"

    init() {
    }
    
    public static func changeView(strView : String, viewCtrl : UIViewController){
        let uvc = viewCtrl.storyboard?.instantiateViewController(withIdentifier : strView)
        uvc?.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal //페이지 전환시 에니메이션 효과 설정
        viewCtrl.present(uvc!, animated: true, completion: nil)
    }

    public static func finish(viewCtrl : UIViewController){
        viewCtrl.dismiss(animated: true, completion : nil)
    }    
}
