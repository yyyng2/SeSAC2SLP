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
     
        
        self.checkStatus()
        
   
    }
    
    private func checkStatus() {
    
            networkMoniter()

            APIService().login { value in
                print("launchScreen",value)
                APIService().reactLoginAPI(value: value)
                
            }
        
    }
}
