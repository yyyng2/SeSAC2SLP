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
    
    var queueStudyList = CObservable(User.studylistFromDB)
    
    var recommendLists = ["":[""]]
    
    var userRecommend = User.studylistFromDB
    
    var recommend = User.fromRecommend
    
    var results = [Study]()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        print("studylist:",User.studylistFromDB)
        print("recommend:",User.fromRecommend, User.fromRecommend.count)
        print("AllStudy:",User.allStudyList)
        print("results:",results)
        
        APIService().requestSearchQueue(lat: User.currentLat, long: User.currentLong) { result, code in
            print("Queue:",result)
            print("code:",code)
            
            let recommend = result?.fromRecommend.map { Study(name: $0, type: .recommend) } ?? []
            var studyListFromDB = result?.fromQueueDB.map{ $0.studylist }.flatMap { $0 }.map { Study(name: $0, type: .fromStudyListDB) } ?? []
            
      
            
            // 중복 제거
            recommend.forEach { recommendValue in
                studyListFromDB.forEach { studyListFromDBValue in
                    if recommendValue.name == studyListFromDBValue.name {
                        studyListFromDB.removeAll(where: {$0.name == studyListFromDBValue.name})
                    }
                }
            }
            
            var removedArray = [Study]()
            for i in studyListFromDB {
                if removedArray.contains(i) == false {
                    removedArray.append(i)
                }
            }
     
            
            
            self.results = recommend + removedArray
            self.results.removeAll(where: { $0.name == "anything" })
            self.results.removeAll(where: { $0.name == "" })
            print("HomeViewAPI:", recommend, studyListFromDB, self.results)
            self.mainView.collectionView.reloadData()
        }
      
    }
    
    override func configure() {
        super.configure()
        navigationController?.navigationBar.isHidden = false
        let bounds = UIScreen.main.bounds
        let width = bounds.size.width //화면 너비
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: width - 28, height: 0))
        searchBar.placeholder = "띄어쓰기로 복수 입력이 가능해요"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: searchBar)
        
        mainView.collectionView.dataSource = self
        mainView.collectionView.delegate = self
        mainView.collectionView.register(SearchQueueCollectionViewCell.self, forCellWithReuseIdentifier: SearchQueueCollectionViewCell.identifier)
        mainView.collectionView.register(SearchQueueCollectionViewHeaderCell.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                         withReuseIdentifier: SearchQueueCollectionViewHeaderCell.identifier)
        
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
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SearchQueueCollectionViewHeaderCell.identifier, for: indexPath) as? SearchQueueCollectionViewHeaderCell else { return UICollectionViewCell() }
        switch indexPath.section {
        case 0:
            header.label.text = "지금 주변에는"
        case 1:
            header.label.text = "내가 하고 싶은"
        default:
            break
        }
        return header
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            let result = results.count
            return result
        case 1:
            var result = 0
            if User.studylist == [""] {
                result = 0
            } else {
                result = User.studylist.count
            }
            return result
        default:
            break
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchQueueCollectionViewCell.identifier, for: indexPath) as? SearchQueueCollectionViewCell else { return UICollectionViewCell() }
        
        let item = results[indexPath.row]
        
        switch indexPath.section {
        case 0:
            switch item.type {
            case .recommend:
                cell.titleLabel.textColor = Constants.systemColor.error
                cell.layer.borderColor = Constants.systemColor.error?.cgColor
                cell.layer.borderWidth = 1
                cell.layer.cornerRadius = 8
                cell.removeButton.isHidden = true
                cell.titleLabel.text = item.name
            case .fromStudyListDB:
                cell.titleLabel.textColor = Constants.BaseColor.black
                cell.layer.borderColor = Constants.grayScale.gray4?.cgColor
                cell.layer.borderWidth = 1
                cell.layer.cornerRadius = 8
                cell.removeButton.isHidden = true
                cell.titleLabel.text = item.name
            }
//            cell.titleLabel.textColor = Constants.systemColor.error
//            cell.layer.borderColor = Constants.systemColor.error?.cgColor
//            cell.layer.borderWidth = 1
//            cell.layer.cornerRadius = 8
//            cell.removeButton.isHidden = true
//            guard let result = User.allStudyList["fromRecommend"] else { return cell }
//            cell.titleLabel.text = result[indexPath.row]
//            for (key, value) in User.allStudyList {
//                switch key {
//                case "fromRecommend":
//                    cell.titleLabel.textColor = Constants.systemColor.error
//                    cell.layer.borderColor = Constants.systemColor.error?.cgColor
//                    cell.layer.borderWidth = 1
//                    cell.layer.cornerRadius = 8
//                    cell.removeButton.isHidden = true
//                    guard let result = User.allStudyList["fromRecommend"] else { return cell }
//                    cell.titleLabel.text = value[indexPath.row]
//                case "studylistFromDB":
//                    if User.allStudyList["studylistFromDB"] == [] {
//
//                    } else {
//                        cell.titleLabel.textColor = Constants.BaseColor.black
//                        cell.layer.borderColor = Constants.grayScale.gray4?.cgColor
//                        cell.layer.borderWidth = 1
//                        cell.layer.cornerRadius = 8
//                        cell.removeButton.isHidden = true
//                        guard let result = User.allStudyList["studylistFromDB"] else { return cell }
//                        cell.titleLabel.text = value[indexPath.row]
//                    }
//                default:
//                    break
//                }
//            }
        default:
            if User.studylist == [""] {
                
            } else {
                cell.titleLabel.textColor = Constants.brandColor.green
                cell.layer.borderColor = Constants.brandColor.green?.cgColor
                cell.layer.borderWidth = 1
                cell.layer.cornerRadius = 8
                cell.titleLabel.text = User.studylist[indexPath.row]
                cell.removeButton.isHidden = false
            }
        }
        
        return cell
    }
    
    
}

extension SearchQueueViewController: UICollectionViewDelegateFlowLayout {
    
    // 섹션 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: 0, bottom: 24, right: 0)
    }
    
    // Header View 크기
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 34)
    }
    
    // Cell 크기
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel(frame: CGRect.zero)
        
        switch indexPath.section {
        case 0:
            label.text = results[indexPath.row].name
        default:
            label.text = User.studylist[indexPath.row]
        }
        label.sizeToFit()
        return CGSize(width: label.frame.width + 50, height: 32)
    }
}
