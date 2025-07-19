//
//  Connectivity.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 21.07.2025.
//

// Connectivity.swift
import Network
import Observation
import Foundation

@Observable
final class Connectivity {
    static let shared = Connectivity()

    
    private(set) var isReachable = false
    
    private let monitor = NWPathMonitor()
    private let queue   = DispatchQueue(label: "Connectivity")

    private init() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isReachable = path.status == .satisfied
        }
        monitor.start(queue: queue)
    }
}
