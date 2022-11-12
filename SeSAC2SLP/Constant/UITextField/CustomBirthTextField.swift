//
//  CustomBirthTextField.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/11.
//

import UIKit

class CustomBirthTextField: UITextField {
    
    lazy var underLineView: UIView = {
       let view = UIView()
        view.backgroundColor = Constants.grayScale.gray5
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        addSubview(underLineView)
        tintColor = .clear
        resignFirstResponder()
        font = UIFont(name: "NotoSansKR-Regular", size: 16)
        underLineView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
    }
    
}
