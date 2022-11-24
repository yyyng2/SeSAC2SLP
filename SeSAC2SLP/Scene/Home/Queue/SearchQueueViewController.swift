//
//  SearchQueueViewController.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/18.
//

import UIKit

class SearchQueueViewController: BaseViewController {
    let mainView = SearchQueueView()
    
    var userStudyList = User.studylist
    
    var queueStudyList = CObservable(User.studylistFromDB)
    
    var recommendLists = ["":[""]]
    
    var userRecommend = User.studylistFromDB
    
    var recommend = User.fromRecommend
    
    var results = [Study]()
    
    let viewModel = SearchQueueViewModel()
    
    var queueState = 0
    
    let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width - 28, height: 0))
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.isTranslucent = true
        
        switch queueState {
        case 0:
            break
        case 1:
            searchButtonTapped()
        case 2:
            navigationController?.popViewController(animated: true)
        default:
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        print("studylist:",User.studylistFromDB)
        print("recommend:",User.fromRecommend, User.fromRecommend.count)
        print("AllStudy:",User.allStudyList)
        print("results:",results)
        
        setFirstLoad()
        
        setBackButton()
            
        setCollectionView()
        setToolBarInTextField()
    }
    
    override func configure() {
        super.configure()
        

        
        mainView.scrollView.delegate = self
        
        navigationController?.navigationBar.isHidden = false
       
        searchBar.placeholder = "띄어쓰기로 복수 입력이 가능해요"
        searchBar.delegate = self
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: searchBar)
        
        mainView.searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
    }
    
    func setCollectionView() {
        mainView.collectionView.dataSource = self
        mainView.collectionView.delegate = self
        mainView.collectionView.register(SearchQueueCollectionViewCell.self, forCellWithReuseIdentifier: SearchQueueCollectionViewCell.identifier)
        mainView.collectionView.register(SearchQueueCollectionViewHeaderCell.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                         withReuseIdentifier: SearchQueueCollectionViewHeaderCell.identifier)
    }
    
    func setToolBarInTextField() {
//        let toolbar = UIToolbar()
//        toolbar.sizeToFit()
//        toolbar.backgroundColor = Constants.brandColor.green
//        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(searchButtonTapped))
//        toolbar.setItems([doneButton], animated: false)
        
        let searchButtonInKeyboard: CustomSignButton = {
            let button = CustomSignButton()
            button.backgroundColor = Constants.brandColor.green
            button.layer.cornerRadius = 0
            button.setTitle("새싹 찾기", for: .normal)
            return button
         }()
        searchButtonInKeyboard.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        searchButtonInKeyboard.sizeToFit()
         
        searchBar.searchTextField.inputAccessoryView = searchButtonInKeyboard
        searchBar.searchTextField.returnKeyType = .send

    }

    func setBackButton() {
//        self.navigationController?.navigationBar.tintColor = Constants.BaseColor.black
////        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "arrow")
////        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "arrow")
//        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "star")
//        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "star")
//
//        let backBarButtonItem = UIBarButtonItem(title: "test", style: .plain, target: self, action: #selector(backTapped))
//        self.navigationItem.backBarButtonItem = backBarButtonItem
    }
    
    @objc func backTapped() {
        navigationController?.popToViewController((self.navigationController?.viewControllers[0])!,
                                                   animated: true)
    }

    
    @objc override func backButtonTapped() {
//            navigationController?.popToRootViewController(animated: true)
//        navigationController?.viewControllers
        navigationController?.popToViewController((self.navigationController?.viewControllers[0])!,
                                                   animated: true)
       
    }
    override func bind() {
        
//        viewModel.result?.bind { value in
//            self.viewModel.setRecommend(result: value, collectionView: self.mainView.collectionView)
//        }
        
    }
    
    func setFirstLoad() {
        APIService().requestSearchQueue(lat: User.currentLat, long: User.currentLong) { result, code in
            print("Queue:",result)

            switch code {
            case 200:
                guard let result = result else { return }
                self.results = self.viewModel.setRecommend(result: result, collectionView: self.mainView.collectionView)
                print("results:",self.results)
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
  
    func checkPattern(study: String) -> Bool {
     
        let pattern = "^[가-힣A-Za-z0-9]{1,8}$"
        let result = NSPredicate(format:"SELF MATCHES %@", pattern)
        
        return result.evaluate(with: study)
      
    }
    
    func checkUserStudyCount(string: String) {
        if viewModel.userStudyList.value.count < 8 {
            if viewModel.userStudyList.value.contains(string) == false {
                viewModel.userStudyList.value.append(string)
                viewModel.userStudyList.value.removeAll(where: { $0 == "" })
                results.removeAll(where: { $0.name == string } )
                mainView.collectionView.reloadData()                
            } else {
                mainView.makeToast("이미 존재하는 스터디입니다", duration: 1.5, position: .center)
            }
        } else {
            mainView.makeToast("스터디를 더 이상 추가할 수 없습니다", duration: 1.5, position: .center)
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
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.searchTextField.text else { return }
        let whiteSpaceCount = text.filter { ($0) == " " }.count
        let array = text.split(maxSplits: whiteSpaceCount, omittingEmptySubsequences: false, whereSeparator: {$0 == " "})
        print(array)
        for i in array {
            let result = checkPattern(study: String(i))
            switch result {
            case true:
               checkUserStudyCount(string: String(i))
            case false:
                mainView.makeToast("최소 한 자 이상, 최대 8글자까지 작성 가능합니다", duration: 1.5, position: .center)
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
            
            if viewModel.userStudyList.value == [""] {
                result = 0
            } else {
                result = viewModel.userStudyList.value.count
            }
            return result
        default:
            break
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchQueueCollectionViewCell.identifier, for: indexPath) as? SearchQueueCollectionViewCell else { return UICollectionViewCell() }
        
     
          
        switch indexPath.section {
        case 0:
            let item = results[indexPath.row]
            
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
        case 1:
            if viewModel.userStudyList.value == [""] {
                
            } else {
                cell.titleLabel.textColor = Constants.brandColor.green
                cell.layer.borderColor = Constants.brandColor.green?.cgColor
                cell.layer.borderWidth = 1
                cell.layer.cornerRadius = 8
                cell.titleLabel.text = viewModel.userStudyList.value[indexPath.row]
                cell.removeButton.isHidden = false
            }
        default:
            break
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
       
        
        switch indexPath.section {
        case 0:
            let item = results[indexPath.row]
            
            let result = checkPattern(study: item.name)
            switch result {
            case true:
               checkUserStudyCount(string: item.name)
            case false:
                mainView.makeToast("최소 한 자 이상, 최대 8글자까지 작성 가능합니다", duration: 1.5, position: .center)
            }
        case 1:
            viewModel.userStudyList.value.remove(at: indexPath.row)
            mainView.collectionView.reloadData()
        default:
           break
        }
    }
    
    
}

extension SearchQueueViewController: UICollectionViewDelegateFlowLayout {
    
    // 섹션 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: 0, bottom: 24, right: 0)
    }
    
    // 헤더 크기
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 34)
    }
    
    // 셀 크기
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel(frame: CGRect.zero)
        
        switch indexPath.section {
        case 0:
            label.text = results[indexPath.row].name
        case 1:
            label.text = viewModel.userStudyList.value[indexPath.row]
        default:
           break
        }
        label.sizeToFit()
        return CGSize(width: label.frame.width + 30, height: 32)
    }
}

extension SearchQueueViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchBar.searchTextField.resignFirstResponder()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        searchBar.searchTextField.endEditing(true)
    }
}
