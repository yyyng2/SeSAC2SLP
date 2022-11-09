//
//  NicknameView.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/09.
//

import Foundation

final class NicknameCheckView: BaseView {
    let nicknameViewInfoLabel: CustomSignLabel = {
       let label = CustomSignLabel()
        label.numberOfLines = 1
        label.text = """
                    닉네임을 입력해 주세요
                    """
        return label
    }()
    
    let nicknameTextField: CustomSignTextField = {
       let textfield = CustomSignTextField()
        textfield.placeholder = "10자 이내로 입력"
        textfield.keyboardType = .numberPad
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
        [nicknameViewInfoLabel, nicknameTextField, nextButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        nicknameViewInfoLabel.snp.makeConstraints { make in
            make.centerX.width.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.2)
            make.centerY.equalTo(safeAreaLayoutGuide).multipliedBy(0.5)
        }
        nicknameTextField.snp.makeConstraints { make in
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.9)
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.1)
            make.centerY.equalTo(safeAreaLayoutGuide).multipliedBy(0.75)
        }
        nextButton.snp.makeConstraints { make in
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.width.height.equalTo(nicknameTextField)
            make.centerY.equalTo(safeAreaLayoutGuide).multipliedBy(1.1)
            
        }
    }
}
