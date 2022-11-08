//
//  CustomSignLabel.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/08.
//

import UIKit

class CustomSignLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        textColor = Constants.BaseColor.black
        backgroundColor = .clear
        font = UIFont(name: "NotoSansKR-Regular", size: 20)
        textAlignment = .center
    }
}
