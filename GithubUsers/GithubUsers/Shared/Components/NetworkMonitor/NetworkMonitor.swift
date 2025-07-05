//
//  NetworkMonitor.swift
//  GithubUsers
//
//  Created by Vikas Kumar on 04/07/25.
//

import Network

class NetworkMonitor {

    static let shared = NetworkMonitor()

    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")

    private(set) var isConnected: Bool = false

    private init() {}
    
    func startMonitoring() {
        monitor.pathUpdateHandler = { path in
            self.isConnected = (path.status == .satisfied)
            debugPrint("Network Status Changed: \(self.isConnected ? "Connected" : "Disconnected")")
        }
        monitor.start(queue: queue)
    }
    
    func stopMonitoring() {
        monitor.cancel()
    }
}
