//
//  GenderCheckView.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/12.
//

import UIKit

final class GenderCheckView: BaseView {
    let GenderViewInfoLabel: CustomSignLabel = {
       let label = CustomSignLabel()
        label.numberOfLines = 1
        label.text = """
                    성별을 선택해 주세요
                    """
        return label
    }()
    
    let GenderViewInfoDetailLabel: CustomSignDetailLabel = {
       let label = CustomSignDetailLabel()
        label.numberOfLines = 1
        label.text = """
                    새싹 찾기 기능을 이용하기 위해서 필요해요!
                    """
        return label
    }()
    
    let leftButton: CustomGenderButton = {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(named: "man")
        config.imagePlacement = .top
        config.baseForegroundColor = Constants.BaseColor.black
        var titleAttr = AttributedString.init("남자")
        titleAttr.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        config.attributedTitle = titleAttr
        
      
        
        config.buttonSize = .large
        config.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        
       let button = CustomGenderButton(configuration: config)
        
//        button.configurationUpdateHandler = { button in
//              var config = button.configuration
//            config?.baseBackgroundColor = button.isSelected ? Constants.brandColor.whiteGreen : Constants.BaseColor.white
//            button.configuration = config
//        }
    
        return button
    }()
    
    let rightButton: CustomGenderButton = {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(named: "woman")
        config.imagePlacement = .top
        config.baseForegroundColor = Constants.BaseColor.black
        var titleAttr = AttributedString.init("여자")
        titleAttr.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        config.attributedTitle = titleAttr
        
      
        
        config.buttonSize = .large
        config.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        
       let button = CustomGenderButton(configuration: config)
        
//        button.configurationUpdateHandler = { button in
//              var config = button.configuration
//            config?.background.backgroundColor = button.isSelected ? Constants.brandColor.whiteGreen : Constants.BaseColor.white
//            button.configuration = config
//        }

        return button
    }()
    
    let nextButton: CustomSignButton = {
       let button = CustomSignButton()
        button.backgroundColor = Constants.brandColor.green
        button.setTitle("다음", for: .normal)
        return button
    }()
    
    override func configure() {
        backgroundColor = Constants.BaseColor.white
        [GenderViewInfoLabel, GenderViewInfoDetailLabel, leftButton, rightButton, nextButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        GenderViewInfoLabel.snp.makeConstraints { make in
            make.centerX.width.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.2)
            make.centerY.equalTo(safeAreaLayoutGuide).multipliedBy(0.45)
        }
        GenderViewInfoDetailLabel.snp.makeConstraints { make in
            make.centerX.width.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.2)
            make.centerY.equalTo(safeAreaLayoutGuide).multipliedBy(0.55)
        }
        leftButton.snp.makeConstraints { make in
            make.centerX.equalTo(safeAreaLayoutGuide).multipliedBy(0.5)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.4)
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.15)
            make.centerY.equalTo(safeAreaLayoutGuide).multipliedBy(0.75)
        }
        
        rightButton.snp.makeConstraints { make in
            make.centerX.equalTo(safeAreaLayoutGuide).multipliedBy(1.5)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.4)
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.15)
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
