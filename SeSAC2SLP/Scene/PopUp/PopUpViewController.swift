//
//  PopUpViewController.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/26.
//

import UIKit

class PopUpViewController: BaseViewController {
    let mainView = BasePopupView()
    
    var status = 0
    
    var otherUid = ""
    
    override func loadView() {
        self.view = mainView
    }
    
    override func configure() {
        switch status {
        case 0:
            mainView.confirmButton.addTarget(self, action: #selector(studyRequest), for: .touchUpInside)
            
            mainView.titleLabel.text = "스터디를 요청할게요!"
            mainView.contentLabel.text = """
                                        상대방이 요청을 수락하면
                                        채팅창에서 대화를 나눌 수 있어요
                                        """
            mainView.contentLabel.numberOfLines = 2
        case 1:
            mainView.confirmButton.addTarget(self, action: #selector(studyAccept), for: .touchUpInside)
            
            mainView.titleLabel.text = "스터디를 수락할까요?"
            mainView.contentLabel.text = "요청을 수락하면 채팅창에서 대화를 나눌 수 있어요"
        case 2:
            mainView.confirmButton.addTarget(self, action: #selector(withDrawButtonTapped), for: .touchUpInside)
            
            mainView.titleLabel.text = "정말 탈퇴하시겠습니까?"
            mainView.contentLabel.text = "탈퇴하시면 새싹 스터디를 이용할 수 없어요ㅠ"
        default:
            break
        }
        mainView.cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
    }
    
    @objc private func cancelButtonTapped() {
        self.dismiss(animated: true)
    }
    
    @objc private func studyRequest() {
        networkMoniter()
        APIService().studyRequest(otherUid: otherUid) { code in
            switch code {
            case 200:
                self.mainView.makeToast("스터디 요청을 보냈습니다", duration: 1.5, position: .center)
            case 201:
                self.studyAccept()
            case 202:
                self.mainView.makeToast("상대방이 스터디 찾기를 그만두었습니다", duration: 1.5, position: .center)
            case 401:
                DispatchQueue.main.sync {
                    AuthenticationManager.shared.updateIdToken { result in
                        switch result {
                        case true:
                            APIService().studyRequest(otherUid: self.otherUid) { code in
                                switch code {
                                case 200:
                                    self.mainView.makeToast("스터디 요청을 보냈습니다", duration: 1.5, position: .center)
                                default:
                                    print(code)
                                }
                            }
                        case false:
                            self.mainView.makeToast("Error")
                        }
                    }
                   
                }
               
            default:
                break
            }
        }
    }
    
    @objc private func studyAccept() {
        networkMoniter()
        APIService().studyAccept(otherUid: otherUid) { code in
            switch code {
            case 200:
                let vc = ChatViewController()
                vc.otherUid = self.otherUid
                User.matchedUid = self.otherUid
                self.transition(vc, transitionStyle: .push)
            case 201:
                self.mainView.makeToast("상대방이 이미 다른 새싹과 스터디를 함께 하는 중입니다", duration: 1.5, position: .center)
            case 202:
                self.mainView.makeToast("상대방이 스터디 찾기를 그만두었습니다", duration: 1.5, position: .center)
            case 203:
                self.mainView.makeToast("앗! 누군가가 나의 스터디를 수락하였어요!", duration: 1.5, position: .center)
                self.setQueueState()
            case 401:
                DispatchQueue.main.sync {
                    AuthenticationManager.shared.updateIdToken { result in
                        switch result {
                        case true:
                            APIService().studyAccept(otherUid: self.otherUid) { code in
                                switch code {
                                case 200:
                                    let vc = ChatViewController()
                                    vc.otherUid = self.otherUid
                                    User.matchedUid = self.otherUid
                                    self.transition(vc, transitionStyle: .push)
                                case 201:
                                    self.mainView.makeToast("상대방이 이미 다른 새싹과 스터디를 함께 하는 중입니다", duration: 1.5, position: .center)
                                case 202:
                                    self.mainView.makeToast("상대방이 스터디 찾기를 그만두었습니다", duration: 1.5, position: .center)
                                case 203:
                                    self.mainView.makeToast("앗! 누군가가 나의 스터디를 수락하였어요!", duration: 1.5, position: .center)
                                    self.setQueueState()
                                default:
                                    print(code)
                                }
                            }
                        case false:
                            self.mainView.makeToast("Error")
                        }
                    }
                   
                }
               
            default:
                break
            }
        }
    }
    
    @objc private func withDrawButtonTapped() {
        networkMoniter()
        APIService().withDraw { code in
            switch code {
            case 200:
                for key in UserDefaults.standard.dictionaryRepresentation().keys {
                    UserDefaults.standard.removeObject(forKey: key.description)
                }
                let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                let sceneDelegate = windowScene?.delegate as? SceneDelegate
                let rootViewController = LaunchScreenViewController()
                let navi = UINavigationController(rootViewController: rootViewController)
                sceneDelegate?.window?.rootViewController = navi
            case 401:
                DispatchQueue.main.sync {
                    AuthenticationManager.shared.updateIdToken { result in
                        switch result {
                        case true:
                            APIService().withDraw { code in
                                switch code {
                                case 200:
                                    for key in UserDefaults.standard.dictionaryRepresentation().keys {
                                        UserDefaults.standard.removeObject(forKey: key.description)
                                    }
                                    let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                                    let sceneDelegate = windowScene?.delegate as? SceneDelegate
                                    let rootViewController = LaunchScreenViewController()
                                    let navi = UINavigationController(rootViewController: rootViewController)
                                    sceneDelegate?.window?.rootViewController = navi
                                default:
                                    self.mainView.makeToast("Error")
                                }
                            }
                        case false:
                            self.mainView.makeToast("Error")
                        }
                    }
                 
                }
            default:
                self.mainView.makeToast("Error")
            }
        }
    }

    
    private func setQueueState() {
        let vc = HomeViewController()
        APIService().requestQueueState { code in
            switch code {
            case 200:
                print("requestQueueState1:",code)
                DispatchQueue.main.async {
                    vc.setQueueButtonImage()
                }
            case 201:
                DispatchQueue.main.async {
                    vc.setQueueButtonImage()
                }
            case 401:
                AuthenticationManager.shared.updateIdToken { result in
                    switch result {
                    case true:
                        APIService().requestQueueState { code in
                            switch code {
                            case 200:
                                DispatchQueue.main.async {
                                    vc.setQueueButtonImage()
                                }
                            case 201:
                                DispatchQueue.main.async {
                                    vc.setQueueButtonImage()
                                }
                            default:
                                print("requestQueueStateError1",code)
                            }
                        }
                    case false:
                        self.mainView.makeToast("Error")
                    }
                }
               
                
            default:
                print("requestQueueStateError1",code)
            }
           
        }
    }
    
}
