//
//  EmailCheckView.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/12.
//

import UIKit

final class EmailCheckView: BaseView {
    let EmailViewInfoLabel: CustomSignLabel = {
       let label = CustomSignLabel()
        label.numberOfLines = 1
        label.text = """
                    이메일을 입력해 주세요
                    """
        return label
    }()
    
    let EmailViewInfoDetailLabel: CustomSignDetailLabel = {
       let label = CustomSignDetailLabel()
        label.numberOfLines = 1
        label.text = """
                    휴대폰 번호 변경 시 인증을 위해 사용해요
                    """
        return label
    }()
    
    let emailTextField: CustomSignTextField = {
       let textfield = CustomSignTextField()
        textfield.placeholder = "SeSAC@email.com"
        textfield.keyboardType = .default
        return textfield
    }()
    
    let nextButton: CustomSignButton = {
       let button = CustomSignButton()
        button.backgroundColor = Constants.brandColor.green
        button.setTitle("다음", for: .normal)
        return button
    }()
    
    override func configure() {
        backgroundColor = Constants.BaseColor.white
        [EmailViewInfoLabel, EmailViewInfoDetailLabel, emailTextField, nextButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        EmailViewInfoLabel.snp.makeConstraints { make in
            make.centerX.width.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.2)
            make.centerY.equalTo(safeAreaLayoutGuide).multipliedBy(0.45)
        }
        EmailViewInfoDetailLabel.snp.makeConstraints { make in
            make.centerX.width.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.2)
            make.centerY.equalTo(safeAreaLayoutGuide).multipliedBy(0.55)
        }
        emailTextField.snp.makeConstraints { make in
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.9)
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.1)
            make.centerY.equalTo(safeAreaLayoutGuide).multipliedBy(0.75)
        }
        nextButton.snp.makeConstraints { make in
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.9)
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.07)
            make.centerY.equalTo(safeAreaLayoutGuide).multipliedBy(1)
            
        }
    }
}
