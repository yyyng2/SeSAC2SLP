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
    let favoriteStudyLabel: CustomUserDetailLabel = {
        let label = CustomUserDetailLabel()
        label.text = "자주 하는 스터디"
        return label
    }()
    let numberPublicStatusLabel: CustomUserDetailLabel = {
        let label = CustomUserDetailLabel()
        label.text = "내 번호 검색 허용"
        return label
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
        slider.maximumValue = 70
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
        [genderLabel, favoriteStudyLabel, numberPublicStatusLabel, favoriteAgeLabel, ageLabel, slider, withDrawLabel, withDrawButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        genderLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(20)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.5)
            make.leading.equalTo(12)
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.05)
        }
        favoriteStudyLabel.snp.makeConstraints { make in
            make.top.equalTo(genderLabel.snp.bottom).offset(20)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.5)
            make.leading.equalTo(genderLabel.snp.leading)
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.05)
        }
        numberPublicStatusLabel.snp.makeConstraints { make in
            make.top.equalTo(favoriteStudyLabel.snp.bottom).offset(20)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.5)
            make.leading.equalTo(genderLabel.snp.leading)
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.05)
        }
        favoriteAgeLabel.snp.makeConstraints { make in
            make.top.equalTo(numberPublicStatusLabel.snp.bottom).offset(20)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.5)
            make.leading.equalTo(genderLabel.snp.leading)
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.05)
        }
        ageLabel.snp.makeConstraints { make in
            make.top.equalTo(numberPublicStatusLabel.snp.bottom).offset(20)
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
            make.top.equalTo(slider.snp.bottom).offset(20)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.5)
            make.leading.equalTo(genderLabel.snp.leading)
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.05)
        }
        withDrawButton.snp.makeConstraints { make in
            make.edges.equalTo(withDrawLabel)
        }
    }
    
}
