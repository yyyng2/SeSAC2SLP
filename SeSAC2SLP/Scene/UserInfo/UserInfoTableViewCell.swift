//
//  UserInfoTableViewCell.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/15.
//

import UIKit

class UserInfoTableViewCell: BaseTableViewCell {
    static var id = String(describing: UserInfoTableViewCell.self)
    
    let circleView: UIImageView = {
      let view = UIImageView()
        view.image = UIImage(named: "Ellipse")
       return view
   }()
    
     let profileView: UIImageView = {
       let view = UIImageView()
        view.clipsToBounds = true
        return view
    }()
    
    let profileLabel: UILabel = {
       let label = UILabel()
        label.textColor = Constants.BaseColor.black
        label.backgroundColor = .clear
        label.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        label.textAlignment = .left
        return label
    }()
    
    let rightArrow: UIImageView = {
       let view = UIImageView()
        view.image = UIImage(named: "more_arrow")
        return view
    }()
    
    override func configure() {
        [circleView, profileView, profileLabel, rightArrow].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        circleView.snp.makeConstraints { make in
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.12)
            make.height.equalTo(circleView.snp.width)
            make.leading.equalTo(safeAreaLayoutGuide).offset(20)
            make.centerY.equalTo(safeAreaLayoutGuide)
        }
        profileView.snp.makeConstraints { make in
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.12)
            make.height.equalTo(profileView.snp.width)
            make.leading.equalTo(circleView.snp.leading)
            make.centerY.equalTo(safeAreaLayoutGuide)
        }
        profileLabel.snp.makeConstraints { make in
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.7)
            make.height.equalTo(safeAreaLayoutGuide)
            make.leading.equalTo(profileView.snp.trailing).offset(8)
            make.centerY.equalTo(safeAreaLayoutGuide)
        }
        rightArrow.snp.makeConstraints { make in
            make.width.equalTo(profileView.snp.width).multipliedBy(0.5)
            make.height.equalTo(profileView.snp.height).multipliedBy(0.5)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-20)
            make.centerY.equalTo(safeAreaLayoutGuide)
        }
    }
}
