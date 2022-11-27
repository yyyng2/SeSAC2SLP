//
//  SearchResultViewController.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/18.
//

import UIKit

class SearchResultViewController: BaseViewController {
    let mainView = SearchResultView()
    
    var fromQueueDB: [FromQueueDB] = []
    
    var fromQueueDBRequested: [FromQueueDB] = []
    
    let viewModel = SearchResultViewModel()
    
    var hiddenSections = Set<Int>()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.isTranslucent = true
       
        networkMoniter()
        APIService().requestSearchQueue(lat: User.currentLat, long: User.currentLong) { result, code in
            guard let results = result else { return }
            self.viewModel.fromQueueDB?.value = results.fromQueueDB
            self.fromQueueDB = results.fromQueueDB
            self.viewModel.fromQueueDBRequested?.value = results.fromQueueDBRequested
            for i in 0 ... self.fromQueueDB.count {
                self.hiddenSections.insert(i)
            }
            print("count & hidden",self.viewModel.fromQueueDB?.value.count, self.hiddenSections)
            DispatchQueue.main.async {
                if self.viewModel.fromQueueDB?.value.count == 0 {
                    self.mainView.tableView.isHidden = true
                    self.mainView.noneSesacView.isHidden = false
                } else {
                    self.mainView.tableView.isHidden = false
                    self.mainView.noneSesacView.isHidden = true
                    self.mainView.tableView.reloadData()
                }
            }
        }


    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        print("sesacResultView:\(fromQueueDB.count)")
    }
    
    override func configure() {
      
    }
    
    func configureTableView() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.register(QueueResultTableViewHeaderCell.self, forHeaderFooterViewReuseIdentifier: QueueResultTableViewHeaderCell.identifier)
        mainView.tableView.register(QueueResultTableViewCell.self, forCellReuseIdentifier: QueueResultTableViewCell.identifier)

    }
    
  

    
}

extension SearchResultViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return fromQueueDB.count
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: QueueResultTableViewHeaderCell.identifier) as? QueueResultTableViewHeaderCell else { return UIView() }

        header.profileImageView.image = UIImage(named: (SesacCode(rawValue: (fromQueueDB[section].sesac))?.sesacImageName)!)
        header.backgroundImageView.image = UIImage(named: (BackgroundCode(rawValue: (fromQueueDB[section].background))?.backgroundImageName)!)
        header.profileLabel.text = fromQueueDB[section].nick
        
        header.expandButton.tag = section
        header.expandButton.addTarget(self, action: #selector(hideSection(sender:)), for: .touchUpInside)
        header.reactButton.tag = section
        header.reactButton.addTarget(self, action: #selector(studyRequest(sender:)), for: .touchUpInside)
 
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 300
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.hiddenSections.contains(section) {
               return 0
           }
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.hiddenSections.contains(indexPath.section) {
               return 0
           }
        
        return 550
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: QueueResultTableViewCell.identifier, for: indexPath) as? QueueResultTableViewCell else { return UITableViewCell() }

        setCellLabel(label: cell.mannerTitleLabel, index: indexPath, indexNum: 0)
        setCellLabel(label: cell.timeTitleLabel, index: indexPath, indexNum: 1)
        setCellLabel(label: cell.responseTitleLabel, index: indexPath, indexNum: 2)
        setCellLabel(label: cell.niceTitleLabel, index: indexPath, indexNum: 3)
        setCellLabel(label: cell.handyTitleLabel, index: indexPath, indexNum: 4)
        setCellLabel(label: cell.beneficialTitleLabel, index: indexPath, indexNum: 5)
      
        
        if fromQueueDB[indexPath.section].reviews.count < 1 {
            cell.sesacReviewButton.alpha = 0
            cell.sesacReviewButton.isEnabled = false
            cell.sesacReviewTextView.text = "첫 리뷰를 기다리는 중이에요!"
            cell.sesacReviewTextView.textColor = Constants.grayScale.gray6
            DispatchQueue.main.async {
                cell.sesacReviewTextView.snp.removeConstraints()
                cell.sesacReviewTextView.snp.makeConstraints { make in
                    make.top.equalTo(cell.sesacReviewLabel.snp.bottom)
                    make.width.equalTo(cell.contentView.snp.width).multipliedBy(0.85)
                    make.centerX.equalTo(cell.contentView)
                }
            }
        } else {
            cell.sesacReviewButton.isHidden = false
            cell.sesacReviewButton.isEnabled = true
            cell.sesacReviewButton.tag = indexPath.section
            cell.sesacReviewButton.addTarget(self, action: #selector(transitionToRevies(sender:)), for: .touchUpInside)
            cell.sesacReviewTextView.text = fromQueueDB[indexPath.section].reviews[0]
            cell.sesacReviewTextView.textColor = Constants.BaseColor.black
        }
        
        
        return cell
    }
    
    func setCellLabel(label: UILabel, index: IndexPath, indexNum: Int) {
        label.textColor = sesacTitleColor(i: (fromQueueDB[index.section].reputation[indexNum])).textColor
        label.layer.borderColor = sesacTitleColor(i: (fromQueueDB[index.section].reputation[indexNum])).borderColor
        label.backgroundColor = sesacTitleColor(i: (fromQueueDB[index.section].reputation[indexNum])).backgroundColor
        label.layer.cornerRadius = 8
        label.clipsToBounds = true
    }
    
    @objc private func studyRequest(sender: UIButton) {
        let vc = PopUpViewController()
        vc.status = 0
        vc.otherUid = fromQueueDB[sender.tag].uid
        
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true)
        
    }
    
    @objc private func transitionToRevies(sender: UIButton) {
        let vc = ReviewViewController()
        vc.reviews = fromQueueDB[sender.tag].reviews
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func hideSection(sender: UIButton) {
        // section의 tag 정보를 가져와서 어느 섹션인지 구분한다.
        let section = sender.tag
        
        // 특정 섹션에 속한 행들의 IndexPath들을 리턴하는 메서드
        func indexPathsForSection() -> [IndexPath] {
        
            var indexPaths = [IndexPath]()
            
            indexPaths.append(IndexPath(row: 0, section: sender.tag))
            
            return indexPaths
        }

        // 가져온 section이 원래 감춰져 있었다면
        if self.hiddenSections.contains(section) {
            self.hiddenSections.remove(section)
            mainView.tableView.insertRows(at: indexPathsForSection(), with: .fade)
            // 섹션을 노출시킬때 원래 감춰져 있던 행들이 다 보일 수 있게 한다.
            mainView.tableView.scrollToRow(at: IndexPath(row: 0,
                            section: section), at: UITableView.ScrollPosition.bottom, animated: true)
        } else {
            self.hiddenSections.insert(section)
            mainView.tableView.deleteRows(at: indexPathsForSection(), with: .fade)
        }
    }
    
}
