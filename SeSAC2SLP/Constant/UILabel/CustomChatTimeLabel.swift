//
//  CustomChatTimeLabel.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/12/02.
//

import UIKit

class CustomChatTimeLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        font = UIFont(name: "NotoSansKR-Regular", size: 12)
        textColor = Constants.grayScale.gray6
        backgroundColor = .clear
        textAlignment = .center
    }
}
