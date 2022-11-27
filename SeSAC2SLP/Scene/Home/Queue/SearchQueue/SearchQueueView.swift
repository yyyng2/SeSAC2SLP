//
//  SearchQueueView.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/18.
//

import UIKit

class SearchQueueView: BaseView {
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        scrollView.alwaysBounceVertical = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    let collectionView: UICollectionView = {
        let layout = LeftAlignedCollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        return collectionView
    }()

    let searchButton: CustomSignButton = {
       let button = CustomSignButton()
        button.backgroundColor = Constants.brandColor.green
        button.setTitle("새싹 찾기", for: .normal)
        return button
    }()
    
    let contentStackView: UIStackView = {
       let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .fill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func configure() {
        self.addSubview(scrollView)
        
        [collectionView, searchButton].forEach {
            contentStackView.addArrangedSubview($0)
        }
        
        scrollView.addSubview(contentStackView)
    }
    
    override func setConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }

        collectionView.snp.makeConstraints { make in
            make.top.equalTo(contentStackView.snp.top).offset(12)
            make.width.equalTo(UIScreen.main.bounds.width)
            make.leading.equalTo(contentStackView.snp.leading)
            make.trailing.equalTo(contentStackView.snp.trailing)
            make.height.equalTo(contentStackView.snp.width).multipliedBy(1.5)
        }

        searchButton.snp.makeConstraints { make in
            make.centerX.equalTo(contentStackView)
            make.top.equalTo(collectionView.snp.bottom).offset(12)
            make.leading.equalTo(contentStackView.snp.leading).offset(12)
            make.trailing.equalTo(contentStackView.snp.trailing).offset(-12)
            make.height.equalTo(contentStackView.snp.width).multipliedBy(0.15)
        }
        
        contentStackView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
        }
    }

  
}
