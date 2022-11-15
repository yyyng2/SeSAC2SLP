//
//  BaseTableViewCell.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/15.
//

import UIKit

import SnapKit

class BaseTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
    
    }
    
    func setConstraints() {
        
    }
}
