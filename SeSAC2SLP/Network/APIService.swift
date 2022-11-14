//
//  APIService.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/13.
//

import UIKit

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



class APIService {
    
   
    
    func signUp(completionHandler: @escaping (Int) -> Void) {
       
        let api = SeSACAPI.signUp(phoneNumber: User.phoneNumber, FCMtoken: User.fcm, nick: User.nickname, birth: User.birth, email: User.email, gender: User.gender)
        
        AF.request(api.url, method: .post, parameters: api.parameters, headers: api.headers).responseString { response in
            print(response, response.response?.statusCode)
   
            guard let statusCode = response.response?.statusCode else { return }
            completionHandler(statusCode)
        }
    }

    func login(completionHandler: @escaping (Int) -> Void) {

        let api = SeSACAPI.login

        AF.request(api.url, method: .get, parameters: api.parameters, headers: api.headers).validate(statusCode: 200...299).responseDecodable(of: Login.self) { response in
            
            //로그인 후 필요 정보 여기서 관리할 것
            
            guard let statusCode = response.response?.statusCode else { return }
            completionHandler(statusCode)
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
    
    func updateFcmToken() {
        let api = SeSACAPI.updateFcmToken(FCMtoken: User.fcm)
        
        AF.request(api.url, method: .put, parameters: api.parameters, headers: api.headers).response { response in
            print(User.fcm)
            switch response.result {
            case .success(let data):
                print(response.response?.statusCode)
            case .failure(let error):
                print(response.response?.statusCode)
                
            }
        }
    }
    
    func reactLoginAPI(value: Int) {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        
        switch LoginCode(rawValue: value) {
        case .success:
            let rootViewController = TabBarController()
            let navigationController = UINavigationController(rootViewController: rootViewController)
            sceneDelegate?.window?.rootViewController = navigationController
        case .firebaseTokenError:
            if User.phoneNumber.count > 3 {
                let rootViewController = AuthenticationViewController()
                let navigationController = UINavigationController(rootViewController: rootViewController)
                sceneDelegate?.window?.rootViewController = navigationController
            } else {
                let rootViewController = OnboardingViewController()
                let navigationController = UINavigationController(rootViewController: rootViewController)
                sceneDelegate?.window?.rootViewController = navigationController
            }
        case .notMember:
            let rootViewController = NicknameCheckViewController()
            let navigationController = UINavigationController(rootViewController: rootViewController)
            sceneDelegate?.window?.rootViewController = navigationController
        case .serverError:
            print("serverError")
        case .clientError:
            if User.phoneNumber.count > 3 {
                let rootViewController = AuthenticationViewController()
                let navigationController = UINavigationController(rootViewController: rootViewController)
                sceneDelegate?.window?.rootViewController = navigationController
            } else {
                let rootViewController = OnboardingViewController()
                let navigationController = UINavigationController(rootViewController: rootViewController)
                sceneDelegate?.window?.rootViewController = navigationController
            }
        case .none:
            break
        }
    }
    
    func reactSignAPI(value: Int) {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        
        switch SignCode(rawValue: value) {
        case .success:
            let rootViewController = TabBarController()
            let navigationController = UINavigationController(rootViewController: rootViewController)
            sceneDelegate?.window?.rootViewController = navigationController
        case .already:
            let rootViewController = TabBarController()
            let navigationController = UINavigationController(rootViewController: rootViewController)
            sceneDelegate?.window?.rootViewController = navigationController
        case .badNickname:
            let rootViewController = NicknameCheckViewController()
            rootViewController.nicknameStatus = true
            let navigationController = UINavigationController(rootViewController: rootViewController)
            sceneDelegate?.window?.rootViewController = navigationController
        case .firebaseTokenError:
            if User.phoneNumber.count > 3 {
                let rootViewController = AuthenticationViewController()
                let navigationController = UINavigationController(rootViewController: rootViewController)
                sceneDelegate?.window?.rootViewController = navigationController
            } else {
                let rootViewController = OnboardingViewController()
                let navigationController = UINavigationController(rootViewController: rootViewController)
                sceneDelegate?.window?.rootViewController = navigationController
            }
        case .notMember:
            let rootViewController = NicknameCheckViewController()
            let navigationController = UINavigationController(rootViewController: rootViewController)
            sceneDelegate?.window?.rootViewController = navigationController
        case .serverError:
            print("serverError")
        case .clientError:
            if User.phoneNumber.count > 3 {
                let rootViewController = AuthenticationViewController()
                let navigationController = UINavigationController(rootViewController: rootViewController)
                sceneDelegate?.window?.rootViewController = navigationController
            } else {
                let rootViewController = OnboardingViewController()
                let navigationController = UINavigationController(rootViewController: rootViewController)
                sceneDelegate?.window?.rootViewController = navigationController
            }
        case .none:
            break
        }
    }
    
}
