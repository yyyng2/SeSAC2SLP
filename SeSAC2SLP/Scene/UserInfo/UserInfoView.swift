//
//  UserInfoView.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/14.
//

import UIKit

class UserInfoView: BaseView {
    let tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.register(UserInfoTableViewCell.self, forCellReuseIdentifier: UserInfoTableViewCell.id)
        view.register(UserMenuTableViewCell.self, forCellReuseIdentifier: UserMenuTableViewCell.id)
        return view
    }()
    
    override func configure() {
        self.addSubview(tableView)
    }
    
    override func setConstraints() {
        
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
}
