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
    
    @objc func cancelButtonTapped() {
        self.dismiss(animated: true)
    }
    
    @objc func studyRequest() {
        networkMoniter()
        APIService().studyRequest(otherUid: otherUid) { code in
            switch code {
            case 200:
                self.mainView.makeToast("스터디 요청을 보냈습니다", duration: 1.5, position: .center)
            case 201:
                print("나한테 요청함 요청 수락 api 추가해서 연결할것")
            case 202:
                self.mainView.makeToast("상대방이 스터디 찾기를 그만두었습니다", duration: 1.5, position: .center)
            case 401:
                AuthenticationManager.shared.updateIdToken()
                APIService().studyRequest(otherUid: self.otherUid) { code in
                    switch code {
                    case 200:
                        self.mainView.makeToast("스터디 요청을 보냈습니다", duration: 1.5, position: .center)
                    default:
                        print(code)
                    }
                }
            default:
                break
            }
        }
    }
    
    @objc func withDrawButtonTapped() {
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
                AuthenticationManager.shared.updateIdToken()
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
            default:
                self.mainView.makeToast("Error")
            }
        }
    }

}
