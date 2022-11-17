//
//  SearchQueueViewController.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/18.
//

import UIKit

class SearchQueueViewController: BaseViewController {
    let mainView = SearchQueueView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func configure() {
        super.configure()
        navigationController?.navigationBar.isHidden = false
        var bounds = UIScreen.main.bounds
        var width = bounds.size.width //화면 너비
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: width - 28, height: 0))
        searchBar.placeholder = "띄어쓰기로 복수 입력이 가능해요"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: searchBar)
    }
  
}
