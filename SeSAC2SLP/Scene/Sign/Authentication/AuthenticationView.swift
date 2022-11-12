//
//  AuthenticationView.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/08.
//

import UIKit

final class AuthenticationView: BaseView {
    let authenticationViewInfoLabel: CustomSignLabel = {
       let label = CustomSignLabel()
        label.numberOfLines = 2
        label.text = """
                    새싹 서비스 이용을 위해
                    휴대폰 번호를 입력해 주세요
                    """
        return label
    }()
    
    let phoneNumberTextField: CustomSignTextField = {
       let textfield = CustomSignTextField()
        textfield.placeholder = "휴대폰 번호 (- 없이 숫자만 입력)"

        textfield.keyboardType = .numberPad
        return textfield
    }()
    
    let sendCodeButton: CustomSignButton = {
       let button = CustomSignButton()
        button.backgroundColor = Constants.brandColor.green
        button.setTitle("인증 문자 받기", for: .normal)
        return button
    }()
    
    override func configure() {
        backgroundColor = Constants.BaseColor.white
        [authenticationViewInfoLabel, phoneNumberTextField, sendCodeButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        authenticationViewInfoLabel.snp.makeConstraints { make in
            make.centerX.width.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.2)
            make.centerY.equalTo(safeAreaLayoutGuide).multipliedBy(0.5)
        }
        phoneNumberTextField.snp.makeConstraints { make in
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.9)
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.1)
            make.centerY.equalTo(safeAreaLayoutGuide).multipliedBy(0.75)
        }
        sendCodeButton.snp.makeConstraints { make in
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.9)
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.07)
            make.centerY.equalTo(safeAreaLayoutGuide).multipliedBy(1)
            
        }
    }
}
