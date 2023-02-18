//
//  Helper.swift
//  Cryato
//
//  Created by John Melody Me on 17/02/2023.
//

import Foundation

#if canImport(Network)
import Network
#endif

class Helper {
    public static var shared = Helper()
    
    lazy private var monitor = NWPathMonitor()
    
    public static func currentDate() throws -> String {
        return String(DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .short))
    }
    
    public func status() throws -> NetworkStatus {
        if self.monitor.currentPath.status == .satisfied {
            return NetworkStatus.CONNECTED
        }
        
        if self.monitor.currentPath.status == .unsatisfied{
            return NetworkStatus.DISCONNECTED
        }
        
        if self.monitor.currentPath.status == .requiresConnection {
            return NetworkStatus.RECONNECTING
        }
        
        return NetworkStatus.UNAVAILABLE
    }
    
    public func startNetworkReachability() throws -> Void {
        self.monitor.pathUpdateHandler = { path in
            NSLog(String(describing: path))
        }
        
        let queue = DispatchQueue.global(qos: .background)
        self.monitor.start(queue: queue)
    }
}
