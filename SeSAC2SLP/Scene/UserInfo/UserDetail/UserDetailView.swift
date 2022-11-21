//
//  UserDetailView.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/14.
//

import UIKit

import MultiSlider

class UserDetailView: BaseView {
    
    let topView = ExpandTopView(frame: .zero)
    let backgroundView = ExpandBackgroundView(frame: .zero)
    lazy var middleView = ExpandView(frame: .zero)
   
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        scrollView.alwaysBounceVertical = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    let contentStackView: UIStackView = {
       let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .fill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let stackView: UIStackView = {
       let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .fill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    /////////////////////////////// under part ////////////////////////////
   
    let underView = UserDetailUnderView()
    
    
    override func configure() {
        [scrollView].forEach {
            self.addSubview($0)
        }
        scrollView.addSubview(backgroundView)
        [topView, middleView, underView].forEach {
            contentStackView.addArrangedSubview($0)
        }
        scrollView.addSubview(contentStackView)
   
        
//        stackView.addArrangedSubview(middleView)
        
    }
    
    override func setConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
        topView.snp.makeConstraints { make in
            make.top.equalTo(contentStackView.snp.top).offset(12)
            make.width.equalTo(UIScreen.main.bounds.width)
            make.leading.equalTo(contentStackView.snp.leading)
            make.trailing.equalTo(contentStackView.snp.trailing)
            make.height.equalTo(contentStackView.snp.width).multipliedBy(0.6)
        }
        
        backgroundView.snp.makeConstraints { make in
            make.top.equalTo(topView.backgroundImageView.snp.bottom)
            make.width.equalTo(topView.backgroundImageView.snp.width)
            make.leading.equalTo(topView.backgroundImageView.snp.leading)
            make.height.equalTo(50)
        }
        backgroundView.layer.borderColor = Constants.grayScale.gray2!.cgColor
        backgroundView.layer.borderWidth = 1
        backgroundView.layer.cornerRadius = 8
        
        middleView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom)
            make.leading.equalTo(contentStackView.snp.leading)
            make.trailing.equalTo(contentStackView.snp.trailing)
            make.height.equalTo(0)
            make.bottom.equalTo(underView.snp.top)
        }
        
        underView.snp.makeConstraints { make in
            make.top.equalTo(middleView.snp.bottom).offset(12)
            make.leading.equalTo(contentStackView.snp.leading)
            make.trailing.equalTo(contentStackView.snp.trailing)
            make.width.equalTo(UIScreen.main.bounds.width)
            make.height.equalTo(contentStackView.snp.width).multipliedBy(0.9)
        }

        contentStackView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
//            make.edges.equalToSuperview()
        }

//        stackView.snp.makeConstraints { make in
//            make.edges.equalTo(safeAreaLayoutGuide)
//            make.height.equalTo(0)
//        }
        
