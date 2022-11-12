//
//  OnboardingViewController.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/08.
//

import UIKit

import FirebaseAuth

final class OnboardingViewController: BaseViewController {
    
    let mainView = OnboardingView()
    
    let firstPage = FirstPageViewController()
    
    let secondPage = SecondPageViewController()
    
    let thirdPage = ThirdPageViewController()
    
    lazy var pages: [UIViewController] = {
        return [firstPage, secondPage, thirdPage]
    }()
    
    var currentIndex: Int?
    var pendingIndex: Int?
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configurePage()

        initPageViewController()
//        UIFont.familyNames.sorted().forEach { familyName in
//            print("*** \(familyName) ***")
//            UIFont.fontNames(forFamilyName: familyName).forEach { fontName in
//                print("\(fontName)")
//            }
//            print("---------------------")
//        }
    }
    
    override func configure() {
        mainView.startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
      
    }
    
    func configurePage() {
        mainView.pageControl.numberOfPages = pages.count
    }
    
    func initPageViewController() {
        let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        pageViewController.dataSource = self
        pageViewController.delegate = self
        
        pageViewController.view.frame = mainView.frame
        
        let viewController = [firstPage]
        pageViewController.setViewControllers(viewController, direction: .reverse, animated: true, completion: nil)
        
        mainView.contentView.addSubview(pageViewController.view)
        self.addChild(pageViewController)
    }
    
    private func setPageControlSelectedPage(currentPage:Int) {
        mainView.pageControl.currentPage = currentPage
    }
    
    @objc func startButtonTapped() {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        
        if Auth.auth().currentUser == nil {
            let rootViewController = AuthenticationViewController()
            let navigationController = UINavigationController(rootViewController: rootViewController)
            sceneDelegate?.window?.rootViewController = navigationController
        } else {
            print(Auth.auth().currentUser)
            let rootViewController = BirthCheckViewController()
            let navigationController = UINavigationController(rootViewController: rootViewController)
            sceneDelegate?.window?.rootViewController = navigationController
        }
        
        sceneDelegate?.window?.makeKeyAndVisible()
    }
    
}

extension OnboardingViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController) else { return nil }
            let previousIndex = index - 1
            if previousIndex < 0 {
                return nil
            }
            return pages[previousIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController) else { return nil }
              let nextIndex = index + 1
              if nextIndex == pages.count {
                  return nil
              }
              return pages[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        pendingIndex = pages.firstIndex(of: pendingViewControllers.first!)
    }

    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            currentIndex = pendingIndex
            if let index = currentIndex {
                mainView.pageControl.currentPage = index
            }
        }
    }
}
