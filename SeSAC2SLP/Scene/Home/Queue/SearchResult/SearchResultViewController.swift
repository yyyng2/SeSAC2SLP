//
//  SearchResultViewController.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/18.
//

import UIKit

class SearchResultViewController: BaseViewController {
    let mainView = SearchResultView()
    
    //임시
    let noneSesac = true
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.isTranslucent = true
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func configure() {
        
        if noneSesac {
            mainView.collectionView.isHidden = true
        }
    }

    
}

