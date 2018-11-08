
/***
 * @author grapegirl
 * @version 1.1
 * @Class Name : ScreenUtils.swift
 * @Description : 화면 유틸 클래스
 * @since 2017.09.04
 */
import UIKit

class ScreenUtils{
    
    init() {
    }
    
    public static func ptToPx(points  : CGFloat) -> Void {
        // see: http://en.wikipedia.org/wiki/Point%5Fsize#Current%5FDTP%5Fpoint%5Fsystem
//        CGFloat; pointsPerInch = 72.0
//        CGFloat; scale = 1
//
//        float; pixelPerInch // DPI
//        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//            pixelPerInch = 132 * scale
//        } else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
//            pixelPerInch = 163 * scale
//        } else {
//            pixelPerInch = 160 * scale
//        }
//        CGFloat; px = points / (pointsPerInch * pixelPerInch)
//        return px
    }
     
    public static func pxTopt(px : CGFloat) -> Void {
        // see: http://en.wikipedia.org/wiki/Point%5Fsize#Current%5FDTP%5Fpoint%5Fsystem
//        CGFloat; pointsPerInch = 72.0
//        CGFloat; scale = 1
//        float; pixelPerInch // DPI
//        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//            pixelPerInch = 132 * scale
//        } else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
//            pixelPerInch = 163 * scale
//        } else {
//            pixelPerInch = 160 * scale
//        }
//        CGFloat; points = px * pointsPerInch / pixelPerInch
//        return points
    }


    /**
     * 해상도 pixel 가져오는 메소드
     *
     * @param windowManager
     * @return 화면 해상도 가로 세로
     */
    public static func getDisplay() -> Void {
//        var bounds  = UIScreen.mainScreen().bounds
//        var width = bounds.size.width //화면 너비
//        var height = bounds.size.height //화면 높이
//
//        String; displayInfo =  width  + "," + height
//        return displayInfo
    }
}
