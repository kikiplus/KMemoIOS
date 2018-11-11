
/***
 * @author grapegirl
 * @version 1.1
 * @Class Name : ContextUtils.swift
 * @Description : ContextUtils 클래스
 * @since 2017.09.04
 */

class ContextUtils{
    
    init() {
       
    }
    
   
    /**
     * 운영 배포시 false
     * 개발 로그 true시 보임
     */
    public static var VIEW_LOG : Bool = false
    /**
     * 버전 명
     */
    public static let VERSION_NAME : String = "2.0.03"
    /**
     * 공통 태그
     **/
    public static var TAG : String = "KMemo"

    /**************************************************************************
     *
     * Shared Preference
     *
     * ***********************************************************************/

    /**
     * 프리퍼런스 이름
     */
    public static let KEY_PREFER_NAME : String = "APP_PRF_NAME"
    
    /**
     * 프리퍼런스 이름(환경설정_비밀번호)
     */
    public static let KEY_CONF_PASSWORD : String = "KEY_CONF_PASSWORD"
    
    /**
     * 프리퍼런스 이름(환경설정_닉네임)
     */
    public static let KEY_USER_NICKNAME : String = "KEY_USER_NICKNAME"

    /**
     * 프리퍼런스 이름(GCM 키)
     */
    public static let KEY_USER_GCM : String = "KEY_USER_GCM"

    /**
     * 프리퍼런스 이름(FCM 키)
     */
    public static let KEY_USER_FCM : String = "KEY_USER_FCM"

    /**
     * 프리퍼런스 이름(MEMO)
     */
    public static let KEY_USER_MEMO : String = "KEY_USER_MEMO"     

    /**************************************************************************
     *
     * Activity 별 상수 정의
     *
     * ***********************************************************************/

    /**
     * 가지 작성 화면
     */
    public static let VIEW_WRITE : String = "WriteActivity"     
    
    /**
     * 완료된 가지 목록 화면
     */
    public static let VIEW_COMPLETE_LIST : String = "BucketListView"
    
    /**
     * 버킷 공유(Life)
     */
    public static let DEFULAT_SHARE_BUCKET_IDX : String = "1"     
    
    /**
     * 공유 idx
     */
    public static let NUM_SHARE_BUCKET_IDX : String = "SHARE_BUCKET_IDX"     
    
    /**
     * 공유 bucket
     */
    public static let OBJ_SHARE_BUCKET : String = "OBJ_SHARE_BUCKET"     
    
    //상수들
    public static let WIDGET_WRITE_BUCKET : String = "WRITE"     
    public static let WIDGET_BUCKET_LIST : String = "LIST"     
    public static let WIDGET_SHARE : String = "SHARE"     
    public static let WIDGET_OURS_BUCKET : String = "OURS_BUCKET"     
    public static let WIDGET_SEND_DATA : String = "WIDGET_SEND_DATA"     

    public static let SORT_DATE : String = "SORT_DATE"     
    public static let SORT_MEMO : String = "SORT_MEMO"     
    public static let SORT_DEADLINE : String = "SORT_DEADLINE"     
    public static let BACK_MEMO : String = "BACK_MEMO"     

    public static let MAIN_VIEW : String = "ViewController"
    public static let SHARE_VIEW : String = "ShareListView"
    public static let WRITE_VIEW : String = "WriteView"
    public static let BUCKET_LIST_VIEW : String = "BucketListView"
    public static let SET_NICKNAME_VIEW : String = "SetNickNameView"

    /**************************************************************************
     *
     * Application 상수 정의
     *
     * ***********************************************************************/

    /**
     * 패키지명
     */
    public static let PACKAGE_NAME : String = "momo.kikiplus.com.kbucket"     
    

    /**
     * 파일 저장 장소(폴더명)
     */
    public static let KEY_FILE_FOLDER : String = "KMemo"     
    
    /**
     * GCM 프로젝트 아이디
     */
    public static let KEY_GCM_PROJECT_ID : String = "343963170350"     
    
    /**
     * 데이터베이스 이름명
     */
    public static let KBUCKET_DB_NAME : String = "bucket.db"     
    
