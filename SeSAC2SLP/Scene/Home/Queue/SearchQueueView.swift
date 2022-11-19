//
//  SearchQueueView.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/18.
//

import UIKit

class SearchQueueView: BaseView {
    let aroundLabel: UILabel = {
       let label = UILabel()
        label.text = "지금 주변에는"
        label.font = UIFont(name: "NotoSansKR-Regular", size: 12)
        return label
    }()
    let aroundCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return view
    }()
    let hopeLabel: UILabel = {
       let label = UILabel()
        label.text = "내가 하고 싶은"
        label.font = UIFont(name: "NotoSansKR-Regular", size: 12)
        return label
    }()
    let hopeCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return view
    }()
    let searchButton: CustomSignButton = {
       let button = CustomSignButton()
        button.backgroundColor = Constants.brandColor.green
        button.setTitle("새싹 찾기", for: .normal)
        return button
    }()
    
    override func configure() {
        [aroundLabel, aroundCollectionView, hopeLabel, hopeCollectionView, searchButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        aroundLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(12)
            make.leading.equalTo(safeAreaLayoutGuide).offset(12)
        }
        aroundCollectionView.snp.makeConstraints { make in
            make.top.equalTo(aroundLabel.snp.bottom).offset(12)
            make.leading.equalTo(aroundLabel.snp.leading)
        }
        hopeLabel.snp.makeConstraints { make in
            make.top.equalTo(aroundCollectionView.snp.bottom).offset(12)
            make.leading.equalTo(aroundLabel.snp.leading)
        }
        hopeCollectionView.snp.makeConstraints { make in
            make.top.equalTo(hopeLabel.snp.bottom).offset(12)
            make.leading.equalTo(aroundLabel.snp.leading)
        }
        searchButton.snp.makeConstraints { make in
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.9)
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.07)
            make.centerY.equalTo(safeAreaLayoutGuide).multipliedBy(1.5)
            
        }
    }
}
