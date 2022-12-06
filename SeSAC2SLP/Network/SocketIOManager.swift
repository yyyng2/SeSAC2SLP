//
//  SocketIOManager.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/12/05.
//

import Foundation

import SocketIO

class SocketIOManager {
    
    static let shared = SocketIOManager()
    
    // 서버와 메세지를 주고받기 위한 클래스
    var manager: SocketManager!
    
    var socket: SocketIOClient!
    
    private init() {
        
        manager = SocketManager(socketURL: URL(string: SeSACAPI.baseURL.baseURL)!, config: [
            .forceWebsockets(true)
        ])
        
        socket = manager.defaultSocket // hettp://api.sesac.co.kr:2022/ + socketid
        
        //connect
        socket.on(clientEvent: .connect) { data, ack in
            print("Socket is connected", data, ack)
            self.socket.emit("changesocketid", User.uid)
        }
        //disconnect
        socket.on(clientEvent: .disconnect) { data, ack in
            print("SOCKET IS DISCONNECTED", data, ack)
        }
        //On event
        socket.on("chat") { dataArray, ack in
            print("SESAC RECEIVED", dataArray, ack)
            
            let data = dataArray[0] as! NSDictionary
            let chat = data["chat"] as! String
            let createdAt = data["createdAt"] as! String
            let from = data["from"] as! String
            let to = data["to"] as! String
            
            
            print("Check", chat, createdAt)
            
            NotificationCenter.default.post(name: NSNotification.Name("getMessage"), object: self, userInfo: ["chat": chat, "createdAt": createdAt, "from": from, "to": to])
        }
    }
    
    func establishConnection() {
        socket.connect()
    }
    
    func closeConnetcion() {
        socket.disconnect()
    }
}
