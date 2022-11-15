//
//  LaunchScreenViewController.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/14.
//

import UIKit

import FirebaseAuth

class LaunchScreenViewController: BaseSignViewController {
    let mainView = LaunchScreenView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AuthenticationManager.shared.updateIdToken()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3.0) {
            self.checkStatus()
        }
    }
    
    private func checkStatus() {

        APIService().login { value in
            print(value)
            APIService().reactLoginAPI(value: value)

        }
    }
}
