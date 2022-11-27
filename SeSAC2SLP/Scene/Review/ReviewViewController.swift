//
//  ReviewViewController.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/27.
//

import UIKit

class ReviewViewController: BaseViewController {
    let mainView = ReviewView()
    
    var reviews: [String]?
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(reviews)
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.register(ReviewTableViewCell.self, forCellReuseIdentifier: ReviewTableViewCell.identifier)
    
    }
    
    override func setNavigationUI() {
        self.title = "새싹 리뷰"
        self.navigationController?.navigationBar.topItem?.title = ""
    }
}

extension ReviewViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReviewTableViewCell.identifier, for: indexPath) as? ReviewTableViewCell else { return UITableViewCell() }
        
        cell.textView.text = reviews?[indexPath.row]
        return cell
    }
    
    
}
