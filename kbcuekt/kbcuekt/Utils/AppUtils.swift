
/***
 * @author grapegirl
 * @version 1.1
 * @Class Name : AppUtils.swift
 * @Description : Log 클래스
 * @since 2017.09.04
 */
import UIKit

class AppUtils {
    
    private let TAG : String = "AppUtils"

    init() {
       
    }
    
    /**
     * 현재 사용자에 설정된 언어 가져오기
     *
     * @param context 컨텍스트
     * @return 언어 정보
     */
     public static func getUserPhoneLanuage() -> String {
        let langStr = Locale.current.languageCode
        if langStr != nil {
            return langStr!
        }
        return ""
     }

    /**
     * 현재 사용자에 디바이스 OS 버전 정보 가져오기
     *
     * @param context 컨텍스트
     * @return OS 버전 정보
     */
    public static func getOsVersion() -> String {
        let systemVersion = UIDevice.current.systemVersion
        return systemVersion
    }
    
    /**
     * 현재 사용자에 디바이스 타입 정보 가져오기
     *
     * @param context 컨텍스트
     * @return 디바이스 타입 정보
     */
    public static func getPhoneType() -> String {
        let model = UIDevice.current.model
        return model
    }
    
    /**
     * 사용자 Device ID 반환 메소드
     *
     * @return 사용자 Device ID
     */
     public static func getUserDeviceID() -> String {
        let deviceId = UIDevice.current.identifierForVendor!.uuidString
        return deviceId
     }
    
    /**
     * 앱 리소스 String 반환
     * @param  key  리소스 키값
     */
    public static func localizedString(forKey key: String) -> String {
        let message = NSLocalizedString(key, comment: "")
        return message
    }
    
    public static func sendTrackerScreen(screen : String) -> Void {
        KLog.d(tag: ContextUtils.TAG, msg: " sendTrackerScreen => " + screen);
    }
    
    public static func getUUIDfromKeyChain() -> String {
        return ""
    }
  }
