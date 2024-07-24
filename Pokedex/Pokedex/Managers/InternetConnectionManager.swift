//
//  InternetConnectionManager.swift
//  Pokedex
//
//  Created by David Felipe Cortes Gonzalez on 23/07/24.
//

import Foundation
import Network

struct RequestRetry {
    var request: URLRequest
    var completion: ((Data?, HTTPURLResponse?, NSError?) -> Void)?
}

class InternetConnectionManager {

    static let shared: InternetConnectionManager = {
        return InternetConnectionManager()
    }()
    
    private var monitor: NWPathMonitor?
    private var monitorQueue = DispatchQueue(label: "NetworkMonitor")
    private var requests: [RequestRetry] = []
    
    init() {
        startMonitoring()
    }
    
    deinit {
        stopMonitoring()
    }
    
    func add(retryRequest: RequestRetry) {
        requests.append(retryRequest)
        startMonitoring()
    }
    
    func checkInternetConnection(completion:@escaping (Bool) -> () = {_ in}) {
        let monitor = NWPathMonitor()
        
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                DispatchQueue.main.async {
                    completion(true)
                }
                self.onConnectionEstablished()
            } else {
                
                DispatchQueue.main.async {
                    completion(false)
                }
            }
            monitor.cancel()
        }
        
        let queue = DispatchQueue(label: "NetworkMonitorOnce")
        monitor.start(queue: queue)
    }
    
    private func startMonitoring() {
        monitor = NWPathMonitor()
        
        monitor?.pathUpdateHandler = { [weak self] path in
            guard let self = self else { return }
            
            if path.status == .satisfied {
                self.onConnectionEstablished()
            }
        }
        
        monitor?.start(queue: monitorQueue)
    }
    
    private func stopMonitoring() {
        monitor?.cancel()
    }
    
    private func onConnectionEstablished(){
        guard !requests.isEmpty else { return }
        
        for request in requests {
            NetworkEngine.requestGeneric(request: request.request, completion: request.completion)
        }
        
        requests.removeAll()
    }
    
}
