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
    
    let viewModel = SearchQueueViewModel()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        print("studylist:",User.studylistFromDB)
        print("recommend:",User.fromRecommend, User.fromRecommend.count)
        print("AllStudy:",User.allStudyList)
        print("results:",results)
        
        setFirstLoad()
            
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
    
    override func bind() {
        viewModel.result?.bind { value in
            self.viewModel.setRecommend(result: value, collectionView: self.mainView.collectionView)
        }
    }
    
    func setFirstLoad() {
        APIService().requestSearchQueue(lat: User.currentLat, long: User.currentLong) { result, code in
            print("Queue:",result)

            switch code {
            case 200:
                guard let result = result else { return }
                self.results = self.viewModel.setRecommend(result: result, collectionView: self.mainView.collectionView)
            case 401:
                AuthenticationManager.shared.updateIdToken()
                APIService().requestSearchQueue(lat: User.currentLat, long: User.currentLong) { response, code in
                    switch code {
                    case 200:
                        guard let result = response else { return }
                        self.results = self.viewModel.setRecommend(result: result, collectionView: self.mainView.collectionView)
                    default:
                        print("requestSearchQueue:Error", code)
                    }
                }
                
            default:
                break
            }
        }
    }
  
  
    
    @objc func searchButtonTapped() {
        var list = [""]
        if User.studylist == [""] {
            list = ["anything"]
        } else {
            list = User.studylist
        }
        APIService().requestQueue(lat: User.currentLat, long: User.currentLong, studylist: list) { code in
            if code == 200 {
                User.matched = 0
                let vc = SearchResultViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            } else if code == 401 {
                AuthenticationManager.shared.updateIdToken()
                APIService().requestQueue(lat: User.currentLat, long: User.currentLong, studylist: list) { code in
                    if code == 200 {
                        User.matched = 0
                        let vc = SearchResultViewController()
                        self.navigationController?.pushViewController(vc, animated: true)
                    } else {
                        print("requestQueueError",code)
                    }
                }
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
//
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
    
    // headerView 크기
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 34)
    }
    
    // cell 크기
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
