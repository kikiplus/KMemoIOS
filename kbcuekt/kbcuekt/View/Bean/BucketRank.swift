//
//  BucketRank.swift
//  
//
//  Created by grapegirl on 2017. 9. 01..
//  Copyright © 2017년 kikiplus. All rights reserved.
//

import Foundation
import UIKit

class BucketRank {
    
    /**
     * 카테고리코드
     */
    var mCategoryCode : Int = 0
    /**
     * 카테고리명
     */
    var mCategoryName : String = ""
    /**
     * 메모내용
     */
    var mContent : String = ""
    /**
     * 번호
     */
    var mIdx : Int = 0
    /**
     * 최고에요 카운트
     */
    var mBestCnt : Int = 0
    /**
     * 좋아요 카운트
     */
    var mGoodCnt : Int = 0
    /**
     * 괜찮아요 카운트
     */
    var mSoSoCnt : Int = 0
    /**
     * 사용자 카운트
     */
    var mComment : Int = 0

     /**
     * 생성자
     */
    init() {
    
    }

     /**
     * 소멸자
     */
    deinit {

    }  
    
}

