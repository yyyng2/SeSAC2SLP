//
//  APIService.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/13.
//

import Foundation

import Alamofire

struct Login: Codable {
    let _id: String
    let __v: Int
    let uid: String
    let phoneNumber: String
    let email: String
    let FCMtoken: String
    let nick: String
    let birth: String
    let gender: Int
    let study: String
    let comment: [String]
    let reputation: [Int]
    let sesac: Int
    let sesacCollection: [Int]
    let background: Int
    let backgroundCollection: [Int]
    let purchaseToken: [String]
    let transactionId: [String]
    let reviewedBefore: [String]
    let reportedNum: Int
    let reportedUser: [String]
    let dodgepenalty: Int
    let dodgeNum: Int
    let ageMin: Int
    let ageMax: Int
    let searchable: Int
    let createdAt: String
}

struct WithDraw: Codable {
    let token: String
}

struct UserInfo: Codable {
    let photo: String
    let email: String
    let username: String
}

enum SeSACError: Int, Error {
    case invalidAuthorization = 401
    case takenEmail = 406
    case emptyParameters = 501
}

extension SeSACError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidAuthorization:
            return "토큰이 만료됐습니다. 다시 로그인 해주세요."
        case .takenEmail:
            return "이미 가입된 회원입니다. 로그인 해주세요."
        case .emptyParameters:
            return "파라미터가 없습니다."
        }
    }
}

class APIService {
    
   
    
    func signUp() {

        let api = SeSACAPI.signUp(phoneNumber: User.phoneNumber, FCMtoken: User.fcm, nick: User.nickname, birth: User.birth, email: User.email, gender: User.gender)
        AF.request(api.url, method: .post, parameters: api.parameters, headers: api.headers).responseString { response in
            print(response, response.response?.statusCode)

            switch response.result {

            case .success(let data):
                print(data)
                
            case .failure(_):
                print("Sign error")
                print(response.response?.statusCode)
            }
        }
    }

    func login() {

        let api = SeSACAPI.login

        AF.request(api.url, method: .get, parameters: api.parameters, headers: api.headers).validate(statusCode: 200...299).responseDecodable(of: Login.self) { response in
            switch response.result {

            case .success(let data):
                print(data.birth)
//                UserDefaults.standard.set(data.token, forKey: "token")
            case .failure(_):
                print(response, response.response?.statusCode)
            }
        }
    }

    func withDraw() {
        let api = SeSACAPI.withDraw

        AF.request(api.url, method: .post, headers: api.headers).responseDecodable(of: WithDraw.self) { response in
            switch response.result {

            case .success(let data):
                print(data)
            case .failure(_):
                print(response, response.response?.statusCode)
            }
        }
    }
    
   
    
}
