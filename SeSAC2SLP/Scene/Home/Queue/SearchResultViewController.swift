//
//  SearchResultViewController.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/18.
//

import Foundation

class SearchResultViewController: BaseViewController {
    let mainView = SearchResultView()
    
    override func loadView() {
        self.view = mainView
    }
}
