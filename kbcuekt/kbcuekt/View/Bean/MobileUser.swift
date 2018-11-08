//
//  MobileUser.swift
//  
//
//  Created by grapegirl on 2017. 9. 01..
//  Copyright © 2017년 kikiplus. All rights reserved.
//

import Foundation
import UIKit

class MobileUser {
    
   /**
     * 모바일 OS
     */
    var mOs : String = ""
    /**
     * 사용자 전화번호
     */
    var mPhone : String  = ""
    /**
     * 사용자 닉네임
     */
    var mUserNickName  : String  = ""
    /**
     * 사용자 버전명
     */
    var mVersionName  : String  = ""
    /**
     * 사용자 마켓구분
     */
    var mMarket  : String  = ""
    /**
     * 사용자 언어
     */
    var mLanguage  : String  = ""
    /**
     * 사용자 나라
     */
    var mCountry  : String = ""
    /**
     * 사용자 최근 방문 날짜
     */
    var mLastDt  : String = ""
    /**
     * 사용자 생성 날짜
     */
    var mCreateDt  : String = ""
    /**
     * 사용자 토큰키
     */
    var mGcmToken  : String = ""
    
    var description : String {
        return "Os=\(mOs),UserNickName=\(mUserNickName),VersionName=\(mVersionName),Market=\(mMarket),Language=\(mLanguage),Country=\(mCountry)LastDt=\(mLastDt),CreateDt=\(mCreateDt),GcmToken=\(mGcmToken)";
    }

    /**
     * 생성자
     */
    init() {
        self.mOs = "IOS"
        self.mMarket = "APPLE"
        self.mGcmToken = "N"
    }
    
    
    /**
     * 소멸자
     */
    deinit {

    }
    
    public func toDictionary() -> [String:String] {
        var map =  [String:String]()
        map["OS"] = mOs
        map["NICKNAME"] = mUserNickName
        map["PHONE"] = mPhone
        map["VERSION_NAME"] = ContextUtils.VERSION_NAME
        map["MARKET"] = mMarket
        map["LANG"] = mLanguage
        map["COUNTY"] = mCountry
        map["GCM_TOKEN"] = mGcmToken
        map["OS_VERSION"] = AppUtils.getOsVersion()
        map["TEL_GBN"] = AppUtils.getPhoneType()
        
        return map
    }
    
}

