//
//  NicknameCheckViewController.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/09.
//

import Foundation

final class NicknameCheckViewController: BaseViewController {
    let mainView = NicknameCheckView()
    
    override func loadView() {
        self.view = mainView
    }
}
