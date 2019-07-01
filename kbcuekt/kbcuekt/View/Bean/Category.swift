//
//  Category.swift
//  
//
//  Created by grapegirl on 2017. 9. 01..
//  Copyright © 2017년 kikiplus. All rights reserved.
//

import Foundation
import UIKit

class Category  {
    
    /** 카테고리 코드 */
    var mCategoryCode : Int  = 0
	/** 카테고리명 */
    var mCategoryName : String = ""
    
    /**
     * 생성자
     */
    init() {
        mCategoryCode = 0
        mCategoryName = ""
    }

    init(name : String, code : Int){
        self.mCategoryName = name
		self.mCategoryCode = code
    }

    /**
     * 소멸자
     */
    deinit {

    }  
    
    
    
}

