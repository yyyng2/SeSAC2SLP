//
//  BaseViewController.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/07.
//

import UIKit

class BaseViewController: UIViewController {
    
    let navigationBarAppearance = UINavigationBarAppearance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setConstraints()
        setNavigationUI()
        
    }

    func configure() {
        view.backgroundColor = UIColor(named: "white")
    }
    func setConstraints() {
        
    }
    func setNavigationUI() {

    }
    
}
