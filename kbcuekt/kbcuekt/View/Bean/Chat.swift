//
//  Chat.swift
//  
//
//  Created by grapegirl on 2017. 9. 01..
//  Copyright © 2017년 kikiplus. All rights reserved.
//

import Foundation
import UIKit

class Chat  {
    
   /** 내용 */
	var mContent : String  = ""
	/** 날짜 */
	var mDate :  String = ""
	/** 방번호 */
	var mIdx :  String  = ""
	/** 닉네임 */
	var mNickName :  String = ""
	/** 사용자 전화번호 */
	var mPhone :  String = ""
	/** 이미지 저장경로 */
	var mImageURl :  String = ""
	/** 숨긴 여부 */
	var mIsHidden :  String = ""
	/** seq */
	var mSeq : Int  = 0

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

