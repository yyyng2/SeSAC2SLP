//
//  UserDetailHideView.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/15.
//

import UIKit

class UserDetailHideView: BaseView {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.BaseColor.black
        label.backgroundColor = .clear
        label.text = "새싹 타이틀"
        label.font = UIFont(name: "NotoSansKR-Medium", size: 12)
        label.textAlignment = .left
        return label
    }()
    
    let mannerTitleLabel: CustomSesacTitleLabel = {
       let label = CustomSesacTitleLabel()
        label.text = "좋은 매너"
        label.textColor = sesacTitleTextColor(i: User.reputation[0]).foregroundColor
        label.backgroundColor = sesacTitleBackgroundColor(i: User.reputation[0]).foregroundColor
        return label
    }()
    
    let timeTitleLabel: CustomSesacTitleLabel = {
       let label = CustomSesacTitleLabel()
        label.text = "정확한 시간 약속"
        label.textColor = sesacTitleTextColor(i: User.reputation[1]).foregroundColor
        label.backgroundColor = sesacTitleBackgroundColor(i: User.reputation[1]).foregroundColor
        return label
    }()
    
    let responseTitleLabel: CustomSesacTitleLabel = {
       let label = CustomSesacTitleLabel()
        label.text = "빠른 응답"
        label.textColor = sesacTitleTextColor(i: User.reputation[2]).foregroundColor
        label.backgroundColor = sesacTitleBackgroundColor(i: User.reputation[2]).foregroundColor
        return label
    }()
    
    let niceTitleLabel: CustomSesacTitleLabel = {
       let label = CustomSesacTitleLabel()
        label.text = "친절한 성격"
        label.textColor = sesacTitleTextColor(i: User.reputation[3]).foregroundColor
        label.backgroundColor = sesacTitleBackgroundColor(i: User.reputation[3]).foregroundColor
        return label
    }()
    
    let handyTitleLabel: CustomSesacTitleLabel = {
       let label = CustomSesacTitleLabel()
        label.text = "능숙한 실력"
        label.textColor = sesacTitleTextColor(i: User.reputation[4]).foregroundColor
        label.backgroundColor = sesacTitleBackgroundColor(i: User.reputation[4]).foregroundColor
        return label
    }()
    
    let beneficialTitleLabel: CustomSesacTitleLabel = {
       let label = CustomSesacTitleLabel()
        label.text = "유익한 시간"
        label.textColor = sesacTitleTextColor(i: User.reputation[4]).foregroundColor
        label.backgroundColor = sesacTitleBackgroundColor(i: User.reputation[4]).foregroundColor
        return label
    }()
    
    let reviewLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.BaseColor.black
        label.backgroundColor = .clear
        label.text = "새싹 리뷰"
        label.font = UIFont(name: "NotoSansKR-Medium", size: 12)
        label.textAlignment = .left
        return label
    }()
    
    override func configure() {
        [titleLabel, mannerTitleLabel, timeTitleLabel, responseTitleLabel, niceTitleLabel, handyTitleLabel, beneficialTitleLabel, reviewLabel].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(8)
            make.leading.equalTo(safeAreaLayoutGuide)
            make.width.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(safeAreaLayoutGuide).offset(0.1)
        }
        mannerTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.leading.equalTo(titleLabel.snp.leading)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.45)
            make.height.equalTo(titleLabel.snp.height)
        }
        timeTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.trailing.equalTo(titleLabel.snp.trailing)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.45)
            make.height.equalTo(titleLabel.snp.height)
        }
        responseTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(mannerTitleLabel.snp.bottom)
            make.leading.equalTo(titleLabel.snp.leading)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.45)
            make.height.equalTo(titleLabel.snp.height)
        }
        niceTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(mannerTitleLabel.snp.bottom)
            make.trailing.equalTo(titleLabel.snp.trailing)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.45)
            make.height.equalTo(titleLabel.snp.height)
        }
        handyTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(responseTitleLabel.snp.bottom)
            make.leading.equalTo(titleLabel.snp.leading)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.45)
            make.height.equalTo(titleLabel.snp.height)
        }
        beneficialTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(responseTitleLabel.snp.bottom)
            make.trailing.equalTo(titleLabel.snp.trailing)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.45)
            make.height.equalTo(titleLabel.snp.height)
        }
        reviewLabel.snp.makeConstraints { make in
            make.top.equalTo(beneficialTitleLabel.snp.bottom)
            make.leading.equalTo(safeAreaLayoutGuide)
            make.width.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(safeAreaLayoutGuide).offset(0.1)
        }
    }
}
