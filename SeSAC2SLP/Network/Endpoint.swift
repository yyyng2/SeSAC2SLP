//
//  Endpoint.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/13.
//

import Foundation

import Alamofire
import FirebaseAuth

enum SeSACAPI {
    case signUp(phoneNumber: String, FCMtoken: String, nick: String, birth: String, email: String, gender: Int)
    case login
    case withDraw
    case updateFcmToken(FCMtoken: String)
    case myQueueState
    case queue(lat: Double, long: Double, studylist: [String])
    case stopQueue
    case searchQueue(lat: Double, long: Double)
}

extension SeSACAPI {
    var url: URL {
        switch self {
        case .signUp:
            return URL(string: "http://api.sesac.co.kr:1207/v1/user")!
        case .login:
            return URL(string: "http://api.sesac.co.kr:1207/v1/user")!
        case .withDraw:
            return URL(string: "http://api.sesac.co.kr:1207/v1/user/withdraw")!
        case .updateFcmToken:
            return URL(string: "http://api.sesac.co.kr:1207/v1/user/update_fcm_token")!
        case .myQueueState:
            return URL(string: "http://api.sesac.co.kr:1207/v1/queue/myQueueState")!
        case .queue:
            return URL(string: "http://api.sesac.co.kr:1207/v1/queue")!
        case .stopQueue:
            return URL(string: "http://api.sesac.co.kr:1207/v1/queue")!
        case .searchQueue:
            return URL(string: "http://api.sesac.co.kr:1207/v1/queue/search")!
        }
    }
    
    var headers: HTTPHeaders {
        switch self {
        case .signUp:
            return [
                "idtoken":"\(User.IDToken)",
                "Content-Type":"application/x-www-form-urlencoded"
            ]
        case .withDraw:
            return [
                "Authorization": "Bearer \(UserDefaults.standard.string(forKey: "token")!)",
                "Content-Type":"application/x-www-form-urlencoded"
            ]
        default:
            return ["idtoken":"\(User.IDToken)"]
        }
    }
    
    var parameters: [String: Any] {
        switch self {
        case .signUp(let phoneNumber, let FCMtoken, let nick, let birth, let email, let gender):
           return [
                "phoneNumber" : phoneNumber,
                "FCMtoken" : FCMtoken,
                "nick" : nick,
                "birth" : birth,
                "email" : email,
                "gender" : gender
            ]
        case .updateFcmToken(let FCMToken):
            return ["FCMtoken" : FCMToken]
        case .queue(let lat, let long, let studylist):
            return ["lat" : lat, "long": long, "studylist": studylist]
        case .searchQueue(let lat, let long):
            return ["lat" : lat, "long": long]
        default:
            return ["":""]
        }
    }
    
}
