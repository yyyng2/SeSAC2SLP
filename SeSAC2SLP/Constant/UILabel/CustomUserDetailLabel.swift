//
//  CustomUserDetailLabel.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/19.
//

import UIKit

class CustomUserDetailLabel: UILabel {
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
        textAlignment = .left
    }
}
