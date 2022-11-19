//
//  SearchQueueViewController.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/18.
//

import UIKit

class SearchQueueViewController: BaseViewController {
    let mainView = SearchQueueView()
    
    var studyList = User.studylist
    
    var recommendLists = ["":[""]]
    
    var userRecommend = User.studylistFromDB
    
    var recommend = User.fromRecommend
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        print("studylist:",User.studylistFromDB)
    }
    
    override func configure() {
        super.configure()
        navigationController?.navigationBar.isHidden = false
        let bounds = UIScreen.main.bounds
        let width = bounds.size.width //화면 너비
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: width - 28, height: 0))
        searchBar.placeholder = "띄어쓰기로 복수 입력이 가능해요"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: searchBar)
        
        mainView.aroundCollectionView.dataSource = self
        mainView.aroundCollectionView.delegate = self
        mainView.aroundCollectionView.register(SearchQueueCollectionViewCell.self, forCellWithReuseIdentifier: "SearchQueueCollectionViewCell")
        mainView.hopeCollectionView.register(SearchQueueCollectionViewCell.self, forCellWithReuseIdentifier: "hopeCollectionView")
        
        mainView.searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
    }
  
    func isRecommend() {
        recommendLists["recommend"] = recommend
        recommendLists["unrecommend"] = userRecommend
    }
    
    @objc func searchButtonTapped() {
        var list = [""]
        if User.studylist == [""] {
            list = ["anything"]
        } else {
            list = User.studylist
        }
        APIService().requestQueue(lat: User.currentLat, long: User.currentLong, studylist: list) { code in
            print("requestQueueLocation",User.currentLat, User.currentLong, list)
            print("requestQueue:",code)
            if code == 200 {
                User.matched = 0
                let vc = SearchResultViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
}

extension SearchQueueViewController: UISearchBarDelegate {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        let array = text.split(maxSplits: 1, omittingEmptySubsequences: false, whereSeparator: {$0 == " "})
        if array.count > 1 && array.count < 9 {
            for i in array {
                studyList.append("\(i)")
            }
            User.studylist = studyList
        } else if array.count > 9 {
            mainView.makeToast("8개까지 추가가 가능합니다.", duration: 1.5, position: .center)
        } else {
            if studyList.count > 8 {
                mainView.makeToast("8개까지 추가가 가능합니다.", duration: 1.5, position: .center)
            } else {
                studyList.append(text)
                User.studylist = studyList
            }
        }
    }
}

extension SearchQueueViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
       
       func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
           guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SearchQueueCollectionViewCell.identifier, for: indexPath) as? SearchQueueCollectionViewCell else { return UICollectionViewCell() }
           header.titleLabel.text = indexPath.section == 0 ? "지금 주변에는" : "내가 하고 싶은"
           return header
       }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width - 78) / 2, height: 32)
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? recommendLists.count : studyList.count
        }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = mainView.aroundCollectionView.dequeueReusableCell(withReuseIdentifier: "SearchQueueCollectionViewCell", for: indexPath) as? SearchQueueCollectionViewCell else { return UICollectionViewCell() }
        
        if indexPath.section == 0 {
            cell.titleLabel.textColor = Constants.systemColor.error
            cell.titleLabel.text = recommend[indexPath.row]
            cell.removeButton.isHidden = true
        } else {
            cell.titleLabel.textColor = Constants.brandColor.green
            cell.titleLabel.text = userRecommend[indexPath.row]
            cell.removeButton.isHidden = false
        }
        
        return cell
    }
    
    
}
