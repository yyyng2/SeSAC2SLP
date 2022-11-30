//
//  TabManViewController.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/25.
//

import UIKit

import Toast
import Tabman
import Pageboy

class TabManViewController: TabmanViewController {
    private var viewControllers: Array<UIViewController> = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "새싹 찾기"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.isTranslucent = true
        
        setNavigationUI()
        
        setTabman()
    }
    
    private func setTabman() {
        configureViewControllers()
        self.dataSource = self

        let bar = TMBarView<TMConstrainedHorizontalBarLayout, TMLabelBarButton, TMLineBarIndicator>()
        addBar(bar, dataSource: self, at: .top)

        bar.backgroundView.style = .clear
        bar.layout.transitionStyle = .snap
        bar.layout.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        bar.indicator.tintColor = Constants.brandColor.green

        bar.buttons.customize { button in
            button.selectedTintColor =  Constants.brandColor.green
            button.tintColor = Constants.grayScale.gray6
        }
    }
    
    private func configureViewControllers() {
        let searchResultView = SearchResultViewController()
        let requestReaultView = RequestResultViewController()
        
        viewControllers.append(searchResultView)
        viewControllers.append(requestReaultView)
    }
    
    func setNavigationUI() {
        //popToRootView를 위해 백버튼 숨김, leftBarItem으로 대응
        self.navigationItem.setHidesBackButton(true, animated: true)
        let backBarButtonItem = UIBarButtonItem(image: UIImage(named: "arrow"), style: .plain, target: self, action: #selector(backButtonTapped))
        self.navigationItem.leftBarButtonItem = backBarButtonItem
        
        navigationController?.navigationBar.isHidden = false
        self.title = "새싹 찾기"
        let stopFindingButton = UIBarButtonItem(title: "찾기중단", style: .plain, target: self, action: #selector(stopFindingButtonTapped))
        self.navigationItem.rightBarButtonItem = stopFindingButton       
    }
    
    @objc func backButtonTapped() {
            navigationController?.popToRootViewController(animated: true)

        //스택쌓인 뷰컨 중 원하는 뷰로 이동
//        navigationController?.popToViewController((self.navigationController?.viewControllers[0])!,
//                                                   animated: true)
        //뷰컨트롤러 스택 인덱스확인
//        navigationController?.viewControllers.enumerated().forEach{ (index, item) in print("count\(index) \(item)")}
       
    }
    
    @objc func stopFindingButtonTapped(sender: UIButton) {
        networkMoniter()
        APIService().stopQueueFinding { code in
            print("stopQeueFindingError:",code)
            switch code {
            case 200:
                let homeVC = HomeViewController()
                User.matched = 2
                homeVC.setQueueButtonImage()
                let vc = SearchQueueViewController()
                vc.queueState = 0
                self.navigationController?.popToRootViewController(animated: true)
            case 401:
                DispatchQueue.main.sync {
                    AuthenticationManager.shared.updateIdToken()
                    APIService().stopQueueFinding { code in
                        print("stopQeueFinding:",code)
                        switch code {
                        case 200:
                            let homeVC = HomeViewController()
                            User.matched = 2
                            homeVC.setQueueButtonImage()
                            let vc = SearchQueueViewController()
                            vc.queueState = 0
                            self.navigationController?.popToRootViewController(animated: true)
                        default:
                            print("stopQeueFinding",code)
                        }
                    }
                }
            default:
                self.view.makeToast("중단 에러")
            }
        }
        
    }
}

extension TabManViewController: PageboyViewControllerDataSource, TMBarDataSource {
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        switch index {
        case 0:
            return TMBarItem(title: "주변 새싹")
        case 1:
            return TMBarItem(title: "받은 요청")
        default:
            return TMBarItem(title: "\(index)")
        }
    }
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
}
