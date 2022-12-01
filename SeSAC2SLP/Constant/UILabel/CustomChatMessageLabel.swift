//
//  CustomChatMessageLabel.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/12/02.
//

import UIKit

class CustomChatMessageLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        font = UIFont(name: "NotoSansKR-Regular", size: 14)
        textColor = Constants.BaseColor.black
        numberOfLines = 0
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = Constants.grayScale.gray4!.cgColor
        backgroundColor = .clear
        textAlignment = .left
    }
}
