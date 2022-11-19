//
//  SearchQueueCollectionViewCell.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/18.
//

import UIKit

class SearchQueueCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: SearchQueueCollectionViewCell.self)
    
    let titleLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "NotoSansKR-Regular", size: 14)
        return label
    }()
    
    let removeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = Constants.brandColor.green
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let stack = UIStackView(arrangedSubviews: [titleLabel, removeButton])
        stack.axis = .horizontal
        stack.spacing = 6.75
        
        addSubview(stack)
        stack.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
