//
//  BirthCheckViewController.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/10.
//

import UIKit

import RxCocoa
import RxSwift
import Toast

final class BirthCheckViewController: BaseSignViewController {
    let mainView = BirthCheckView()
    let viewModel = BirthCheckViewModel()
    let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDatePicker()
    }
    
    override func bind() {
    
        let date = "\(mainView.datePicker.rx.date)"
        
        let input = BirthCheckViewModel.Input (
            date: mainView.datePicker.rx.date,
            yearText: mainView.yearTextField.rx.text,
            monthText: mainView.monthTextField.rx.text,
            dayText: mainView.dayTextField.rx.text,
            buttonTap: mainView.nextButton.rx.tap
        )
        
        let output = viewModel.transform(input: input)
        
        output.yearValidStatus
            .withUnretained(self)
            .bind { (vc, value) in
                switch value {
                case true:
                    vc.setUIColor(value: value)
                case false:
                    vc.mainView.yearTextField.text = ""
                }
             
            }
            .disposed(by: disposeBag)
        
        output.monthValidStatus
            .withUnretained(self)
            .bind { (vc, value) in
                switch value {
                case true:
                    vc.setUIColor(value: value)
                case false:
                    vc.mainView.monthTextField.text = ""
                }
            }
            .disposed(by: disposeBag)
        
        output.dayValidStatus
            .withUnretained(self)
            .bind { (vc, value) in
                switch value {
                case true:
                    vc.setUIColor(value: value)
                case false:
                    vc.mainView.dayTextField.text = ""
                }
            }
            .disposed(by: disposeBag)
        
        
        output.date
            .withUnretained(self)
            .bind { (vc, value) in
                let year = value.formatToString(dateStyle: .year)
                let month = value.formatToString(dateStyle: .month)
                let day = value.formatToString(dateStyle: .day)
         
                vc.mainView.yearTextField.text = "\(year)"
                vc.mainView.monthTextField.text = "\(month)"
                vc.mainView.dayTextField.text = "\(day)"
            }
            .disposed(by: disposeBag)
        
        output.buttonTap
            .withUnretained(self)
            .bind { (vc, _) in
                
                guard let year = vc.mainView.yearTextField.text else { return }
                guard let month = vc.mainView.monthTextField.text else { return }
                guard let day = vc.mainView.dayTextField.text else { return }
                
                let string = "\(year)-\(month)-\(day)"
                print(string.changeToDate())
                let result = vc.viewModel.checkAge(date: string.changeToDate())
                switch result {
                case true:
                    User.birth = string.changeToBirthSave
                    print(User.birth)
//                    print("\(string.changeToBirthSave())")
//                    print(User.birth, User.fcm)
                    let vc = EmailCheckViewController()
                    self.navigationController?.pushViewController(vc, animated: true)
                case false:
                    self.mainView.makeToast("새싹스터디는 만 17세 이상만 사용할 수 있습니다.", duration: 1.5, position: .center)
                }
            }
            .disposed(by: disposeBag)
    }
    
    func setUpDatePicker() {
        mainView.yearTextField.inputView = mainView.datePicker
        mainView.monthTextField.inputView = mainView.datePicker
        mainView.dayTextField.inputView = mainView.datePicker
    }
    
    func setUIColor(value: Bool) {
        let color = value ? Constants.brandColor.green : Constants.grayScale.gray6
        let lineColor = value ? Constants.BaseColor.black : Constants.grayScale.gray6
        mainView.nextButton.backgroundColor = color
        mainView.yearTextField.underLineView.backgroundColor = lineColor
        mainView.dayTextField.underLineView.backgroundColor = lineColor
        mainView.monthTextField.underLineView.backgroundColor = lineColor
    }
    
}
