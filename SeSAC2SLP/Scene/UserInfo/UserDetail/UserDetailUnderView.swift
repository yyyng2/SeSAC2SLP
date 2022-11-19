//
//  UserDetailUnderView.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/19.
//

import UIKit

import MultiSlider

class UserDetailUnderView: BaseView {
    let genderLabel: CustomSesacTitleLabel = {
        let label = CustomSesacTitleLabel()
        label.text = "내 성별"
        label.textColor = Constants.BaseColor.black
        return label
    }()
    let favoriteStudyLabel: CustomSesacTitleLabel = {
        let label = CustomSesacTitleLabel()
        label.text = "자주 하는 스터디"
        label.textColor = Constants.BaseColor.black
        return label
    }()
    let numberPublicStatusLabel: CustomSesacTitleLabel = {
        let label = CustomSesacTitleLabel()
        label.text = "내 번호 검색 허용"
        label.textColor = Constants.BaseColor.black
        return label
    }()
    let favoriteAgeLabel: CustomSesacTitleLabel = {
        let label = CustomSesacTitleLabel()
        label.text = "상대방 연령대"
        label.textColor = Constants.BaseColor.black
        return label
    }()
    let ageLabel: CustomSesacTitleLabel = {
        let label = CustomSesacTitleLabel()
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
    let withDrawButton: UIButton = {
       let button = UIButton()
        button.setTitle("회원 탈퇴", for: .normal)
        return button
    }()
    
    override func configure() {
        [genderLabel, favoriteStudyLabel, numberPublicStatusLabel, favoriteAgeLabel, ageLabel, slider, withDrawButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        genderLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(20)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.5)
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.05)
        }
        favoriteStudyLabel.snp.makeConstraints { make in
            make.top.equalTo(genderLabel.snp.bottom).offset(20)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.5)
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.05)
        }
        numberPublicStatusLabel.snp.makeConstraints { make in
            make.top.equalTo(favoriteStudyLabel.snp.bottom).offset(20)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.5)
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.05)
        }
        favoriteAgeLabel.snp.makeConstraints { make in
            make.top.equalTo(numberPublicStatusLabel.snp.bottom).offset(20)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.5)
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.05)
        }
        ageLabel.snp.makeConstraints { make in
            make.top.equalTo(numberPublicStatusLabel.snp.bottom).offset(20)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.5)
            make.trailing.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.05)
        }
        slider.snp.makeConstraints { make in
            make.top.equalTo(favoriteAgeLabel.snp.bottom).offset(20)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.8)
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.1)
            make.centerX.equalTo(safeAreaLayoutGuide)
        }
        withDrawButton.snp.makeConstraints { make in
            make.top.equalTo(slider.snp.bottom).offset(20)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.5)
            make.trailing.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.05)
        }
    }
    
}
