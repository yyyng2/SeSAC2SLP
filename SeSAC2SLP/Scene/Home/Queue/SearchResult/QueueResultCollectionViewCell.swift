//
//  QueueResultCollectionViewCell.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/27.
//

import UIKit

class QueueResultCollectionViewCell: UICollectionViewCell {
    
    let titleLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "NotoSansKR-Regular", size: 12)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let stack = UIStackView(arrangedSubviews: [titleLabel])
        stack.axis = .horizontal
        stack.spacing = 0
        
        addSubview(stack)
        stack.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
