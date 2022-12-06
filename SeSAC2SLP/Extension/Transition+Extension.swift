//
//  Transition+Extension.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/12/04.
//

//import UIKit
//
//extension UIViewController {
//    enum TransitionStyle {
//        case present
//        case presentNavigation
//        case presentFullNavigation
//        case push
//        case overFullScreen
//        case popUp
//    }
//    
//    func transition<T: UIViewController>(_ viewController: T, transitionStyle: TransitionStyle) {
//        
//        let navi = UINavigationController(rootViewController: viewController)
//        
//        switch transitionStyle {
//            
//        case .present:
//            self.present(viewController, animated: true)
//            
//        case .presentNavigation:
//            self.present(navi, animated: true)
//        
//        case .presentFullNavigation:
//            navi.modalPresentationStyle = .fullScreen
//            self.present(navi, animated: true)
//            
//        case .push:
//            self.navigationController?.pushViewController(viewController, animated: true)
//            
//        case .overFullScreen:
//            navi.modalPresentationStyle = .overFullScreen
//            self.present(navi, animated: true)
//            
//        case .popUp:
//            viewController.modalPresentationStyle = .overFullScreen
//            viewController.modalTransitionStyle = .crossDissolve
//            self.present(viewController, animated: true)
//     
//        }
//        
//
//    }
//    
//}
