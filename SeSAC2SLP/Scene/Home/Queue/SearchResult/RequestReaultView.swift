//
//  RequestReaultView.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/25.
//

import UIKit

class RequestReaultView: BaseView {
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
        noneSesacView.noneSesacFirstLabel.text = "아직 받은 요청이 없어요ㅠ"
    }
    
    override func setConstraints() {
        noneSesacView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

