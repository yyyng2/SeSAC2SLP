//
//  SearchQueueView.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/18.
//

import UIKit

class SearchQueueView: BaseView {
//    let aroundLabel: UILabel = {
//       let label = UILabel()
//        label.text = "지금 주변에는"
//        label.font = UIFont(name: "NotoSansKR-Regular", size: 12)
//        return label
//    }()
    let collectionView: UICollectionView = {
        let layout = LeftAlignedCollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        return collectionView
    }()
//    let hopeLabel: UILabel = {
//       let label = UILabel()
//        label.text = "내가 하고 싶은"
//        label.font = UIFont(name: "NotoSansKR-Regular", size: 12)
//        return label
//    }()
//    let hopeCollectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.minimumLineSpacing = 10
//
//        layout.scrollDirection = .vertical
//        layout.sectionInset = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
//        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        return view
//    }()
    let searchButton: CustomSignButton = {
       let button = CustomSignButton()
        button.backgroundColor = Constants.brandColor.green
        button.setTitle("새싹 찾기", for: .normal)
        return button
    }()
    
    override func configure() {
        [collectionView, searchButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
//        aroundLabel.snp.makeConstraints { make in
//            make.top.equalTo(safeAreaLayoutGuide).offset(12)
//            make.leading.equalTo(safeAreaLayoutGuide).offset(12)
//        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(32)
            make.leading.trailing.bottom.equalToSuperview()
        }
//        hopeLabel.snp.makeConstraints { make in
//            make.top.equalTo(aroundCollectionView.snp.bottom).offset(12)
//            make.leading.equalTo(aroundLabel.snp.leading)
//        }
//        hopeCollectionView.snp.makeConstraints { make in
//            make.top.equalTo(hopeLabel.snp.bottom).offset(12)
//            make.leading.equalTo(aroundLabel.snp.leading)
//        }
        searchButton.snp.makeConstraints { make in
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.9)
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.07)
            make.centerY.equalTo(safeAreaLayoutGuide).multipliedBy(1.5)
            
        }
    }

  
}

class LeftAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)
        
        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0
        
        attributes?.forEach { layoutAttribute in
            if layoutAttribute.representedElementCategory == .cell {
                if layoutAttribute.frame.origin.y >= maxY {
                    leftMargin = sectionInset.left
                }
                
                layoutAttribute.frame.origin.x = leftMargin
                leftMargin += layoutAttribute.frame.width + minimumInteritemSpacing
                maxY = max(layoutAttribute.frame.maxY, maxY)
            }
        }
        return attributes
    }
}
