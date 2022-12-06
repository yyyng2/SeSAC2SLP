//
//  TabBarController.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/08.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        
        configure()
    }
    
    func configure(){

//        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.clear]
//        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.clear]
        
        self.tabBar.backgroundColor = Constants.BaseColor.white
        self.tabBar.tintColor = Constants.brandColor.green
        self.tabBar.unselectedItemTintColor = Constants.grayScale.gray6
        
        let vc1 = HomeViewController()
    //    let vc2 = ScheduleViewController()
    //    let vc3 = DdayViewController()
        let vc4 = UserInfoViewController()
        
        configureTab(vc: vc1, title: "홈", imageName: "ic-4", selectedImageName: "ic")
//        configureTab(vc: vc2, title: "Schedule", image: themeType().tabBarScheduleItem, selectedImage: themeType().tabBarScheduleItemSelected)
//        configureTab(vc: vc3, title: "D-day", image: themeType().tabBarDdayItem, selectedImage: themeType().tabBarDdayItemSelected)
        
        
        configureTab(vc: vc4, title: "내정보", imageName: "ic-3", selectedImageName: "ic-7")
        
        tabBar.isTranslucent = false
        
        let nav1 = configureNav(vc: vc1)
//        let nav2 = configureNav(vc: vc2)
//        let nav3 = configureNav(vc: vc3)
        let nav4 = configureNav(vc: vc4)
        
//        setViewControllers([nav1, nav2, nav3, nav4], animated: true)
        setViewControllers([nav1, nav4], animated: false)
    }
    
    func configureTab(vc: UIViewController, title: String, imageName: String, selectedImageName: String){
        vc.navigationItem.title = title
        vc.tabBarItem = UITabBarItem(title: title, image: UIImage(named: imageName), selectedImage: UIImage(named: selectedImageName))
        vc.navigationItem.largeTitleDisplayMode = .never
    }
    
    func configureNav(vc: UIViewController) -> UINavigationController{
        let nav = UINavigationController(rootViewController: vc)
        nav.navigationController?.navigationBar.tintColor = Constants.BaseColor.black
        nav.navigationBar.prefersLargeTitles = false
        return nav
    }
    
}
