//
//  SearchQueueCollectionViewHeaderCell.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/22.
//

import UIKit

import SnapKit

class SearchQueueCollectionViewHeaderCell: UICollectionReusableView {

    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        label.font = UIFont(name: "NotoSansKR-Regular", size: 12)
        
        addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
