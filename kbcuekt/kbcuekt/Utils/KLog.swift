
/***
 * @author grapegirl
 * @version 1.1
 * @Class Name : KLog.swift
 * @Description : Log 클래스
 * @since 2017.08.20
 */

class KLog{
    
    public static var VIEW_LOG = false
    
    init() {
       
    }
    
    public static func setLogging(isDebugging : Bool) -> Void {
        VIEW_LOG = isDebugging;
    }

    public static func d(tag : String, msg : String) -> Void {
        if (VIEW_LOG == true){
            print(tag, " @@ "  + msg);
        }
    }

}
