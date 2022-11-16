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
        bind()
    }

    func configure() {
        view.backgroundColor = UIColor(named: "white")
    }
    func setConstraints() {
        
    }
    func setNavigationUI() {
        self.navigationController?.navigationBar.tintColor = Constants.BaseColor.black
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "arrow")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "arrow")
        
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(backButtonTapped))
        self.navigationItem.backBarButtonItem = backBarButtonItem
        
    }
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func bind() {
        
    }
    
    func showRequestNetworkServiceAlert() {
        let requestLocationServiceAlert = UIAlertController(title: "설정으로 이동", message: "네트워크를 사용할 수 없습니다. 기기의 설정에서 네트워크 상태를 확인해 주세요.", preferredStyle: .alert)
        let goSetting = UIAlertAction(title: "설정으로 이동", style: .destructive) { _ in
            if let appSetting = URL(string: UIApplication.openSettingsURLString){
                UIApplication.shared.open(appSetting)
            }
        }
        let cancel = UIAlertAction(title: "취소", style: .default)
        requestLocationServiceAlert.addAction(cancel)
        requestLocationServiceAlert.addAction(goSetting)
        
        self.present(requestLocationServiceAlert, animated: true, completion: nil)
    }
    
}
