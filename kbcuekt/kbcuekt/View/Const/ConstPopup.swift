//
//  ConstPopup.swift
//  kbucket
//
//  Created by 김미혜 on 2018. 10. 1..
//  Copyright © 2018년 kikiplus. All rights reserved.
//

import Foundation

struct ConstPopup {
    
    /** 팝업 확인 버튼 선택 */
    public static let     POPUP_BTN_OK      : Int       = 0
    /** 팝업 취소 버튼 선택 */
    public static let     POPUP_BTN_CLOSEE  : Int       = 1
    /** 팝업 백키 */
    public static let     POPUP_BACK        : Int       = 2
    /** 팝업 해제 */
    public static let     POPUP_DISPOSE     : Int       = 3
    
    /** 기본 팝업 */
    public static let  POPUP_BASIC              : Int = 1000;
    /** 공유하기 팝업 */
    public static let  POPUP_BUCKET_SHARE       : Int = 1001;
    /** 카테고리 선택 팝업 */
    public static let  POPUP_BUCKET_CATEGORY    : Int = 1002;
    /** AI 팝업 */
    public static let  POPUP_AI                 : Int = 1003;
    /** 강제 업데이트 팝업 */
    public static let  POPUP_UPDATE_FORCE       : Int = 1004;
    /** 선택 업데이트 팝업 */
    public static let  POPUP_UPDATE_SELECT      : Int = 1005;
    /** 삭제 팝업 */
    public static let  POPUP_BUCKET_DELETE      : Int = 1006;
    /** 관심 버킷 추가 팝업 */
    public static let  POPUP_BUCKET_ADD         : Int = 1007;
}
