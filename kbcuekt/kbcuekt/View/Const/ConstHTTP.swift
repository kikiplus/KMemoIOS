//
//  ConstHTTP.swift
//  kbucket
//
//  Created by 김미혜 on 2017. 11. 4..
//  Copyright © 2017년 kikiplus. All rights reserved.
//

import Foundation

struct ConstHTTP {
    /**
     * 성공
     */
    public static let HTTP_OK : Int = 0
    
    /**
     * 실패
     */
    public static let HTTP_FAIL : Int = -1
    
    /** 버킷 공유하기  */
    public static let  INSERT_BUCKET : Int  = 2000
    /** 버킷 공유하기 (image) */
    public static let  INSERT_IMAGE : Int  = 2001
    /**  버전 체크 */
    public static let  UPDATE_VERSION  : Int = 2002
    /**  카데고리 정보 */
    public static let  CATEGORY_LIST : Int  = 2003
    /**  버킷 정보 */
    public static let  BUCKET_LIST : Int  = 2004
    /**  댓글 정보 */
    public static let  COMMENT_LIST  : Int = 2005
    /**  댓글 추가 */
    public static let  INSERT_COMMENT : Int  = 2006
    /**  공지 사항  */
    public static let  NOTICE_LIST : Int  = 2007
    /**  사용자 정보 업데이트*/
    public static let  UPDATE_USER  : Int = 2008
    /**  이미지 다운로드*/
    public static let  DOWNLOAD_IMAGE : Int  = 2009
    /**  AI*/
    public static let  REQUEST_AI : Int  = 2010
    /**  랭킹 리스트*/
    public static let  RANK_LIST : Int  = 2011
    /**  랭킹 의견 업데이트*/
    public static let  RANK_UPDATE_COMMENT : Int  = 2012
    /**  DB 업로드 */
    public static let  UPLOAD_DB : Int  = 2013
    /**  채팅 내용 전송 */
    public static let  INSERT_CHAT : Int  = 2014
    /**  채팅 내용 조회 */
    public static let  SELECT_CHAT: Int   = 2015
}
