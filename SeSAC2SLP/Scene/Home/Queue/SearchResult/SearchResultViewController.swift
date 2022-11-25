//
//  SearchResultViewController.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/18.
//

import UIKit

class SearchResultViewController: BaseViewController {
    let mainView = SearchResultView()
    
    //임시
    let noneSesac = true
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.isTranslucent = true
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func configure() {
        mainView.noneSesacView.studyChangeButton.addTarget(self, action: #selector(stopFindingButtonTapped), for: .touchUpInside)
        
        if noneSesac {
            mainView.collectionView.isHidden = true
        }
    }
    
    @objc func stopFindingButtonTapped(sender: UIButton) {
        APIService().stopQueueFinding { code in
            print("stopQeueFindingError:",code)
            switch code {
            case 200:
                switch sender.tag {
                case 0:
                    let homeVC = HomeViewController()
                    User.matched = 2
                    homeVC.setQueueButtonImage()
                    let vc = SearchQueueViewController()
                    vc.queueState = 0
                    self.navigationController?.popViewController(animated: true)
                case 1:
                    let homeVC = HomeViewController()
                    User.matched = 2
                    homeVC.setQueueButtonImage()
                    let vc = SearchQueueViewController()
                    vc.queueState = 0
                    self.navigationController?.popToRootViewController(animated: true)
                default:
                    break
                }
            case 401:
                AuthenticationManager.shared.updateIdToken()
                APIService().stopQueueFinding { code in
                    print("stopQeueFinding:",code)
                    switch code {
                    case 200:
                        switch sender.tag {
                        case 0:
                            let homeVC = HomeViewController()
                            User.matched = 2
                            homeVC.setQueueButtonImage()
                            let vc = SearchQueueViewController()
                            vc.queueState = 0
                            self.navigationController?.popViewController(animated: true)
                        case 1:
                            let homeVC = HomeViewController()
                            User.matched = 2
                            homeVC.setQueueButtonImage()
                            let vc = SearchQueueViewController()
                            vc.queueState = 0
                            self.navigationController?.popToRootViewController(animated: true)
                        default:
                            break
                        }
                    default:
                        print("stopQeueFinding",code)
                    }
                }
            default:
                self.mainView.makeToast("중단 에러")
            }
        }
        
    }
    
}

