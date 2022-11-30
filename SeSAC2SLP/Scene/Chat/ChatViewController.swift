//
//  ChatViewController.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/30.
//

import UIKit

class ChatViewController: BaseViewController {
    let mainView = ChatView()
    
    override func loadView() {
        self.view = mainView
    }
    
    
}
