
/***
 * @author grapegirl
 * @version 1.1
 * @Class Name : DateUtils.swift
 * @Description : DateUtils 클래스
 * @since 2017.09.04
 */
import Foundation

class DateUtils {
    
    init() {
    }
    
    public static let KBUCKET_MEMO_DATE_PATTER : String = "yyyy-MM-dd HH:mm:ss"
    public static let KBUCKET_DB_DATE_PATTER : String = "yyyyMMddHHmmss"
    public static let DATE_YYMMDD_PATTER : String = "yyyy-MM-dd"
    public static let DATE_YYMMDD_PATTER2 : String = "yyyyMMdd"

    public static let STRING_TIME_PATTERN : String = "yyyy-MM-dd"
    public static let STRING_DATETIME_PATTERN : String = "HH"
    public static let STRING_TIME_YYMMDD : String = "yy.MM.dd"
    public static let STRING_TIME_YYYYMMDDHHMMSS : String = "yyyy-MM-dd HH:mm:ss"


    /**
     * 날짜 출력 포맷에 맞게 반환 메소드
     *
     * @param pattern 출력 패턴
     * @return 날자 출력 포맷에 맞는 오늘 날짜 문자열 반환
     */
    public static func getStringDateFormat(pattern : String) -> String {
        let todayDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = pattern
        let someDate = formatter.string(from: todayDate)
        return someDate
    }

    /**
     * 날짜 형식에 맞게 날짜 변환후 비교
     *
     * @param pattern 날짜 형식
     * @param date1
     * @param date2
     * @return 0 같음, 1 date1이 date2보다 최신일, -1은date1이 date2 보다 과거
     */
    public static func getCompareDate(pattern : String, date1 : String, date2 : String) -> Int {
        let formatter = DateFormatter()
        formatter.dateFormat = pattern
        let compareDay1 = formatter.date(from: date1)
        let compareDay2 = formatter.date(from: date2)

        if compareDay1 == nil || compareDay2 == nil {
            return -2
        }

        if compareDay1! > compareDay2! {
            return 1
        }else if compareDay1! < compareDay2! {
            return -1
        }
        return 0
    }

    /**
    * 패턴 형식으로 날짜 계산 후 형식에 맞는 날짜 반환하기
    *
    * @param pattern yyyyMMdd
    * @param day
    * @return
    */
    public static func getDateFormat(pattern : String, day : Int) -> String {
        // Calendar calendar = Calendar.getInstance();
        // calendar.add(Calendar.DATE, day);
        // SimpleDateFormat sdf = new SimpleDateFormat(pattern);
        // return sdf.format(calendar.getTime());
        return ""
    }


    /**
    * 현재시간 출력 메소드
    *
    * @return 시분초ms 까지 출력
    */
    public static func getCurrentTimeHHMMSSMS() -> String {
        let todayDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        let someDate = formatter.string(from: todayDate)
        return someDate
    }

    

    /**
     * 원하는 패턴으로 시간 변경하기
     *
     * @param time 시간 String(YYYY-MM-DD HH:mm:ss)형식
     * @return 현재시간
     */
    public static func convertTime() -> String {
        let strTime = getStringDateFormat(pattern: STRING_TIME_YYYYMMDDHHMMSS)
        return strTime
    }

    
}
