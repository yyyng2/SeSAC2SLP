//
//  UserMenuTableViewCell.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/15.
//

import UIKit

class UserMenuTableViewCell: BaseTableViewCell {
    static var id = String(describing: UserMenuTableViewCell.self)
    
    let menuView: UIImageView = {
       let view = UIImageView()
        return view
    }()
    
    let menuLabel: UILabel = {
       let label = UILabel()
        label.textColor = Constants.BaseColor.black
        label.backgroundColor = .clear
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textAlignment = .left
        return label
    }()
    
    override func configure() {
        [menuView, menuLabel].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        menuView.snp.makeConstraints { make in
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.07)
            make.height.equalTo(menuView.snp.width)
            make.leading.equalTo(safeAreaLayoutGuide).offset(20)
            make.centerY.equalTo(safeAreaLayoutGuide)
        }
        menuLabel.snp.makeConstraints { make in
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.7)
            make.height.equalTo(safeAreaLayoutGuide)
            make.leading.equalTo(menuView.snp.trailing).offset(8)
            make.centerY.equalTo(safeAreaLayoutGuide)
        }
    }
    
}
