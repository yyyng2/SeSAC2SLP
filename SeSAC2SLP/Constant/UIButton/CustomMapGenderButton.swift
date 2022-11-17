//
//  CustomMapGenderButton.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/18.
//

import UIKit

class CustomMapGenderButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        configurationUpdateHandler = { button in
              var config = button.configuration
            config?.baseForegroundColor = button.isSelected ? Constants.BaseColor.white : Constants.BaseColor.black
            config?.background.backgroundColor = button.isSelected ? Constants.brandColor.green : Constants.BaseColor.white
            config?.background.cornerRadius = 0
            config?.cornerStyle = .fixed
            button.configuration = config
        }
    }
}
