//
//  AuthenticationViewController.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/08.
//

import Foundation

import RxCocoa
import RxSwift
import UIKit

class AuthenticationViewController: BaseViewController {
    let mainView = AuthenticationView()
    let viewModel = AuthenticationViewModel()
    let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
        
    }
    
    func bind() {
        let input = AuthenticationViewModel.Input (
            numText: mainView.phoneNumberTextField.rx.text,
            buttonTap: mainView.sendTextMessageButton.rx.tap
        )
        
        let output = viewModel.transform(input: input)
        
        output.validStatus
            .withUnretained(self)
            .bind { (vc, value) in
                let color = value ? Constants.brandColor.green : Constants.grayScale.gray5
                vc.mainView.sendTextMessageButton.backgroundColor = color
               
            }
            .disposed(by: disposeBag)
        
        output.numCheck
            .withUnretained(self)
            .bind { (vc, value) in
                switch value {
                case .over:
                    vc.mainView.phoneNumberTextField.text = vc.mainView.phoneNumberTextField.text?.deleteOverRange
                case .third:
                    vc.mainView.phoneNumberTextField.text = vc.mainView.phoneNumberTextField.text?.thirdWithHypen
                case .underThird:
                    vc.mainView.phoneNumberTextField.text = vc.mainView.phoneNumberTextField.text?.underThirdWithHypen
                case .underSecond:
                    vc.mainView.phoneNumberTextField.text = vc.mainView.phoneNumberTextField.text?.underSecondWithHypen
                case .underFirst:
                    vc.mainView.phoneNumberTextField.text = vc.mainView.phoneNumberTextField.text?.underFirstWithHypen
                case .under:
                    break
                }
            }
            .disposed(by: disposeBag)
     
        output.buttonTap
            .withUnretained(self)
            .bind { _ in
                guard let text = self.mainView.phoneNumberTextField.text else { return }
                let result = self.viewModel.checkPattern(num: text)
                switch result {
                case .ok:
                    let vc = OnboardingViewController()
                    self.navigationController?.pushViewController(vc, animated: true)
                case .no:
                    let alert = UIAlertController(title: "No", message: "", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "ok", style: .cancel)
                    alert.addAction(ok)
                    self.present(alert, animated: true)
                }
            }
            .disposed(by: disposeBag)
        
    }
    
}
