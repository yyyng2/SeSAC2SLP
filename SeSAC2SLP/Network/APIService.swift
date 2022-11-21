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

        if User.isSigned == true {
            AuthenticationManager.shared.updateIdToken()
            updateFcmToken()
        }
        
        AF.request(api.url, method: .get, parameters: api.parameters, headers: api.headers).responseDecodable(of: Login.self) { response in
            guard let statusCode = response.response?.statusCode else { return }
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
                User.ageMin = data.ageMin
                User.ageMax = data.ageMax
                User.gender = data.gender
                User.searchable = data.searchable
                
           
                print("loginSuccess:",statusCode)
                completionHandler(statusCode)
                
            case .failure(let error):

                print("loginError:",statusCode)
                completionHandler(statusCode)
            }
            
          
        }
    }

    func withDraw(completionHandler: @escaping (Int) -> Void) {
        let api = SeSACAPI.withDraw
        
        AuthenticationManager.shared.updateIdToken()
        updateFcmToken()

        AF.request(api.url, method: .post, headers: api.headers).responseDecodable(of: WithDraw.self) { response in
            guard let statusCode = response.response?.statusCode else { return }
            switch response.result {
                
            case .success(let data):
                print(data)
                print("withDrawSuccess",data, statusCode)
                completionHandler(statusCode)
      
    
            case .failure(_):
                print("withDrawQueueError", statusCode)
                completionHandler(statusCode)
           
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

            }
        }
    }
    
    func mapageUpdate(searchable: Int, ageMin: Int, ageMax: Int, gender: Int, study: String, completionHandler: @escaping (Int) -> Void) {
        let api = SeSACAPI.mypage(searchable: searchable, ageMin: ageMin, ageMax: ageMax, gender: gender, study: study)
        
        AuthenticationManager.shared.updateIdToken()
        updateFcmToken()
        
        AF.request(api.url, method: .put, parameters: api.parameters, headers: api.headers).responseString { response in
            guard let code = response.response?.statusCode else { return }
            print("mapageUpdate:",code, api.url, api.headers,api.parameters)
            completionHandler(code)
        }
    }
    
    func requestQueueState(completionHandler: @escaping (Int) -> Void) {
        
        let api = SeSACAPI.myQueueState
        
        AuthenticationManager.shared.updateIdToken()
        updateFcmToken()

        AF.request(api.url, method: .get, parameters: api.parameters, headers: api.headers).responseDecodable(of: QueueState.self) { response in
            guard let statusCode = response.response?.statusCode else { return }
            switch response.result {
            case .success(let data):
                print(data)
                //로그인 후 필요 정보 여기서 관리할 것
                
                guard let data = response.value else { return }
                
                User.dodged = data.dodged
           
                User.reviewed = data.reviewed
                User.matchedNick = data.matchedNick
                User.matchedUid = data.matchedUid
    
                if statusCode == 200 {
                    User.matched = data.matched
                }
                completionHandler(statusCode)
                print("QueueStateSuccess:",statusCode)
//                completionHandler(statusCode)
                
            case .failure(let error):
                print("QueueStateError:",statusCode)
                if statusCode == 201 {
                    User.matched = 2
                }
                completionHandler(statusCode)
            }
            
        }
        
    }
    
    func requestSearchQueue(lat: Double, long: Double, completionHandler: @escaping (SearchInfo?, Int?) -> Void) {
        print("requestSearchQueue")
        let api = SeSACAPI.searchQueue(lat: lat, long: long)

        AuthenticationManager.shared.updateIdToken()
        updateFcmToken()
        
        AF.request(api.url, method: .post, parameters: api.parameters, headers: api.headers).responseDecodable(of: SearchInfo.self) { response in
            print("requestSearchQueue:",response)
            guard let statusCode = response.response?.statusCode else { return }
            switch response.result {
            case .success(let data):
                //로그인 후 필요 정보 여기서 관리할 것
          
                print("requestQueueSuccess",data, statusCode)
                completionHandler(data, statusCode)
                
            case .failure(let error):
                print("requestQueueError", "", statusCode)
                completionHandler(nil, statusCode)
            }
            
          
        }
    }
    
    func requestQueue(lat: Double, long: Double, studylist: [String], completionHandler: @escaping (Int) -> Void) {
        let api = SeSACAPI.queue(lat: lat, long: long, studylist: "\(studylist)")
        
        AuthenticationManager.shared.updateIdToken()
        updateFcmToken()
        
        AF.request(api.url, method: .post, parameters: api.parameters, headers: api.headers).responseString { response in
            guard let code = response.response?.statusCode else { return }
            print("requestQueueAPI:",code, api.url, api.headers,api.parameters)
            completionHandler(code)
        }
    }
    
    func stopQueueFinding(completionHandler: @escaping (Int) -> Void) {
        let api = SeSACAPI.stopQueue
        
        AuthenticationManager.shared.updateIdToken()
        updateFcmToken()
        
        AF.request(api.url, method: .delete, parameters: api.parameters, headers: api.headers).response { response in
            guard let code = response.response?.statusCode else { return }
            print("stopQueueFinding:",code, api.url, api.headers,api.parameters)
            completionHandler(code)

        }
    }

    
    func reactLoginAPI(value: Int) {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        print("reactLogin",value)
        switch LoginCode(rawValue: value) {
        case .success:
            updateFcmToken()
            User.isSigned = true
            print("success: Login")
            let rootViewController = TabBarController()
//            let navigationController = UINavigationController(rootViewController: rootViewController)
            sceneDelegate?.window?.rootViewController = rootViewController
        case .firebaseTokenError:
            print(value)
            AuthenticationManager.shared.updateIdToken()
            if User.verificationCode == 0 {
                let rootViewController = AuthenticationViewController()
                let navigationController = UINavigationController(rootViewController: rootViewController)
                sceneDelegate?.window?.rootViewController = navigationController
            } else {
                let rootViewController = NicknameCheckViewController()
                let navigationController = UINavigationController(rootViewController: rootViewController)
                sceneDelegate?.window?.rootViewController = navigationController
            }
        case .notMember:
            print(value)
            print("error: notMemeber")
            print("NotMember",User.authVerificationID)
            if User.phoneNumber.count < 5 {
                let rootViewController = AuthenticationViewController()
                let navigationController = UINavigationController(rootViewController: rootViewController)
                sceneDelegate?.window?.rootViewController = navigationController
            } else {
                let rootViewController = NicknameCheckViewController()
                let navigationController = UINavigationController(rootViewController: rootViewController)
                sceneDelegate?.window?.rootViewController = navigationController
            }
        case .serverError:
            print("serverError")
        case .clientError:
            print(value)
            if User.phoneNumber.count > 3 {
                print("error: clientError case 1")
                let rootViewController = AuthenticationViewController()
                let navigationController = UINavigationController(rootViewController: rootViewController)
                sceneDelegate?.window?.rootViewController = navigationController
            } else {
                print("error: clientError case 2")
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
            print("firebaseTokenError",User.fcm)
            if User.fcm == "" {
                let rootViewController = AuthenticationViewController()
                let navigationController = UINavigationController(rootViewController: rootViewController)
                sceneDelegate?.window?.rootViewController = navigationController
            } else {
                let rootViewController = NicknameCheckViewController()
                let navigationController = UINavigationController(rootViewController: rootViewController)
                sceneDelegate?.window?.rootViewController = navigationController
            }
        case .notMember:
            print("NotMember",User.authVerificationID)
            if User.authVerificationID == "" {
                let rootViewController = AuthenticationViewController()
                let navigationController = UINavigationController(rootViewController: rootViewController)
                sceneDelegate?.window?.rootViewController = navigationController
            } else {
                let rootViewController = NicknameCheckViewController()
                let navigationController = UINavigationController(rootViewController: rootViewController)
                sceneDelegate?.window?.rootViewController = navigationController
            }
           
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
    
    func reactQueue(alue: Int) {
      
    }
    
}
