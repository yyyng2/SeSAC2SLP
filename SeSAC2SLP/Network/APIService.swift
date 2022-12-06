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
        
        let api = SeSACAPI.signUp(phoneNumber: User.phoneNumber, FCMtoken: User.fcm, nick: User.nickname, birth: User.birth, email: User.email, gender: User.gender)
        
        print(api.parameters)
        
        AF.request(api.path, method: .post, parameters: api.parameters, headers: api.headers).responseString { response in
            print(response, response.response?.statusCode)
            guard let statusCode = response.response?.statusCode else { return }
            completionHandler(statusCode)
        }
    }

    func login(completionHandler: @escaping (Int) -> Void) {

        let api = SeSACAPI.login
        print(api.parameters)
        AF.request(api.path, method: .get, parameters: api.parameters, headers: api.headers).responseDecodable(of: Login.self) { response in
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
                User.uid = data.uid
                
           
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

        AF.request(api.path, method: .post, headers: api.headers).responseDecodable(of: WithDraw.self) { response in
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
        
        AF.request(api.path, method: .put, parameters: api.parameters, headers: api.headers).response { response in
            print(User.fcm)
            switch response.result {
            case .success(let data):
                print(response.response?.statusCode)
            case .failure(let error):
                guard let errorCode = error.responseCode else { return }

            }
        }
    }
    
    func mypageUpdate(searchable: Int, ageMin: Int, ageMax: Int, gender: Int, study: String, completionHandler: @escaping (Int) -> Void) {
        let api = SeSACAPI.mypage(searchable: searchable, ageMin: ageMin, ageMax: ageMax, gender: gender, study: study)
        
        AF.request(api.path, method: .put, parameters: api.parameters, headers: api.headers).responseString { response in
            guard let code = response.response?.statusCode else { return }
            print("mapageUpdate:",code, api.path, api.headers,api.parameters)
            completionHandler(code)
        }
    }
    
    func requestQueueState(completionHandler: @escaping (Int) -> Void) {
        
        let api = SeSACAPI.myQueueState

        AF.request(api.path, method: .get, parameters: api.parameters, headers: api.headers).responseDecodable(of: QueueState.self) { response in
            guard let statusCode = response.response?.statusCode else { return }
            switch response.result {
            case .success(let data):
                print(data)
                //로그인 후 필요 정보 여기서 관리할 것
                
                guard let data = response.value else { return }
                
      
    
                if data.matched == 1 {
                    User.matched = data.matched
                    
                    User.dodged = data.dodged
               
                    User.reviewed = data.reviewed
                    User.matchedNick = data.matchedNick
                    User.matchedUid = data.matchedUid
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

        let api = SeSACAPI.searchQueue(lat: lat, long: long)
        
        AF.request(api.path, method: .post, parameters: api.parameters, headers: api.headers).responseDecodable(of: SearchInfo.self) { response in
            print("requestSearchQueue:",response)
            guard let statusCode = response.response?.statusCode else { return }
            switch response.result {
            case .success(let data):
                //로그인 후 필요 정보 여기서 관리할 것
          
                print("requestQueueSuccess",data, statusCode)
                completionHandler(data, statusCode)
                
            case .failure(let error):
                print("requestQueueError", statusCode)
                completionHandler(nil, statusCode)
            }
            
          
        }
    }
    
    func requestQueue(lat: Double, long: Double, studylist: [String], completionHandler: @escaping (Int) -> Void) {
        let api = SeSACAPI.queue(lat: lat, long: long, studylist: studylist)

        AF.request(api.path, method: .post, parameters: api.parameters, encoding: URLEncoding(arrayEncoding: .noBrackets), headers: api.headers).responseString { response in
            guard let code = response.response?.statusCode else { return }
            print("requestQueueAPI:",code, api.path, api.headers,api.parameters)
            completionHandler(code)
        }
    }
    
    func stopQueueFinding(completionHandler: @escaping (Int) -> Void) {
        let api = SeSACAPI.stopQueue
        
        AF.request(api.path, method: .delete, parameters: api.parameters, headers: api.headers).response { response in
            guard let code = response.response?.statusCode else { return }
            print("stopQueueFinding:",code, api.path, api.headers,api.parameters)
            completionHandler(code)

        }
    }
    
    func studyRequest(otherUid: String, completionHandler: @escaping (Int) -> Void) {
        let api = SeSACAPI.studyRequest(otheruid: otherUid)
        
        AF.request(api.path, method: .post, parameters: api.parameters, headers: api.headers).response { response in
            guard let code = response.response?.statusCode else { return }
            print("studyRequest:",code, api.path, api.headers,api.parameters)
            completionHandler(code)

        }
    }
    
    func studyAccept(otherUid: String, completionHandler: @escaping (Int) -> Void) {
        let api = SeSACAPI.studyAccept(otheruid: otherUid)
        
        AF.request(api.path, method: .post, parameters: api.parameters, headers: api.headers).response { response in
            guard let code = response.response?.statusCode else { return }
            print("studyAccept:",code, api.path, api.headers,api.parameters)
            completionHandler(code)

        }
    }

    func dodge(otherUid: String, completionHandler: @escaping (Int) -> Void) {
        let api = SeSACAPI.dodge(otheruid: otherUid)
        
        AF.request(api.path, method: .post, parameters: api.parameters, headers: api.headers).response { response in
            guard let code = response.response?.statusCode else { return }
            print("dodge:",code, api.path, api.headers,api.parameters)
            completionHandler(code)

        }
    }
    
    func rate(otherUid: String, reputation: [Int], comment: String, completionHandler: @escaping (Int) -> Void) {
        let api = SeSACAPI.rate(otheruid: otherUid, reputation: reputation, comment: comment)
        
        AF.request(api.path, method: .post, parameters: api.parameters, encoding: URLEncoding(arrayEncoding: .noBrackets), headers: api.headers).response { response in
            guard let code = response.response?.statusCode else { return }
            print("rate:",code, api.path, api.headers,api.parameters)
            completionHandler(code)

        }
    }
    
    func sendChat(message: String, completionHandler: @escaping (Chat?, Int?) -> Void) {

        let api = SeSACAPI.chat(chat: message)
        
        AF.request(api.path, method: .post, parameters: api.parameters, headers: api.headers).responseDecodable(of: Chat.self) { response in
            print("sendChat:",response)
            guard let statusCode = response.response?.statusCode else { return }
            switch response.result {
            case .success(let data):
          
                print("sendChat",data, statusCode)
                completionHandler(data, statusCode)
                
            case .failure(_):
                print("sendChatError", statusCode)
                completionHandler(nil, statusCode)
            }
            
          
        }
    }
    
    func loadChat(date: String, completionHandler: @escaping (LoadChat?, Int?) -> Void) {

        let api = SeSACAPI.loadChat(lastchatDate: date)
        
        AF.request(api.path, method: .get, parameters: api.parameters, headers: api.headers).responseDecodable(of: LoadChat.self) { response in
            print("loadChat:",response)
            guard let statusCode = response.response?.statusCode else { return }
            switch response.result {
            case .success(let data):
          
                print("loadChat",data, statusCode)
                completionHandler(data, statusCode)
                
            case .failure(_):
                print("loadChat", "Error", statusCode)
                completionHandler(nil, statusCode)
            }
            
          
        }
    }
    
    func reactLoginAPI(value: Int) {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
     
        switch LoginCode(rawValue: value) {
        case .success:
//            updateFcmToken()
            User.isSigned = true
            print("success: Login")
            let rootViewController = TabBarController()
//            let navigationController = UINavigationController(rootViewController: rootViewController)
            sceneDelegate?.window?.rootViewController = rootViewController
        case .firebaseTokenError:
            print(value)
            AuthenticationManager.shared.updateIdToken { result in
                switch result {
                case true:
                    APIService().login { value in
                        self.reactLoginAPI(value: value)
                        
                    }
                case false:
                    print("error")
                }
            }
     
          
           
//            if User.verificationCode == 0 {
//                let rootViewController = AuthenticationViewController()
//                let navigationController = UINavigationController(rootViewController: rootViewController)
//                sceneDelegate?.window?.rootViewController = navigationController
//            } else {
//                let rootViewController = NicknameCheckViewController()
//                let navigationController = UINavigationController(rootViewController: rootViewController)
//                sceneDelegate?.window?.rootViewController = navigationController
//            }
        case .notMember:
            print(value)
            print("error: notMemeber")
            print("NotMember",User.authVerificationID)
            if User.isAuthentication == false {
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
                let rootViewController = NicknameCheckViewController()
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
            print("SuccessSign")
//            AuthenticationManager.shared.updateIdToken()
//            updateFcmToken()
            let rootViewController = TabBarController()
            sceneDelegate?.window?.rootViewController = rootViewController
        case .already:
            print("alreadySign")
            AuthenticationManager.shared.updateIdToken { result in
                switch result {
                case true:
                    self.updateFcmToken()
                    let rootViewController = TabBarController()
                    sceneDelegate?.window?.rootViewController = rootViewController
                case false:
                    print("error")
                }
            }
          
        case .badNickname:
            print("badNickSign")
            let rootViewController = NicknameCheckViewController()
            rootViewController.nicknameStatus = true
            let navigationController = UINavigationController(rootViewController: rootViewController)
            sceneDelegate?.window?.rootViewController = navigationController
        case .firebaseTokenError:
            print("firebaseTokenErrorSign")
                AuthenticationManager.shared.updateIdToken { result in
                    switch result {
                    case true:
                        APIService().signUp { value in
                            self.reactSignAPI(value: value)
                        }
                    case false:
                        print("error")
                    }
                
            }
          
//            print("firebaseTokenError",User.fcm)
//            if User.fcm == "" {
//                let rootViewController = AuthenticationViewController()
//                let navigationController = UINavigationController(rootViewController: rootViewController)
//                sceneDelegate?.window?.rootViewController = navigationController
//            } else {
//                let rootViewController = NicknameCheckViewController()
//                let navigationController = UINavigationController(rootViewController: rootViewController)
//                sceneDelegate?.window?.rootViewController = navigationController
//            }
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
            print("clientErrorSign")
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
