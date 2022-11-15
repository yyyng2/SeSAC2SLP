//
//  NicknameCheckViewController.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/09.
//

import Foundation

import RxCocoa
import RxSwift
import Toast
import UIKit

final class NicknameCheckViewController: BaseSignViewController {
    let mainView = NicknameCheckView()
    let viewModel = NicknameCheckViewModel()
    let disposeBag = DisposeBag()
    
    var nicknameStatus = false
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      checkBadNickname()
        
    }
    
    override func bind() {
        let input = NicknameCheckViewModel.Input (
            nameText: mainView.nicknameTextField.rx.text,
            buttonTap: mainView.nextButton.rx.tap
        )
        
        let output = viewModel.transform(input: input)
        
        output.validStatus
            .withUnretained(self)
            .bind { (vc, value) in
                let color = value ? Constants.brandColor.green : Constants.grayScale.gray6
                let lineColor = value ? Constants.BaseColor.black : Constants.grayScale.gray6
                vc.mainView.nextButton.backgroundColor = color
                vc.mainView.nicknameTextField.underLineView.backgroundColor = lineColor
               
            }
            .disposed(by: disposeBag)
        
        output.nameCheck
            .withUnretained(self)
            .bind { (vc, value) in
                switch value {
                case .over:
                    vc.mainView.nicknameTextField.text = vc.mainView.nicknameTextField.text?.deleteNameOverRange
                case .normal:
                    break
                case .under:
                    break
                }
            }
            .disposed(by: disposeBag)
        
        output.buttonTap
            .withUnretained(self)
            .bind { (vc, _) in
                
                guard let text = vc.mainView.nicknameTextField.text else { return }
                let result = vc.viewModel.checkPattern(name: text)
                switch result {
                case true:
                    User.nickname = text
                    let vc = BirthCheckViewController()
                    self.navigationController?.pushViewController(vc, animated: true)
                case false:
                    self.mainView.makeToast("닉네임은 1자 이상 10자 이내로 부탁드려요.", duration: 1.5, position: .center)
                }
            }
            .disposed(by: disposeBag)
    }
    
    func checkBadNickname() {
        switch nicknameStatus {
        case true:
            nicknameStatus = false
            self.mainView.makeToast("해당 닉네임은 사용할 수 없습니다.", duration: 1.5, position: .center)
        case false:
            break
        }
    }
}