    /**
     * 구글 Ads ID
     */
    public static let KBUCKET_AD_UNIT_ID : String = "ca-app-pub-9950741145331464/4170271439"     
    
    /**
     * Sort
     */
    public static let KBUCKET_SORT_KEY : String = "KBUCKET_SORT"     
    

    /**************************************************************************
     *
     * Application I/O 정의
     *
     * ***********************************************************************/

    /**
     * 서버 IP
     */
    public static let KBUCKET_SERVER_IP : String = "http://kikiplus.cafe24.com"
    
    /**
     * 버전 업데이트 URL
     */
    public static let KBUCKET_VERSION_UPDATE_URL : String = KBUCKET_SERVER_IP + "/mobile/version.jsp"
    
    /**
     * 가지 공유하기 URL
     */
    public static let KBUCKET_INSERT_BUCKET_URL : String = KBUCKET_SERVER_IP + "/mobile/insertBucket.jsp"

    /**
     * 가지 파일 업로드 URL
     */
    public static let KBUCKET_UPLOAD_IMAGE_URL : String = KBUCKET_SERVER_IP + "/mobile/uploadFile.jsp"

    /**
     * category URL
     */
    public static let KBUCKET_CATEGORY_URL : String = KBUCKET_SERVER_IP + "/mobile/category.jsp"

    /**
     * 버킷 리스트 URL
     */
    public static let KBUCKET_BUCKET_LIST_URL : String = KBUCKET_SERVER_IP  + "/mobile/bucketList.jsp"

    /**
     * 버킷 상세 URL
     */
    public static let KBUCKET_BUCKET_DETAIL_URL : String = KBUCKET_SERVER_IP + "/mobile/bucketInfo.jsp"

    /**
     * 버킷 댓글 URL
     */
    public static let KBUCKET_COMMENT_URL : String = KBUCKET_SERVER_IP + "/mobile/comment.jsp"

    /**
     * 버킷 댓글 업로드 URL
     */
    public static let INSERT_COMMENT_URL : String = KBUCKET_SERVER_IP + "/mobile/insertComment.jsp"
    
    /**
     * 공지사항URL
     */
    public static let KBUCKET_NOTICE_URL : String = KBUCKET_SERVER_IP +  "/mobile/update.jsp"
    
    /**
     * 사용자 정보 업데이트 URL
     */
    public static let KBUCKET_UPDATE_USER : String = KBUCKET_SERVER_IP + "/mobile/insertMobileUser.jsp"
    
    /**
     * 이미지 다운로드 URL
     */
    public static let KBUCKET_DOWNLOAD_IAMGE : String = KBUCKET_SERVER_IP +  "/mobile/downloadFile.jsp"
    
    /**
     * 이미지 다운로드 URL
     */
    public static let KBUCKET_AI : String = KBUCKET_SERVER_IP + "/mobile/getAIReplay.jsp"
    
    /**
     * 버킷랭킹 리스트 URL
     */
    public static let KBUCKET_RANK_LIST_URL : String = KBUCKET_SERVER_IP + "/mobile/bucketRankList.jsp"
    
    /**
     * 버킷랭킹 정보 업데이트
     */
    public static let KBUCKET_RANK_COMMENT : String = KBUCKET_SERVER_IP + "/mobile/bucketRankComment.jsp"
    
    /**
     * 가지 파일 업로드 URL
     */
    public static let KBUCKET_UPLOAD_DB_URL : String = KBUCKET_SERVER_IP  + "/mobile/uploadDBFile.jsp"
    
    /**
     * 채팅 내용 전송 URL
     */
    public static let INSERT_CHAT : String = KBUCKET_SERVER_IP  + "/chat/chat.jsp"
    
    /**
     * 채팅 내용 조회 URL
     */
    public static let SELECT_CHAT : String = KBUCKET_SERVER_IP  + "/chat/loadChat.jsp"
    
    /**
     * 관리자 블로그 주소
     */
    public static let KBUCKET_BLOG : String = "http://blog.naver.com/kikiplus2030"

    /**
     * Anayltics 키값
     */
    public static let KEY_ANALYTICS : String = "UA-86096322-1"

}
