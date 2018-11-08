//
//  PopupProtocol.swift
//  kbucket
//
//  Created by 김미혜 on 2018. 10. 1..
//  Copyright © 2018년 kikiplus. All rights reserved.
//

import Foundation

protocol PopupProtocol {
    
    /**
     * 팝업 관련 동작 메소드
     * @param  popId 팝업 구분값
     * @param what 버튼 상태
     * @param data 전달할 값
     */
    func onPopupAction(popId : Int, what : Int, data : String)
}
