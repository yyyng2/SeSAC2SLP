//
//  CheckCodeView.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/09.
//

import UIKit

final class CheckCodeView: BaseView {
    let CheckCodeViewInfoLabel: CustomSignLabel = {
       let label = CustomSignLabel()
        label.numberOfLines = 1
        label.text = """
                    인증번호가 문자로 전송되었어요
                    """
        return label
    }()
    
    let codeTextField: CustomSignTextField = {
       let textfield = CustomSignTextField()
        textfield.placeholder = "인증번호 입력"
        textfield.keyboardType = .numberPad
        return textfield
    }()
    
    let resendCodeButton: CustomSignButton = {
       let button = CustomSignButton()
        button.backgroundColor = Constants.brandColor.green
        button.setTitle("재전송", for: .normal)
        return button
    }()
    
    let startSignButton: CustomSignButton = {
       let button = CustomSignButton()
        button.backgroundColor = Constants.brandColor.green
        button.setTitle("인증하고 시작하기", for: .normal)
        return button
    }()
    
    override func configure() {
        backgroundColor = Constants.BaseColor.white
        [CheckCodeViewInfoLabel, codeTextField, resendCodeButton, startSignButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        CheckCodeViewInfoLabel.snp.makeConstraints { make in
            make.centerX.width.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.2)
            make.centerY.equalTo(safeAreaLayoutGuide).multipliedBy(0.5)
        }
        codeTextField.snp.makeConstraints { make in
            make.centerX.equalTo(safeAreaLayoutGuide).multipliedBy(0.8)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.65)
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.1)
            make.centerY.equalTo(safeAreaLayoutGuide).multipliedBy(0.75)
        }
        resendCodeButton.snp.makeConstraints { make in
            make.leading.equalTo(codeTextField.snp.trailing)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.2)
            make.height.centerY.equalTo(codeTextField)
        }
        startSignButton.snp.makeConstraints { make in
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.width.height.equalTo(codeTextField)
            make.centerY.equalTo(safeAreaLayoutGuide).multipliedBy(1.1)
            
        }
    }
    
}
