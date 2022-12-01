//
//  PersonChatTableViewCell.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/12/01.
//

import UIKit

class PersonChatTableViewCell: UITableViewCell {
    
    let chatView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.borderColor = Constants.grayScale.gray4!.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 8
        return view
    }()
    let timeLabel: CustomChatTimeLabel = {
        let label = CustomChatTimeLabel()
        label.text = "00:00"
        return label
    }()
    let chatLabel: CustomChatMessageLabel = {
        let label = CustomChatMessageLabel()
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
        [chatView, timeLabel].forEach {
            contentView.addSubview($0)
        }
        chatView.addSubview(chatLabel)
    }
    
    func setConstraints() {
        chatView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.trailing.lessThanOrEqualToSuperview().inset(95)
            make.top.bottom.equalToSuperview().inset(12)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.leading.equalTo(chatView.snp.trailing).offset(8)
            make.bottom.equalTo(chatView.snp.bottom)
            make.height.equalTo(18)
        }
        
        chatLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview().inset(10)
        }
    }
}
