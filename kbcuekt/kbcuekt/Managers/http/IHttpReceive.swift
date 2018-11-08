//
//  IHttpReceive.swift
//  kbucket
//
//  Created by 김미혜 on 2017. 11. 4..
//  Copyright © 2017년 kikiplus. All rights reserved.
//

import Foundation

protocol IHttpReceive {
    
    /***
     * 리비스 콜백 메소드
     */
    func onHttpReceive(type : Int, actionId: Int,  data : Data)
    
}
