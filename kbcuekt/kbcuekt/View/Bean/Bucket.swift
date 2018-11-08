//
//  Bucket.swift
//  
//
//  Created by grapegirl on 2017. 9. 01..
//  Copyright © 2017년 kikiplus. All rights reserved.
//

import Foundation
import UIKit
import Realm
import RealmSwift

class Bucket : Object {
    
    /**
     * 카테고리코드
     */
    
    @objc dynamic var mCategoryCode : Int = 0
    /**
     * 메모내용
     */
    @objc dynamic var mContent : String = ""
    /**
     * 날짜
     */
    @objc dynamic var mCompleteYN : String = ""
    

    /**
     * 날짜
     */
    @objc dynamic var mCompleteDate : String = ""
    /**
     * 번호
     */
   
    @objc dynamic var mIdx : Int  = 0
    /**
     * 닉네임
     */
    @objc dynamic var mNickName : String = ""
    /**
     * 사용자 전화번호
     */
    @objc dynamic var mPhone : String = ""
    /**
     * 이미지 저장경로
     */
    @objc dynamic var mImageURl : String = ""
    /**
     * 날짜
     */
    @objc dynamic var mDate : String = ""
    
    public func toString() -> String{
        var strTemp = ""
        strTemp = "mContents : " + mContent + ",mCompleteDate: " + mCompleteDate
        return strTemp
    }

    override static func primaryKey() -> String? {
        return "mContent"
    }
 
    public func toDictionary() -> [String:String] {
        var map =  [String:String]()
        map["CATEGORY_CODE"] = String(mCategoryCode)
        map["NICKNAME"] = mNickName
        map["PHONE"] = mPhone
        map["CONTENT"] = mContent
        if (mImageURl.count > 0) {
             map["IMAGE_URL"] = "Y"
        } else {
            map["IMAGE_URL"] = "N"
        }
        map["CREATE_DT"] = mCompleteDate
        return map
     }
}