//        backgroundImageView.snp.makeConstraints { make in
//            make.top.equalTo(contentStackView).offset(12)
//            make.width.equalTo(contentStackView).multipliedBy(0.9)
//            make.height.equalTo(contentStackView).multipliedBy(0.3)
//            make.centerX.equalTo(contentStackView)
//        }
//        profileImageView.snp.makeConstraints { make in
//            make.bottom.equalTo(backgroundImageView.snp.bottom).multipliedBy(1)
//            make.centerX.equalTo(contentStackView)
//            make.width.equalTo(backgroundImageView.snp.width).multipliedBy(0.6)
//            make.height.equalTo(backgroundImageView.snp.height).multipliedBy(0.85)
//        }
//        profileLabel.snp.makeConstraints { make in
//            make.top.equalTo(expandButton.snp.top)
//            make.centerX.equalTo(contentStackView)
//            make.width.equalTo(contentStackView).multipliedBy(0.8)
//            make.height.equalTo(contentStackView).multipliedBy(0.1)
//        }
//        arrowImage.snp.makeConstraints { make in
//            make.centerY.equalTo(profileLabel.snp.centerY)
//            make.width.equalTo(profileLabel.snp.width).multipliedBy(0.05)
//            make.height.equalTo(arrowImage.snp.width)
//            make.trailing.equalTo(profileLabel.snp.trailing)
//        }
//        expandButton.snp.makeConstraints { make in
//            make.top.equalTo(backgroundImageView.snp.bottom).offset(20)
//            make.width.equalTo(contentStackView)
//            make.height.equalTo(contentStackView).multipliedBy(0.1)
//        }
//        secondView.snp.makeConstraints { make in
//            make.top.equalTo(expandButton.snp.bottom)
//            make.width.equalTo(contentStackView)
//            make.height.equalTo(0)
//        }
//        genderLabel.snp.makeConstraints { make in
//            make.top.equalTo(secondView.snp.bottom).offset(20)
//            make.width.equalTo(contentStackView).multipliedBy(0.5)
//            make.height.equalTo(contentStackView).multipliedBy(0.05)
//        }
//        favoriteStudyLabel.snp.makeConstraints { make in
//            make.top.equalTo(genderLabel.snp.bottom).offset(20)
//            make.width.equalTo(contentStackView).multipliedBy(0.5)
//            make.height.equalTo(contentStackView).multipliedBy(0.05)
//        }
//        numberPublicStatusLabel.snp.makeConstraints { make in
//            make.top.equalTo(favoriteStudyLabel.snp.bottom).offset(20)
//            make.width.equalTo(contentStackView).multipliedBy(0.5)
//            make.height.equalTo(contentStackView).multipliedBy(0.05)
//        }
//        favoriteAgeLabel.snp.makeConstraints { make in
//            make.top.equalTo(numberPublicStatusLabel.snp.bottom).offset(20)
//            make.width.equalTo(contentStackView).multipliedBy(0.5)
//            make.height.equalTo(contentStackView).multipliedBy(0.05)
//        }
//        ageLabel.snp.makeConstraints { make in
//            make.top.equalTo(numberPublicStatusLabel.snp.bottom).offset(20)
//            make.width.equalTo(contentStackView).multipliedBy(0.5)
//            make.trailing.equalTo(contentStackView)
//            make.height.equalTo(contentStackView).multipliedBy(0.05)
//        }
//        slider.snp.makeConstraints { make in
//            make.top.equalTo(favoriteAgeLabel.snp.bottom).offset(20)
//            make.width.equalTo(contentStackView).multipliedBy(0.8)
//            make.height.equalTo(contentStackView).multipliedBy(0.1)
//            make.centerX.equalTo(contentStackView)
//        }
//        withDrawButton.snp.makeConstraints { make in
//            make.top.equalTo(slider.snp.bottom).offset(20)
//            make.width.equalTo(contentStackView).multipliedBy(0.5)
//            make.trailing.equalTo(contentStackView)
//            make.height.equalTo(contentStackView).multipliedBy(0.05)
//        }
//        heightView.snp.makeConstraints { make in
//            make.top.equalTo(withDrawButton.snp.bottom).offset(20)
//            make.height.equalTo(1000)
//            make.bottom.equalTo(scrollView.snp.bottom)
//        }
//
//        contentStackView.snp.makeConstraints { make in
//            make.edges.equalTo(scrollView.contentLayoutGuide)
//            make.bottom.equalTo(scrollView.contentLayoutGuide)
//        }
//
//        stackView.snp.makeConstraints { make in
//            make.edges.equalTo(contentStackView)
//            make.height.equalTo(0)
//        }
        
        
        
        // hiddenView
//        sesacTitleLabel.snp.makeConstraints { make in
//            make.top.equalTo(safeAreaLayoutGuide).offset(8)
//            make.leading.equalTo(safeAreaLayoutGuide)
//            make.width.equalTo(safeAreaLayoutGuide)
//            make.height.equalTo(safeAreaLayoutGuide).offset(0.1)
//        }
//        mannerTitleLabel.snp.makeConstraints { make in
//            make.top.equalTo(sesacTitleLabel.snp.bottom)
//            make.leading.equalTo(sesacTitleLabel.snp.leading)
//            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.45)
//            make.height.equalTo(sesacTitleLabel.snp.height)
//        }
//        timeTitleLabel.snp.makeConstraints { make in
//            make.top.equalTo(sesacTitleLabel.snp.bottom)
//            make.trailing.equalTo(sesacTitleLabel.snp.trailing)
//            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.45)
//            make.height.equalTo(sesacTitleLabel.snp.height)
//        }
//        responseTitleLabel.snp.makeConstraints { make in
//            make.top.equalTo(mannerTitleLabel.snp.bottom)
//            make.leading.equalTo(sesacTitleLabel.snp.leading)
//            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.45)
//            make.height.equalTo(sesacTitleLabel.snp.height)
//        }
//        niceTitleLabel.snp.makeConstraints { make in
//            make.top.equalTo(mannerTitleLabel.snp.bottom)
//            make.trailing.equalTo(sesacTitleLabel.snp.trailing)
//            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.45)
//            make.height.equalTo(sesacTitleLabel.snp.height)
//        }
//        handyTitleLabel.snp.makeConstraints { make in
//            make.top.equalTo(responseTitleLabel.snp.bottom)
//            make.leading.equalTo(sesacTitleLabel.snp.leading)
//            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.45)
//            make.height.equalTo(sesacTitleLabel.snp.height)
//        }
//        beneficialTitleLabel.snp.makeConstraints { make in
//            make.top.equalTo(responseTitleLabel.snp.bottom)
//            make.trailing.equalTo(sesacTitleLabel.snp.trailing)
//            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.45)
//            make.height.equalTo(sesacTitleLabel.snp.height)
//        }
//        sesacReviewLabel.snp.makeConstraints { make in
//            make.top.equalTo(beneficialTitleLabel.snp.bottom)
//            make.leading.equalTo(safeAreaLayoutGuide)
//            make.width.equalTo(safeAreaLayoutGuide)
//            make.height.equalTo(safeAreaLayoutGuide).offset(0.1)
//        }
    }
}
