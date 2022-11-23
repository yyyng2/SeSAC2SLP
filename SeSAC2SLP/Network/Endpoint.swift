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
    case mypage(searchable: Int, ageMin: Int, ageMax: Int, gender: Int, study: String)
    case myQueueState
    case queue(lat: Double, long: Double, studylist: String)        //   'studylist[]': 'anything' }
    case stopQueue
    case searchQueue(lat: Double, long: Double)
}

extension SeSACAPI {
    var baseURL: String {
        return "http://api.sesac.co.kr:1210/v1"
    }
                   
    var path: URL {
        switch self {
        case .signUp:
            return URL(string: baseURL+"/user")!
        case .login:
            return URL(string: baseURL+"/user")!
        case .withDraw:
            return URL(string: baseURL+"/user/withdraw")!
        case .updateFcmToken:
            return URL(string: baseURL+"/user/update_fcm_token")!
        case .mypage:
            return URL(string: baseURL+"/user/mypage")!
        case .myQueueState:
            return URL(string: baseURL+"/queue/myQueueState")!
        case .queue:
            return URL(string: baseURL+"/queue")!
        case .stopQueue:
            return URL(string: baseURL+"/queue")!
        case .searchQueue:
            return URL(string: baseURL+"/queue/search")!
        }
    }
    
    var headers: HTTPHeaders {
        switch self {
        case .signUp:
            return [
                "idtoken":"\(User.IDToken)",
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
            return [
                "lat" : lat,
                "long" : long,
                "studylist" : studylist
      
            ]
        case .searchQueue(let lat, let long):
            return [
                "lat" : lat,
                "long" : long
            ]
        case .mypage(let searchable, let ageMin, let ageMax, let gender, let study):
            return [
                "searchable" : searchable,
                "ageMin" : ageMin,
                "ageMax" : ageMax,
                "gender" : gender,
                "study" : study
            ]
        default:
            return ["":""]
        }
    }
    
}
