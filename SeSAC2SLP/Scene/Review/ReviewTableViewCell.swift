//
//  ReviewTableViewCell.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/27.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {
    
    let textView: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = Constants.BaseColor.black
        label.font = UIFont(name: "NotoSansKR-Regular", size: 14)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        contentView.addSubview(textView)
    }
    
    func setConstraints() {
        textView.snp.makeConstraints { make in
            make.centerY.equalTo(safeAreaLayoutGuide)
            make.leading.equalTo(safeAreaLayoutGuide).offset(8)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-8)
        }
    }
    
   
}
