//
//  BasePopupView.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/26.
//

import UIKit

class BasePopupView: BaseView {
    let whiteBackgroundView: UIView = {
       let view = UIView()
        view.backgroundColor = Constants.BaseColor.white
        view.layer.cornerRadius = 8
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.BaseColor.black
        label.backgroundColor = .clear
        label.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        label.text = ""
        label.textAlignment = .center
        return label
    }()
    
    let contentLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.BaseColor.black
        label.backgroundColor = .clear
        label.font = UIFont(name: "NotoSansKR-Regular", size: 14)
        label.text = ""
        label.textAlignment = .center
        return label
    }()
    
    let cancelButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.background.backgroundColor = Constants.grayScale.gray2
        var titleAttr = AttributedString.init("취소")
        titleAttr.font = UIFont(name: "NotoSansKR-Regular", size: 14)
        titleAttr.foregroundColor = Constants.BaseColor.black
        config.attributedTitle = titleAttr
        
        let button = UIButton(configuration: config)
        button.layer.cornerRadius = 8
        return button
    }()
    
    let confirmButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.background.backgroundColor = Constants.brandColor.green
        var titleAttr = AttributedString.init("확인")
        titleAttr.font = UIFont(name: "NotoSansKR-Regular", size: 14)
        titleAttr.foregroundColor = Constants.BaseColor.white
        config.attributedTitle = titleAttr
        
        let button = UIButton(configuration: config)
        button.layer.cornerRadius = 8
        return button
    }()
    
    override func configure() {
        backgroundColor = Constants.BaseColor.black?.withAlphaComponent(0.8)
        
        self.addSubview(whiteBackgroundView)
        
        [titleLabel, contentLabel, cancelButton, confirmButton].forEach {
            whiteBackgroundView.addSubview($0)
        }
    }
    
    override func setConstraints() {
        whiteBackgroundView.snp.makeConstraints { make in
            make.center.equalTo(safeAreaLayoutGuide)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.9)
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.3)
        }
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(whiteBackgroundView)
            make.centerY.equalTo(whiteBackgroundView).multipliedBy(0.45)
            make.width.equalTo(whiteBackgroundView)
        }
        contentLabel.snp.makeConstraints { make in
            make.centerX.equalTo(whiteBackgroundView)
            make.centerY.equalTo(whiteBackgroundView).multipliedBy(0.9)
            make.width.equalTo(whiteBackgroundView)
        }
        cancelButton.snp.makeConstraints { make in
            make.centerY.equalTo(whiteBackgroundView).multipliedBy(1.5)
            make.width.equalTo(whiteBackgroundView).multipliedBy(0.4)
            make.height.equalTo(whiteBackgroundView).multipliedBy(0.3)
            make.centerX.equalTo(whiteBackgroundView).multipliedBy(0.5)
        }
        confirmButton.snp.makeConstraints { make in
            make.centerY.equalTo(whiteBackgroundView).multipliedBy(1.5)
            make.width.equalTo(whiteBackgroundView).multipliedBy(0.4)
            make.height.equalTo(whiteBackgroundView).multipliedBy(0.3)
            make.centerX.equalTo(whiteBackgroundView).multipliedBy(1.5)
        }
    }
}
