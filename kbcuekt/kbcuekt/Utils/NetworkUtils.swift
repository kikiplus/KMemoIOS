
/***
 * @author grapegirl
 * @version 1.1
 * @Class Name : NetworkUtils.swift
 * @Description : 네트워크 연결 관련 유틸
 * @since 2017.09.04
 */

import Foundation
import SystemConfiguration

class NetworkUtils{
    
    init() {
    }

    public static let TYPE_WIFI : Int = 1
    public static let TYPE_MOBILE : Int = 2
    public static let TYPE_NOT_CONNECTED : Int = 0
    
    public static func getConnectivityStatus() -> Int {        
//        guard let status = Network.reachability?.status else { return TYPE_NOT_CONNECTED }
//        print("Reachability Summary")
//        print("Status:", status)
//        print("HostName:", Network.reachability?.hostname ?? "nil")
//        print("Reachable:", Network.reachability?.isReachable ?? "nil")
//        print("Wifi:", Network.reachability?.isReachableViaWiFi ?? "nil")
//        
//        switch status {
//        case .unreachable:
//            return TYPE_NOT_CONNECTED
//        case .wifi:
//            return TYPE_WIFI
//        case .wwan:
//            return TYPE_MOBILE
//            
//        }
        return 0 
    }

    public static func isConnectivityStatus() -> Bool {
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)
        
        return ret
    }
}
