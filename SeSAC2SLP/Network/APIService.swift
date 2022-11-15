//
//  APIService.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/13.
//

import UIKit

import Alamofire

class APIService {
    
   
    
    func signUp(completionHandler: @escaping (Int) -> Void) {
       
        AuthenticationManager.shared.updateIdToken()
        updateFcmToken()
        
        let api = SeSACAPI.signUp(phoneNumber: User.phoneNumber, FCMtoken: User.fcm, nick: User.nickname, birth: User.birth, email: User.email, gender: User.gender)
        
        AF.request(api.url, method: .post, parameters: api.parameters, headers: api.headers).responseString { response in
            print(response, response.response?.statusCode)
   
            guard let statusCode = response.response?.statusCode else { return }
            completionHandler(statusCode)
        }
    }

    func login(completionHandler: @escaping (Int) -> Void) {

        let api = SeSACAPI.login

        AuthenticationManager.shared.updateIdToken()
        updateFcmToken()
        
        AF.request(api.url, method: .get, parameters: api.parameters, headers: api.headers).responseDecodable(of: Login.self) { response in

            switch response.result {
            case .success(let data):
                print(data)
                //로그인 후 필요 정보 여기서 관리할 것
                
                guard let data = response.value else { return }
                
                User.sesac = data.sesac
                User.sesacCollection = data.sesacCollection
                User.background = data.background
                User.backgroundCollection = data.backgroundCollection
                User.signedName = data.nick
                User.reputation = data.reputation
                User.comment = data.comment
                
                guard let statusCode = response.response?.statusCode else { return }
                print(statusCode)
                completionHandler(statusCode)
                
            case .failure(let error):
                print(error)
                completionHandler(401)
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
    
    func updateFcmToken() {
        let api = SeSACAPI.updateFcmToken(FCMtoken: User.fcm)
        
        AF.request(api.url, method: .put, parameters: api.parameters, headers: api.headers).response { response in
            print(User.fcm)
            switch response.result {
            case .success(let data):
                print(response.response?.statusCode)
            case .failure(let error):
                guard let errorCode = error.responseCode else { return }
               
//                let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
//                let sceneDelegate = windowScene?.delegate as? SceneDelegate
//
//                if User.IDToken.count > 3 {
//                    let rootViewController = AuthenticationViewController()
//                    let navigationController = UINavigationController(rootViewController: rootViewController)
//                    sceneDelegate?.window?.rootViewController = navigationController
//                } else {
//                    let rootViewController = OnboardingViewController()
//                    let navigationController = UINavigationController(rootViewController: rootViewController)
//                    sceneDelegate?.window?.rootViewController = navigationController
//                }
                
              
                
            }
        }
    }
    
    func reactLoginAPI(value: Int) {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        
        switch LoginCode(rawValue: value) {
        case .success:
            updateFcmToken()
            print(value)
            let rootViewController = TabBarController()
//            let navigationController = UINavigationController(rootViewController: rootViewController)
            sceneDelegate?.window?.rootViewController = rootViewController
        case .firebaseTokenError:
            print(value)
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
            print(value)
            let rootViewController = NicknameCheckViewController()
            let navigationController = UINavigationController(rootViewController: rootViewController)
            sceneDelegate?.window?.rootViewController = navigationController
        case .serverError:
            print("serverError")
        case .clientError:
            print(value)
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
            AuthenticationManager.shared.updateIdToken()
            updateFcmToken()
            let rootViewController = TabBarController()
            sceneDelegate?.window?.rootViewController = rootViewController
        case .already:
            AuthenticationManager.shared.updateIdToken()
            updateFcmToken()
            let rootViewController = TabBarController()
            sceneDelegate?.window?.rootViewController = rootViewController
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
