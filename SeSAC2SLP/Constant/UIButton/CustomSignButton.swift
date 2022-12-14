//
//  CustomSignButton.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/08.
//

import UIKit

class CustomSignButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        layer.cornerRadius = 10
    }
}
