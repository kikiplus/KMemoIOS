//
//  PostData.swift
//  
//
//  Created by grapegirl on 2017. 9. 01..
//  Copyright © 2017년 kikiplus. All rights reserved.
//

import Foundation
import UIKit

class PostData  {
    
   /**
     * 타이틀
     */
    var m_title : String  = ""

    /**
     * 등록 날짜
     */
    var m_date : String  = ""
    /**
     * 내용
     */
    var m_contents : String  = ""

    /**
     * 순번
     */
    var mNo : Int  = -1

    /**
     * 이미지 이름
     */
    var mImageName : String = ""

    /**
     * 완료여부
     */
    var mCompleteYN : String  = ""

    /**
     * 기한
     */
    var mDeadline : String = ""

    
    /**
     * 생성자
     */
    init() {
        self.m_contents = ""
    }

    /**
     * 생성자
     */
    init(contents : String) {
        self.m_title = ""
        self.m_date = ""
        self.m_contents = contents
        self.mNo = 0
    }

    init(contents : String, complete : String) {
        self.m_title = ""
        self.mCompleteYN = complete
        self.m_contents = contents
        self.mNo = 0
    }

    /**
     * 생성자
     */
    init(title : String, contents : String,  date : String, no : Int) {
        self.m_title = title
        self.m_date = date
        self.m_contents = contents
        self.mNo =  no
    }

    /**
     * 소멸자
     */
    deinit {

    }
    
    public func getTitle() -> String{
        return m_title
    }
    
    public func getContent() -> String{
        return m_contents
    }
    
    public func setImage(imagePath : String){
        mImageName = imagePath
    }
    
    public func setDate(date : String){
        m_date = date
    }

    var description : String {
        return "contents=\(m_contents),date=\(m_date),complete_yn=\(mCompleteYN),image_path=\(mImageName)"
    }
}

