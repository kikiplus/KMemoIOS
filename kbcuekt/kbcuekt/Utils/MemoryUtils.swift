
/***
 * @author grapegirl
 * @version 1.1
 * @Class Name : MemoryUtils.swift
 * @Description : 사운드 및 진동 관련 유틸
 * @since 2017.09.04
 */

class MemoryUtils{
    
    init() {
    }
    
     /***
     * 힙 메모리 출력 메소드
     * @param context 컨텍스트
     */
    public static func printMemory() -> Void {
//        var info = task_basic_info()
//        var count = mach_msg_type_number_t(sizeofValue(info))/4
//        let kerr: kern_return_t = withUnsafeMutablePointer(&info) {
//        task_info(mach_task_self_,
//            task_flavor_t(TASK_BASIC_INFO),
//            task_info_t($0),
//            &count)
//        }
//
//        if kerr == KERN_SUCCESS {
//            KLog.d(tag: "MemoryUtils", msg: "Memory in use (in bytes): \(info.resident_size)");
//            //     Log.d(context.getClass().getSimpleName(), "@@ ==============================================");
//            //     Log.d(context.getClass().getSimpleName(),  "@@ 힙사이즈 : " + Debug.getNativeHeapSize());
//            //     Log.d(context.getClass().getSimpleName(), "@@ 힙 Free 사이즈: " + Debug.getNativeHeapFreeSize());
//            //     Log.d(context.getClass().getSimpleName(),  "@@ 힙에 할당된 사이즈 : " + Debug.getNativeHeapAllocatedSize());
//            //     Log.d(context.getClass().getSimpleName(),  "@@ ==============================================");
//        }
//        else {
//            KLog.d(tag: "MemoryUtils", msg: "Error with task_info(): " +
//                (String.fromCString(mach_error_string(kerr)) ?? "unknown error"));
//            }
    }
}
