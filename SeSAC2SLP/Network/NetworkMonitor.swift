//
//  NetworkMonitor.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/15.
//

//import UIKit
//import Network
//
//final class NetworkMonitor{
//    static let shared = NetworkMonitor()
//    
//    private let queue = DispatchQueue.global()
//    private let monitor: NWPathMonitor
//    public private(set) var isConnected:Bool = false
//    public private(set) var connectionType:ConnectionType = .unknown
//    
//    /// 연결타입
//    enum ConnectionType {
//        case wifi
//        case cellular
//        case ethernet
//        case unknown
//    }
//    
//    private init(){
//        print("init 호출")
//        monitor = NWPathMonitor()
//    }
//    
//    public func startMonitoring(completion: @escaping (Bool?) -> Bool) {
//        print("startMonitoring 호출")
//        monitor.start(queue: queue)
//        monitor.pathUpdateHandler = { [weak self] path in
//            print("path :\(path)")
//
//            self?.isConnected = path.status == .satisfied
//            self?.getConenctionType(path)
//            
//            completion(self?.isConnected)
//           
//        }
//    }
//    
//    public func stopMonitoring(){
//        print("stopMonitoring 호출")
//        monitor.cancel()
//    }
//    
//    
//    private func getConenctionType(_ path:NWPath) {
//        print("getConenctionType 호출")
//        if path.usesInterfaceType(.wifi){
//            connectionType = .wifi
//            print("wifi에 연결")
//
//        }else if path.usesInterfaceType(.cellular) {
//            connectionType = .cellular
//            print("cellular에 연결")
//
//        }else if path.usesInterfaceType(.wiredEthernet) {
//            connectionType = .ethernet
//            print("wiredEthernet에 연결")
//
//        }else {
//            connectionType = .unknown
//            print("unknown ..")
//        }
//    }
//    
//}
