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
    }
    
    override func configure() {
        super.configure()
        navigationController?.navigationBar.isHidden = false
        self.title = "새싹 찾기"
        let stopFindingButton = UIBarButtonItem(title: "찾기중단", style: .plain, target: self, action: #selector(stopFindingButtonTapped))
        self.navigationItem.rightBarButtonItem = stopFindingButton
    }
    
    @objc func stopFindingButtonTapped() {
        APIService().stopQueueFinding { code in
            print("stopQeueFindingError:",code)
        switch code {
        case 200:
            let vc = HomeViewController()
            User.matched = 2
            vc.setQueueButtonImage()
            self.navigationController?.popViewController(animated: true)
        case 400:
            AuthenticationManager.shared.updateIdToken()
            APIService().stopQueueFinding { code in
                print("stopQeueFinding:",code)
                switch code {
                case 200:
                    let vc = HomeViewController()
                    User.matched = 2
                    vc.setQueueButtonImage()
                    self.navigationController?.popViewController(animated: true)
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
