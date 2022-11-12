//
//  CustomSignDetailLabel.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/12.
//

import UIKit

class CustomSignDetailLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        textColor = Constants.grayScale.gray7
        backgroundColor = .clear
        font = UIFont(name: "NotoSansKR-Regular", size: 16)
        textAlignment = .center
    }
}
