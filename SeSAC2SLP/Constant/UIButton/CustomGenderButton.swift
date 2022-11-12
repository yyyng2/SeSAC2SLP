//
//  CustomGenderButton.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/12.
//

import UIKit

class CustomGenderButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        layer.cornerRadius = 10
        configurationUpdateHandler = { button in
              var config = button.configuration
            config?.background.backgroundColor = button.isSelected ? Constants.brandColor.whiteGreen : Constants.BaseColor.white
            config?.background.strokeColor = button.isSelected ? Constants.brandColor.whiteGreen : Constants.grayScale.gray3
            config?.background.strokeWidth = 1
            button.configuration = config
        }
    }
}
