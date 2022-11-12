//
//  GenderCheckViewController.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/12.
//

import Foundation

import RxSwift

class GenderCheckViewController: BaseViewController {
    let mainView = GenderCheckView()
    let viewModel = GenderCheckViewModel()
    let disposeBag = DisposeBag()
    
    var gender: Int?
    
    override func loadView() {
        self.view = mainView
    }
    
    override func bind() {
    
        let input = GenderCheckViewModel.Input (
            leftBool: mainView.leftButton.isSelected,
            rightBool: mainView.rightButton.isSelected,
            leftButtonTap: mainView.leftButton.rx.tap,
            rightButtonTap: mainView.rightButton.rx.tap,
            buttonTap: mainView.nextButton.rx.tap
        )
        
        let output = viewModel.transform(input: input)
        
        output.leftButtonTap
            .withUnretained(self)
            .bind { (vc, _) in
                DispatchQueue.main.async {
                    if self.mainView.rightButton.isSelected == true {
                        self.mainView.rightButton.isSelected = !self.mainView.rightButton.isSelected
//                        self.mainView.rightButton.backgroundColor = Constants.BaseColor.white
                    }
                    self.mainView.leftButton.isSelected = !self.mainView.leftButton.isSelected
//                    self.mainView.leftButton.backgroundColor = Constants.brandColor.whiteGreen
                 
                }
            }
            .disposed(by: disposeBag)
        
        output.rightButtonTap
            .withUnretained(self)
            .bind { (vc, _) in
                DispatchQueue.main.async {
                    if self.mainView.leftButton.isSelected == true {
                        self.mainView.leftButton.isSelected = !self.mainView.leftButton.isSelected
//                        self.mainView.leftButton.backgroundColor = Constants.BaseColor.white
                    }
                    self.mainView.rightButton.isSelected = !self.mainView.rightButton.isSelected
//                    self.mainView.rightButton.backgroundColor = Constants.brandColor.whiteGreen
                   
                }
            }
            .disposed(by: disposeBag)
        
        output.buttonTap
            .withUnretained(self)
            .bind { (vc, _) in
                let left = self.mainView.leftButton.isSelected
                let right = self.mainView.rightButton.isSelected
                let result = self.viewModel.checkGender(leftBool: left, rightBool: right)
                switch result {
                case .none:
                    self.mainView.makeToast("성별을 선택해 주세요.", duration: 1.5, position: .center)
                    User.gender = 2
                case .man:
                    self.mainView.makeToast("남자", duration: 1.5, position: .center)
                    User.gender = 1
                    print(User.gender)
                case .woman:
                    self.mainView.makeToast("여자", duration: 1.5, position: .center)
                    User.gender = 0
                    print(User.gender)
                }
            }
            .disposed(by: disposeBag)
        
    }
    
}
