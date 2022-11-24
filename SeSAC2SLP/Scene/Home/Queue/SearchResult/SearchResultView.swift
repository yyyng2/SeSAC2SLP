//
//  SearchResultView.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/18.
//

import UIKit

class SearchResultView: BaseView {
    let noneSesacView = NoneSesacView()

    let collectionView: UICollectionView = {
        let layout = LeftAlignedCollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        return collectionView
    }()
    
   
    
  
    
    override func configure() {
        [noneSesacView, collectionView].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
