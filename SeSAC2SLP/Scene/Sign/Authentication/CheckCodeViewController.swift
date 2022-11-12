//
//  CheckCodeViewController.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/09.
//

import UIKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            self.mainView.makeToast("인증번호를 보냈습니다.", duration: 1, position: .center)
        }
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
                let color = value ? Constants.brandColor.green : Constants.grayScale.gray6
                let lineColor = value ? Constants.BaseColor.black : Constants.grayScale.gray6
                vc.mainView.startSignButton.backgroundColor = color
                vc.mainView.codeTextField.underLineView.backgroundColor = lineColor
            }
            .disposed(by: disposeBag)
        
        output.numCheck
            .withUnretained(self)
            .bind { (vc, value) in
                switch value {
                case .over:
                    vc.mainView.codeTextField.text = vc.mainView.codeTextField.text?.deleteCodeOverRange
                case .correct:
                    break
                case .under:
                    break
                }
            }
            .disposed(by: disposeBag)
        
        output.buttonTap
            .withUnretained(self)
            .throttle(.seconds(3), latest: false, scheduler: MainScheduler.instance) 
            .bind { (vc, _) in
                
                guard let text = vc.mainView.codeTextField.text else { return }
                let result = vc.viewModel.checkPattern(num: text)
                switch result {
                case true:
                    
                    AuthenticationManager().checkVerifyId(code: text) { value in
                        switch value {
                        case true:
                            let vc = NicknameCheckViewController()
                            self.navigationController?.pushViewController(vc, animated: true)
//                            self.viewModel.checkSign { bool in
//                                switch bool {
//                                case true:
//                                    break
//                                    let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
//                                    let sceneDelegate = windowScene?.delegate as? SceneDelegate
//
//                                    let rootViewController = AuthenticationViewController()
//                                    let navigationController = UINavigationController(rootViewController: rootViewController)
//                                    sceneDelegate?.window?.rootViewController = navigationController
//
//                                    sceneDelegate?.window?.makeKeyAndVisible()
//                                case false:
//                                    let vc = NicknameCheckViewController()
//                                    self.navigationController?.pushViewController(vc, animated: true)
//
//                                }
//                            }
                        case false:
                            self.mainView.makeToast("잘못된 인증 번호입니다.", duration: 1.5, position: .center)
                        }
                    }
              
                 
                case false:
                    self.mainView.makeToast("잘못된 인증 번호입니다.", duration: 1.5, position: .center)
                }
            }
            .disposed(by: disposeBag)
    }
}
