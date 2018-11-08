
/***
 * @author grapegirl
 * @version 1.1
 * @Class Name : ErrorLogUtils.swift
 * @Description : ErrorLogUtils 클래스
 * @since 2017.09.04
 */
import Foundation

class ErrorLogUtils {
    
    init() {    
    }

    public static let ERROR_FILE : String = "/KMemo/ErrorLog"

    /**
     * 로그 파일 생성
     *
     * @param error
     */
    public static func saveFileEror( text : String, file : String) {
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
        let fileURL = dir.appendingPathComponent(file)

            //writing
            do {
                try text.write(to: fileURL, atomically: false, encoding: .utf8)
            }
            catch {
                /* error handling here */
            }
        }
    }
}
