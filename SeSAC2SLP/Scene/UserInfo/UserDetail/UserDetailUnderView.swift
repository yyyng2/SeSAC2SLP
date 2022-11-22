//
//  UserDetailUnderView.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/19.
//

import UIKit

import MultiSlider

class UserDetailUnderView: BaseView {
    let genderLabel: CustomUserDetailLabel = {
        let label = CustomUserDetailLabel()
        label.text = "내 성별"
        return label
    }()
    let maleButton: CustomMapGenderButton = {
        var config = CustomMapGenderButton.Configuration.plain()
        var titleAttr = AttributedString.init("남자")
        titleAttr.font = UIFont(name: "NotoSansKR-Regular", size: 14)
        config.attributedTitle = titleAttr
        config.titleAlignment = .center
        
        let button = CustomMapGenderButton(configuration: config)
        button.layer.cornerRadius = 8
        button.tag = 1
        
        return button
    }()
    let femaleButton: CustomMapGenderButton = {
        var config = CustomMapGenderButton.Configuration.plain()
        var titleAttr = AttributedString.init("여자")
        titleAttr.font = UIFont(name: "NotoSansKR-Regular", size: 14)
        config.attributedTitle = titleAttr
        config.titleAlignment = .center
        
        let button = CustomMapGenderButton(configuration: config)
        button.layer.cornerRadius = 8
        button.tag = 0
        
        return button
    }()
    let favoriteStudyLabel: CustomUserDetailLabel = {
        let label = CustomUserDetailLabel()
        label.text = "자주 하는 스터디"
        return label
    }()
    let favoriteStudyTextField: CustomSignTextField = {
        let textfield = CustomSignTextField()
         textfield.placeholder = "스터디를 입력해 주세요"
         textfield.keyboardType = .default
         return textfield
    }()
    let numberPublicStatusLabel: CustomUserDetailLabel = {
        let label = CustomUserDetailLabel()
        label.text = "내 번호 검색 허용"
        return label
    }()
    let numberPublicStatusSwitch: UISwitch = {
        let button = UISwitch()
        button.onTintColor = Constants.brandColor.green
        return button
    }()
    let favoriteAgeLabel: CustomUserDetailLabel = {
        let label = CustomUserDetailLabel()
        label.text = "상대방 연령대"
        return label
    }()
    let ageLabel: CustomUserDetailLabel = {
        let label = CustomUserDetailLabel()
        label.textAlignment = .right
        label.textColor = Constants.brandColor.green
        return label
    }()
    let slider: MultiSlider = {
       let slider = MultiSlider()
        slider.minimumValue = 18
        slider.maximumValue = 65
        slider.value = [18, 25]
        slider.orientation = .horizontal
        slider.outerTrackColor = Constants.grayScale.gray2
        slider.tintColor = Constants.brandColor.green
        slider.thumbTintColor = Constants.brandColor.green
        return slider
    }()
    let withDrawLabel: CustomUserDetailLabel = {
        let label = CustomUserDetailLabel()
        label.text = "회원 탈퇴"
        return label
    }()
    let withDrawButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    override func configure() {
        [genderLabel, maleButton, femaleButton, favoriteStudyLabel, favoriteStudyTextField, numberPublicStatusLabel, numberPublicStatusSwitch, favoriteAgeLabel, ageLabel, slider, withDrawLabel, withDrawButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        genderLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(32)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.5)
            make.leading.equalTo(12)
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.05)
        }
        maleButton.snp.makeConstraints { make in
            make.centerY.equalTo(genderLabel)
            make.trailing.equalTo(femaleButton.snp.leading).offset(-8)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.14)
            make.height.equalTo(femaleButton.snp.width)
        }
        femaleButton.snp.makeConstraints { make in
            make.centerY.equalTo(genderLabel)
            make.trailing.equalTo(-12)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.14)
            make.height.equalTo(femaleButton.snp.width)
        }
        favoriteStudyLabel.snp.makeConstraints { make in
            make.top.equalTo(genderLabel.snp.bottom).offset(40)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.5)
            make.leading.equalTo(genderLabel.snp.leading)
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.05)
        }
        favoriteStudyTextField.snp.makeConstraints { make in
            make.centerY.equalTo(favoriteStudyLabel)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.5)
            make.leading.equalTo(favoriteStudyLabel.snp.trailing)
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.1)
        }
        numberPublicStatusLabel.snp.makeConstraints { make in
            make.top.equalTo(favoriteStudyLabel.snp.bottom).offset(40)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.45)
            make.leading.equalTo(genderLabel.snp.leading)
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.05)
        }
        numberPublicStatusSwitch.snp.makeConstraints { make in
            make.centerY.equalTo(numberPublicStatusLabel)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.14)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-12)
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.08)
        }
        favoriteAgeLabel.snp.makeConstraints { make in
            make.top.equalTo(numberPublicStatusLabel.snp.bottom).offset(40)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.5)
            make.leading.equalTo(genderLabel.snp.leading)
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.05)
        }
        ageLabel.snp.makeConstraints { make in
            make.top.equalTo(favoriteAgeLabel.snp.top)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.5)
            make.trailing.equalTo(-12)
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.05)
        }
        slider.snp.makeConstraints { make in
            make.top.equalTo(favoriteAgeLabel.snp.bottom).offset(20)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.8)
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.1)
            make.centerX.equalTo(safeAreaLayoutGuide)
        }
        withDrawLabel.snp.makeConstraints { make in
            make.top.equalTo(slider.snp.bottom).offset(30)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.5)
            make.leading.equalTo(genderLabel.snp.leading)
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.05)
        }
        withDrawButton.snp.makeConstraints { make in
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.6)
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.08)
            make.leading.equalTo(withDrawLabel.snp.leading)
            make.centerY.equalTo(withDrawLabel)
        }
    }
    
}
