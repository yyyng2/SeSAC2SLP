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
        }
    }
    
    var headers: HTTPHeaders {
        switch self {
        case .signUp:
            return [
                "idtoken":"\(User.IDToken)",
                "Content-Type":"application/x-www-form-urlencoded"
            ]
        case .login:
            return ["idtoken":"\(User.IDToken)"]
        case .withDraw:
            return [
                "Authorization": "Bearer \(UserDefaults.standard.string(forKey: "token")!)",
                "Content-Type":"application/x-www-form-urlencoded"
            ]
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
        default:
            return ["":""]
        }
    }
    
}
