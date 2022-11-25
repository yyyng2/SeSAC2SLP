//
//  BaseSignViewController.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/14.
//

import UIKit

class BaseSignViewController: UIViewController {
    
    let navigationBarAppearance = UINavigationBarAppearance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setConstraints()
        setNavigationUI()
        bind()
    }

    func configure() {
        view.backgroundColor = UIColor(named: "white")
    }
    func setConstraints() {
        
    }
    func setNavigationUI() {
        self.navigationController?.navigationBar.tintColor = Constants.BaseColor.black
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "arrow")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "arrow")
    }
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func bind() {
        
    }
    
}
