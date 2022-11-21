//
//  ExpandView.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/19.
//

import UIKit

class ExpandView: BaseView {
    let sesacTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.BaseColor.black
        label.backgroundColor = .clear
        label.text = "새싹 타이틀"
        label.font = UIFont(name: "NotoSansKR-Regular", size: 12)
        label.textAlignment = .left
        return label
    }()
    
    let mannerTitleLabel: CustomSesacTitleLabel = {
       let label = CustomSesacTitleLabel()
        label.text = "좋은 매너"
        label.textColor = sesacTitleColor(i: User.reputation[0]).textColor
        label.layer.borderColor = sesacTitleColor(i: User.reputation[0]).borderColor
        label.backgroundColor = sesacTitleColor(i: User.reputation[0]).backgroundColor
        return label
    }()
    
    let timeTitleLabel: CustomSesacTitleLabel = {
       let label = CustomSesacTitleLabel()
        label.text = "정확한 시간 약속"
        label.textColor = sesacTitleColor(i: User.reputation[1]).textColor
        label.layer.borderColor = sesacTitleColor(i: User.reputation[1]).borderColor
        label.backgroundColor = sesacTitleColor(i: User.reputation[1]).backgroundColor
        return label
    }()
    
    let responseTitleLabel: CustomSesacTitleLabel = {
       let label = CustomSesacTitleLabel()
        label.text = "빠른 응답"
        label.textColor = sesacTitleColor(i: User.reputation[2]).textColor
        label.layer.borderColor = sesacTitleColor(i: User.reputation[2]).borderColor
        label.backgroundColor = sesacTitleColor(i: User.reputation[2]).backgroundColor
        return label
    }()
    
    let niceTitleLabel: CustomSesacTitleLabel = {
       let label = CustomSesacTitleLabel()
        label.text = "친절한 성격"
        label.textColor = sesacTitleColor(i: User.reputation[3]).textColor
        label.layer.borderColor = sesacTitleColor(i: User.reputation[3]).borderColor
        label.backgroundColor = sesacTitleColor(i: User.reputation[3]).backgroundColor
        return label
    }()
    
    let handyTitleLabel: CustomSesacTitleLabel = {
       let label = CustomSesacTitleLabel()
        label.text = "능숙한 실력"
        label.textColor = sesacTitleColor(i: User.reputation[4]).textColor
        label.layer.borderColor = sesacTitleColor(i: User.reputation[4]).borderColor
        label.backgroundColor = sesacTitleColor(i: User.reputation[4]).backgroundColor
        return label
    }()
    
    let beneficialTitleLabel: CustomSesacTitleLabel = {
       let label = CustomSesacTitleLabel()
        label.text = "유익한 시간"
        label.textColor = sesacTitleColor(i: User.reputation[5]).textColor
        label.layer.borderColor = sesacTitleColor(i: User.reputation[5]).borderColor
        label.backgroundColor = sesacTitleColor(i: User.reputation[5]).backgroundColor
        return label
    }()
    
    let sesacReviewLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.BaseColor.black
        label.backgroundColor = .clear
        label.text = "새싹 리뷰"
        label.font = UIFont(name: "NotoSansKR-Regular", size: 12)
        label.textAlignment = .left
        return label
    }()
    
    let sesacReviewButton: UIButton = {
      
        var config = UIButton.Configuration.plain()
        config.baseForegroundColor = Constants.BaseColor.black
        config.imagePlacement = .trailing
        config.image = UIImage(named: "more_arrow")

        let button = UIButton(configuration: config)
        button.isHidden = true
        return button
    }()
    
    let sesacReviewTextView: UITextView = {
       let view = UITextView()
        view.font = UIFont(name: "NotoSansKR-Regular", size: 14)
        view.sizeToFit()
        return view
    }()
    
    let stackView: UIStackView = {
       let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .fill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func configure() {
//        self.addSubview(stackView)
        
        [sesacTitleLabel, mannerTitleLabel, timeTitleLabel, responseTitleLabel, niceTitleLabel, handyTitleLabel, beneficialTitleLabel, sesacReviewLabel, sesacReviewButton, sesacReviewTextView].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        sesacTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(8)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.9)
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.1)
        }
        mannerTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(sesacTitleLabel.snp.bottom)
            make.leading.equalTo(sesacTitleLabel.snp.leading)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.43)
            make.height.equalTo(sesacTitleLabel.snp.height)
        }
        timeTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(sesacTitleLabel.snp.bottom)
            make.trailing.equalTo(sesacTitleLabel.snp.trailing)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.43)
            make.height.equalTo(sesacTitleLabel.snp.height)
        }
        responseTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(mannerTitleLabel.snp.bottom)
            make.leading.equalTo(sesacTitleLabel.snp.leading)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.43)
            make.height.equalTo(sesacTitleLabel.snp.height)
        }
        niceTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(mannerTitleLabel.snp.bottom)
            make.trailing.equalTo(sesacTitleLabel.snp.trailing)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.43)
            make.height.equalTo(sesacTitleLabel.snp.height)
        }
        handyTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(responseTitleLabel.snp.bottom)
            make.leading.equalTo(sesacTitleLabel.snp.leading)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.43)
            make.height.equalTo(sesacTitleLabel.snp.height)
        }
        beneficialTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(responseTitleLabel.snp.bottom)
            make.trailing.equalTo(sesacTitleLabel.snp.trailing)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.43)
            make.height.equalTo(sesacTitleLabel.snp.height)
        }
        sesacReviewLabel.snp.makeConstraints { make in
            make.top.equalTo(beneficialTitleLabel.snp.bottom)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.9)
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.1)
        }
        sesacReviewButton.snp.makeConstraints { make in
            make.top.equalTo(beneficialTitleLabel.snp.bottom)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.9)
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.1)
        }
        sesacReviewTextView.snp.makeConstraints { make in
            make.top.equalTo(sesacReviewLabel.snp.bottom)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.9)
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.1)
        }
    }
}
