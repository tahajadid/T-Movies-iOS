//
//  Network.swift
//  T-Movies-iOS
//
//  Created by Taha JADID on 28/2/2023.
//

import Foundation
import Network

class Network {

    static let monitor = NWPathMonitor()
    /*
     Get network state if user is connected to internet or not
     */
    static func getNetworkState(completion: @escaping((_ success: Bool) -> Void)) {
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
               completion(true)
            } else {
                completion(false)
            }
        }
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
    }
}
