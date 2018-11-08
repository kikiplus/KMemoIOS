//
//  Comment.swift
//  
//
//  Created by grapegirl on 2017. 9. 01..
//  Copyright © 2017년 kikiplus. All rights reserved.
//

import Foundation
import UIKit

class Comment {
    
    /** 메모내용 */
	@objc dynamic var mContent : String  = ""
	/** 날짜 */
	@objc dynamic var mDate : String = ""
	/** 닉네임 */
	@objc dynamic var mNickName : String = ""
	/** 번호 */
	@objc dynamic var mIdx : Int  = 0
	/** 버킷No */
	@objc dynamic var mBucketNo : Int = 0

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

