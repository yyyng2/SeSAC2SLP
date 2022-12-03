//
//  FirstChatTableViewCell.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/12/02.
//

import UIKit

class FirstChatTableViewCell: UITableViewCell {
    
    let topView: UIView = {
        let view = UIView()
        return view
    }()
    
    let bellImage: UIImageView = {
       let view = UIImageView()
        view.image = UIImage(named: "chatFirstBell")
        return view
    }()
    let topLabel: UILabel = {
        let label = UILabel()
        label.text = "000님과 매칭됐다구"
        label.textColor = Constants.grayScale.gray7
        label.font = UIFont(name: "NotoSansKR-Regular", size: 14)
        return label
    }()
    let bottomLabel: UILabel = {
        let label = UILabel()
        label.text = "채팅을 통해 약속을 정해보세요 :)"
        label.textColor = Constants.grayScale.gray6
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
        [topView, bottomLabel].forEach {
            contentView.addSubview($0)
        }
        
        [topLabel, bellImage].forEach {
            topView.addSubview($0)
        }
    }
    
    func setConstraints() {
        topView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(12)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(22)
        }
        
        bellImage.snp.makeConstraints {
            $0.trailing.equalTo(topLabel.snp.leading).offset(-4)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(16)
        }
        
        topLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview().offset(10)
            $0.top.bottom.equalToSuperview()
        }
        
        bottomLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(topView.snp.bottom).offset(2)
            $0.height.equalTo(22)
            $0.bottom.equalToSuperview().inset(12)
        }
    }
}
