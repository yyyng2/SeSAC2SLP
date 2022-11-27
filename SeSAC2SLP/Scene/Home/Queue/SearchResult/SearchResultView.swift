//
//  SearchResultView.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/18.
//

import UIKit

class SearchResultView: BaseView {
    let noneSesacView = NoneSesacView()
    
    let tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.sectionFooterHeight = 0
        return view
    }()
    
    override func configure() {
        [noneSesacView, tableView].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        noneSesacView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        tableView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
}
