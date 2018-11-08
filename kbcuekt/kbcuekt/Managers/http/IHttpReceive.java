
/**
 * @author grapegirl
 * @version 1.0
 * @Class Name : IHttpReceive
 * @Description : HTTP 통신 결과
 * @since 2017-11-04
 */

import Foundation

protocol IHttpReceive {
    /**
     * 성공
     */
    public let  HTTP_OK : Int  = 0;

    /**
     * 실패
     */
    public static final int HTTP_FAIL = -1;

    /***
     * 리비스 콜백 메소드
     */
    func onHttpReceive(type : Int, actionId: Int,  data : String)


    /** 버킷 공유하기  */
    public static final int INSERT_BUCKET  = 2000;
    /** 버킷 공유하기 (image) */
    public static final int INSERT_IMAGE  = 2001;
    /**  버전 체크 */
    public static final int UPDATE_VERSION  = 2002;
    /**  카데고리 정보 */
    public static final int CATEGORY_LIST  = 2003;
    /**  버킷 정보 */
    public static final int BUCKET_LIST  = 2004;
    /**  댓글 정보 */
    public static final int COMMENT_LIST  = 2005;
    /**  댓글 추가 */
    public static final int INSERT_COMMENT  = 2006;
    /**  공지 사항  */
    public static final int NOTICE_LIST  = 2007;
    /**  사용자 정보 업데이트*/
    public static final int UPDATE_USER  = 2008;
    /**  이미지 다운로드*/
    public static final int DOWNLOAD_IMAGE  = 2009;
    /**  AI*/
    public static final int REQUEST_AI  = 2010;
    /**  랭킹 리스트*/
    public static final int RANK_LIST  = 2011;
    /**  랭킹 의견 업데이트*/
    public static final int RANK_UPDATE_COMMENT  = 2012;
    /**  DB 업로드 */
    public static final int UPLOAD_DB  = 2013;
    /**  채팅 내용 전송 */
    public static final int INSERT_CHAT  = 2014;
    /**  채팅 내용 조회 */
    public static final int SELECT_CHAT  = 2015;
}
