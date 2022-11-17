//
//  SearchQueueCollectionViewCell.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/18.
//

import UIKit

class SearchQueueCollectionViewCell: UICollectionViewCell {
    
    let titleLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "NotoSansKR-Regular", size: 14)
        return label
    }()
    
    func configure() {
        contentView.addSubview(titleLabel)
        contentView.layer.cornerRadius = 8
    }
}
