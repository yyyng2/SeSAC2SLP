//
//  WithDrawViewController.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/22.
//

import UIKit

class WithDrawViewController: BaseViewController {
    let mainView = WithDrawView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func configure() {
        mainView.cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        mainView.withDrawButton.addTarget(self, action: #selector(withDrawButtonTapped), for: .touchUpInside)
    }
    
    @objc func cancelButtonTapped() {
        self.dismiss(animated: true)
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
