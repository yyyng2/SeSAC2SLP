//
//  CheckCodeViewController.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/09.
//

import Foundation

import RxCocoa
import RxSwift
import Toast

final class CheckCodeViewController: BaseViewController {
    let mainView = CheckCodeView()
    let viewModel = CheckCodeViewModel()
    let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func bind() {
        let input = CheckCodeViewModel.Input (
            numText: mainView.codeTextField.rx.text,
            buttonTap: mainView.startSignButton.rx.tap
        )
        
        let output = viewModel.transform(input: input)
        
        output.validStatus
            .withUnretained(self)
            .bind { (vc, value) in
                let color = value ? Constants.brandColor.green : Constants.grayScale.gray5
                vc.mainView.startSignButton.backgroundColor = color
                
            }
            .disposed(by: disposeBag)
        
        output.numCheck
            .withUnretained(self)
            .bind { (vc, value) in
                switch value {
                case .over:
                    vc.mainView.codeTextField.text = vc.mainView.codeTextField.text?.deleteCodeOverRange
                case .correct:
                    self.mainView.makeToast("okay", duration: 1.5, position: .center)
                case .under:
                    break
                }
            }
            .disposed(by: disposeBag)
        
        output.buttonTap
            .withUnretained(self)
            .bind { (vc, _) in
                
                guard let text = vc.mainView.codeTextField.text else { return }
                let result = vc.viewModel.checkPattern(num: text)
                switch result {
                case true:
                    let vc = NicknameCheckViewController()
                    self.navigationController?.pushViewController(vc, animated: true)
                case false:
                    self.mainView.makeToast("잘못된 번호입니다.", duration: 1.5, position: .center)
                }
            }
            .disposed(by: disposeBag)
    }
}
