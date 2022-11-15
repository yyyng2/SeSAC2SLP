//
//  AuthenticationViewController.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/08.
//

import UIKit

import RxCocoa
import RxSwift
import Toast

final class AuthenticationViewController: BaseSignViewController {
    let mainView = AuthenticationView()
    let viewModel = AuthenticationViewModel()
    let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func bind() {
        let input = AuthenticationViewModel.Input (
            numText: mainView.phoneNumberTextField.rx.text,
            buttonTap: mainView.sendCodeButton.rx.tap
        )
        
        let output = viewModel.transform(input: input)
        
        output.validStatus
            .withUnretained(self)
            .bind { (vc, value) in
                let color = value ? Constants.brandColor.green : Constants.grayScale.gray6
                let lineColor = value ? Constants.BaseColor.black : Constants.grayScale.gray6
                vc.mainView.sendCodeButton.backgroundColor = color
                vc.mainView.phoneNumberTextField.underLineView.backgroundColor = color
            }
            .disposed(by: disposeBag)
        
        output.numCheck
            .withUnretained(self)
            .bind { (vc, value) in
                switch value {
                case .over:
                    vc.mainView.phoneNumberTextField.text = vc.mainView.phoneNumberTextField.text?.deleteNumberOverRange
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
            .throttle(.seconds(3), latest: false, scheduler: MainScheduler.instance) 
            .bind { (vc, _) in
             
                guard let text = vc.mainView.phoneNumberTextField.text else { return }
                let result = vc.viewModel.checkPattern(num: text)
                switch result {
                case true:
                    User.phoneNumber = text.deleteHyphenToSave
                    AuthenticationManager().sendCode(completionHandler: { Bool in
                        switch Bool {
                        case true:
                            self.mainView.makeToast("전화 번호 인증 시작", duration: 1.5, position: .center)
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                                let vc = CheckCodeViewController()
                                self.navigationController?.pushViewController(vc, animated: true)
                            }
                        case false:
                            self.mainView.makeToast("잘못된 번호입니다.", duration: 1.5, position: .center)
                        }
                    })
                   
                case false:
                    self.mainView.makeToast("잘못된 번호입니다.", duration: 1.5, position: .center)
                }
            }
            .disposed(by: disposeBag)
        
    }
    
}
