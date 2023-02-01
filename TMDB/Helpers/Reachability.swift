//
//  Reachability.swift
//  TMDB
//
//  Created by Huseyin Akcay on 1.02.2023.
//

import SystemConfiguration

class Reachability {
    class func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in(
            sin_len: .zero
            , sin_family: .zero
            , sin_port: .zero
            , sin_addr: in_addr(s_addr: .zero)
            , sin_zero: (.zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero)
        )
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)

        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(
                to: sockaddr.self,
                capacity: 1
            ) { zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }

        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: .zero)
        if SCNetworkReachabilityGetFlags(
            defaultRouteReachability!,
            &flags
        ) == false {
            return false
        }

        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != .zero
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != .zero
        let isConnectedToNetwork = (isReachable && !needsConnection)

        return isConnectedToNetwork
    }
}
