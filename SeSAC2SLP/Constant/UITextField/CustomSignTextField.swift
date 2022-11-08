//
//  CustomSignTextField.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/08.
//

import UIKit

class CustomSignTextField: UITextField {
    
    private lazy var underLineView: UIView = {
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
        
        underLineView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
    }
    
}
