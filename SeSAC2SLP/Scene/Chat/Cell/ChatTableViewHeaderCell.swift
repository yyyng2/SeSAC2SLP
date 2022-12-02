//
//  ChatTableViewHeaderCell.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/12/02.
//

import UIKit

class ChatTableViewHeaderCell: UITableViewHeaderFooterView {
    
    let background: UIView = {
       let view = UIView()
        view.backgroundColor = Constants.grayScale.gray7
        view.layer.cornerRadius = 10
        return view
    }()
    
    let dateLabel: CustomChatTimeLabel = {
       let label = CustomChatTimeLabel()
        label.textColor = Constants.BaseColor.white
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configure()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
       
    
    func configure() {
        [background, dateLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    func setConstraints() {
        background.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.width.equalTo(contentView.snp.width).multipliedBy(0.26)
            make.bottom.equalTo(contentView.snp.bottom)
            make.centerX.equalTo(contentView)
        }
        dateLabel.snp.makeConstraints { make in
            make.width.equalTo(background.snp.width).multipliedBy(0.9)
            make.center.equalToSuperview()
        }

    }
}
