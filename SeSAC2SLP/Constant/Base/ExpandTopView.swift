//
//  ExpandTopView.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/19.
//

import UIKit

class ExpandTopView: BaseView {
    let backgroundImageView: UIImageView = {
       let view = UIImageView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    let profileImageView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    let profileLabel: UILabel = {
       let label = UILabel()
        label.textColor = Constants.BaseColor.black
        label.backgroundColor = .clear
        label.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        label.textAlignment = .left
        return label
    }()
    let arrowImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "chevron.down")
        view.tintColor = Constants.grayScale.gray7
        return view
    }()
    var expandButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        return button
    }()
    
    override func configure() {
        [backgroundImageView, profileImageView, expandButton, profileLabel, arrowImage].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        backgroundImageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(12)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.9)
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.75)
            make.centerX.equalTo(safeAreaLayoutGuide)
        }
        profileImageView.snp.makeConstraints { make in
            make.bottom.equalTo(backgroundImageView.snp.bottom).multipliedBy(1)
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.width.equalTo(backgroundImageView.snp.width).multipliedBy(0.6)
            make.height.equalTo(backgroundImageView.snp.height).multipliedBy(0.85)
        }
        profileLabel.snp.makeConstraints { make in
            make.top.equalTo(expandButton.snp.top)
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.8)
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.1)
        }
        arrowImage.snp.makeConstraints { make in
            make.centerY.equalTo(profileLabel.snp.centerY)
            make.width.equalTo(profileLabel.snp.width).multipliedBy(0.05)
            make.height.equalTo(arrowImage.snp.width)
            make.trailing.equalTo(profileLabel.snp.trailing)
        }
        expandButton.snp.makeConstraints { make in
            make.top.equalTo(backgroundImageView.snp.bottom).offset(20)
            make.width.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.1)
        }
    }
}
