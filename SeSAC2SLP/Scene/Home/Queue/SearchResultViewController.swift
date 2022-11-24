//
//  SearchResultViewController.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/18.
//

import UIKit

class SearchResultViewController: BaseViewController {
    let mainView = SearchResultView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.isTranslucent = true
        navigationController?.viewControllers.enumerated().forEach{ (index, item) in print("count\(index) \(item)")}
    }
    
    override func configure() {
        super.configure()
        mainView.studyChangeButton.addTarget(self, action: #selector(stopFindingButtonTapped), for: .touchUpInside)
    }
    
    override func setNavigationUI() {
        navigationController?.navigationBar.isHidden = false
        self.title = "새싹 찾기"
        let stopFindingButton = UIBarButtonItem(title: "찾기중단", style: .plain, target: self, action: #selector(stopFindingButtonTapped))
        stopFindingButton.tag = 1
        self.navigationItem.rightBarButtonItem = stopFindingButton
        
        //popToRootView를 위해 백버튼 숨김, leftBarItem으로 대응
        self.navigationItem.setHidesBackButton(true, animated: true)
        let backBarButtonItem = UIBarButtonItem(image: UIImage(named: "arrow"), style: .plain, target: self, action: #selector(backButtonTapped))
        self.navigationItem.leftBarButtonItem = backBarButtonItem

    }
    
    @objc override func backButtonTapped() {
            navigationController?.popToRootViewController(animated: true)

        //스택쌓인 뷰컨 중 원하는 뷰로 이동
//        navigationController?.popToViewController((self.navigationController?.viewControllers[0])!,
//                                                   animated: true)
       
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
