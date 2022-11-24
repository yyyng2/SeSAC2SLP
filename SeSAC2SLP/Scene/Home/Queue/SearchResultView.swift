//
//  SearchResultView.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/18.
//

import UIKit

class SearchResultView: BaseView {
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

    let studyChangeButton: CustomSignButton = {
       let button = CustomSignButton()
        button.backgroundColor = Constants.brandColor.green
        button.setTitle("스터디 변경하기", for: .normal)
        button.tag = 0
        return button
    }()
    
    let refreshButton: UIButton = {
        let button = UIButton()
            button.layer.cornerRadius = 10
        button.layer.borderColor = Constants.brandColor.green!.cgColor
        button.layer.borderWidth = 1
        button.tintColor = Constants.brandColor.green
        button.setImage(UIImage(systemName: "arrow.clockwise"), for: .normal)
        button.tag = 2
        return button
    }()
    
    let buttonStackView: UIStackView = {
       let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fill
        view.alignment = .fill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        
        [studyChangeButton, refreshButton].forEach {
            buttonStackView.addArrangedSubview($0)
        }
        
        [collectionView, buttonStackView].forEach {
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

        studyChangeButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(buttonStackView.snp.leading).offset(20)
            make.width.equalTo(buttonStackView.snp.width).multipliedBy(0.7)
//            make.trailing.equalTo(refreshButton.snp.leading).offset(12)
            make.height.equalTo(buttonStackView.snp.height)
        }
        
        refreshButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
//            make.leading.equalTo(studyChangeButton.snp.trailing).offset(12)
            make.trailing.equalTo(contentStackView.snp.trailing).offset(-20)
            make.height.equalTo(buttonStackView.snp.height)
//            make.width.equalTo(buttonStackView.snp.width).multipliedBy(0.2)
            make.width.equalTo(buttonStackView.snp.height)
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.centerX.equalTo(contentStackView)
            make.top.equalTo(collectionView.snp.bottom).offset(12)
            make.width.equalTo(UIScreen.main.bounds.width)
            make.height.equalTo(contentStackView.snp.width).multipliedBy(0.15)
        }
        
        contentStackView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
        }
    }
}
