//
//  QueueResultTableViewHeaderCell.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/27.
//

import UIKit

class QueueResultTableViewHeaderCell: UITableViewHeaderFooterView {
    static let identifier = String(describing: QueueResultTableViewHeaderCell.self)
    
    let backgroundImageView: UIImageView = {
       let view = UIImageView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    
    let reactButton: UIButton = {
       let button = UIButton()
        button.setTitle("요청하기", for: .normal)
        button.backgroundColor = Constants.systemColor.error
        button.layer.cornerRadius = 8
        return button
    }()
    
    let profileImageView: UIImageView = {
        let view = UIImageView()
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
    let arrowImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "chevron.down")
        view.tintColor = Constants.grayScale.gray7
        return view
    }()
    var expandButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        return button
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
        [backgroundImageView, reactButton, profileImageView, expandButton, profileLabel, arrowImage].forEach {
            contentView.addSubview($0)
        }
    }
    
    func setConstraints() {
        backgroundImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(12)
            make.width.equalTo(contentView.snp.width).multipliedBy(0.9)
            make.height.equalTo(backgroundImageView.snp.width).multipliedBy(0.65)
            make.centerX.equalTo(contentView)
        }
        reactButton.snp.makeConstraints { make in
            make.top.equalTo(backgroundImageView.snp.top).offset(8)
            make.trailing.equalTo(backgroundImageView.snp.trailing).offset(-8)
            make.width.equalTo(backgroundImageView.snp.width).multipliedBy(0.25)
            make.height.equalTo(backgroundImageView.snp.height).multipliedBy(0.2)
        }
        profileImageView.snp.makeConstraints { make in
            make.bottom.equalTo(backgroundImageView.snp.bottom).multipliedBy(1)
            make.centerX.equalTo(contentView)
            make.width.equalTo(backgroundImageView.snp.width).multipliedBy(0.6)
            make.height.equalTo(backgroundImageView.snp.height).multipliedBy(0.85)
        }
        profileLabel.snp.makeConstraints { make in
            make.top.equalTo(expandButton.snp.top).offset(12)
            make.centerX.equalTo(contentView)
            make.width.equalTo(contentView).multipliedBy(0.8)
            make.height.equalTo(contentView).multipliedBy(0.1)
        }
        arrowImage.snp.makeConstraints { make in
            make.centerY.equalTo(profileLabel.snp.centerY)
            make.width.equalTo(profileLabel.snp.width).multipliedBy(0.05)
            make.height.equalTo(arrowImage.snp.width)
            make.trailing.equalTo(profileLabel.snp.trailing)
        }
        expandButton.snp.makeConstraints { make in
            make.top.equalTo(backgroundImageView.snp.bottom)
            make.width.equalTo(contentView)
            make.height.equalTo(contentView).multipliedBy(0.1)
        }
    }
}
