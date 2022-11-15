//
//  CustomSesacTitleLabel.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/15.
//

import UIKit

class CustomSesacTitleLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        font = UIFont(name: "NotoSansKR-Regular", size: 14)
        textAlignment = .center
    }
}
