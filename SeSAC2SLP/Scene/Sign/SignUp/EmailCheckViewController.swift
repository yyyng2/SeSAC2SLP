//
//  EmailCheckViewController.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/12.
//

import Foundation

import RxCocoa
import RxSwift
import Toast
import UIKit

final class EmailCheckViewController: BaseViewController {
    let mainView = EmailCheckView()
    let viewModel = EmailCheckViewModel()
    let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func bind() {
        let input = EmailCheckViewModel.Input (
            emailText: mainView.emailTextField.rx.text,
            buttonTap: mainView.nextButton.rx.tap
        )
        
        let output = viewModel.transform(input: input)
        
        output.validStatus
            .withUnretained(self)
            .bind { (vc, value) in
                let color = value ? Constants.brandColor.green : Constants.grayScale.gray6
                let lineColor = value ? Constants.BaseColor.black : Constants.grayScale.gray6
                vc.mainView.nextButton.backgroundColor = color
                vc.mainView.emailTextField.underLineView.backgroundColor = lineColor
               
            }
            .disposed(by: disposeBag)
        
        output.buttonTap
            .withUnretained(self)
            .bind { (vc, _) in
                
                guard let text = vc.mainView.emailTextField.text else { return }
                let result = vc.viewModel.checkPattern(email: text)
                switch result {
                case true:
                    let vc = GenderCheckViewController()
                    self.navigationController?.pushViewController(vc, animated: true)
                case false:
                    self.mainView.makeToast("이메일 형식이 올바르지 않습니다.", duration: 1.5, position: .center)
                }
            }
            .disposed(by: disposeBag)
    }
}
