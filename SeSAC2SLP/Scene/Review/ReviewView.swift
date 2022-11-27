//
//  ReviewView.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/27.
//

import UIKit

class ReviewView: BaseView {
    let tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        return view
    }()
    
    override func configure() {
        self.addSubview(tableView)
    }
    
    override func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.leading.top.trailing.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
}
