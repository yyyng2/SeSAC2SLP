//
//  MyChatTableViewCell.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/30.
//

import UIKit

class MyChatTableViewCell: UITableViewCell {
    
    let chatView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.brandColor.whiteGreen
        view.layer.cornerRadius = 8
        return view
    }()
    let timeLabel: CustomChatTimeLabel = {
        let label = CustomChatTimeLabel()
        label.text = "00:00"
        return label
    }()
    let chatLabel: CustomMyChatMessageLabel = {
        let label = CustomMyChatMessageLabel()
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
            make.trailing.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview().inset(12)
            make.leading.greaterThanOrEqualToSuperview().inset(95)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.trailing.equalTo(chatView.snp.leading).offset(-8)
            make.bottom.equalTo(chatView.snp.bottom)
            make.height.equalTo(18)
        }
        
        chatLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview().inset(10)
        }
    }
}
