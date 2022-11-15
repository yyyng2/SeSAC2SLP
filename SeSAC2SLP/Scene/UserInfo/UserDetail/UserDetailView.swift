//
//  UserDetailView.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/14.
//

import UIKit

class UserDetailView: BaseView {
    let backgroundImageView: UIImageView = {
       let view = UIImageView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    let profileImageView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    let profileLabel: UILabel = {
       let label = UILabel()
        label.textColor = Constants.BaseColor.black
        label.backgroundColor = .clear
        label.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        label.textAlignment = .left
        return label
    }()
    let arrowImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "chevron.down")
        view.tintColor = Constants.grayScale.gray7
        return view
    }()
    var expandButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        return button
    }()
    lazy var secondView: UIView = {
        let view = UIView()
        view.layer.borderColor = Constants.grayScale.gray5?.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 10
        view.backgroundColor = Constants.brandColor.yellowGreen
        return view
    }()
    var thirdView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.brandColor.green
        return view
    }()
    let scrollView: UIScrollView = {
      let scrollView = UIScrollView()
      scrollView.backgroundColor = .clear
      scrollView.translatesAutoresizingMaskIntoConstraints = false
      return scrollView
    }()
    
    let view = UserDetailHideView()
    let stackView: UIStackView = {
       let view = UIStackView()
        return view
    }()
    
    
    ////////////////////         hiddenView            ///////////////////////////////
    let sesacTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.BaseColor.black
        label.backgroundColor = .clear
        label.text = "새싹 타이틀"
        label.font = UIFont(name: "NotoSansKR-Medium", size: 12)
        label.textAlignment = .left
        return label
    }()
    
    let mannerTitleLabel: CustomSesacTitleLabel = {
       let label = CustomSesacTitleLabel()
        label.text = "좋은 매너"
//        label.textColor = sesacTitleTextColor(i: User.reputation[0]).foregroundColor
        label.textColor = Constants.BaseColor.black
        label.backgroundColor = sesacTitleBackgroundColor(i: User.reputation[0]).foregroundColor
        return label
    }()
    
    let timeTitleLabel: CustomSesacTitleLabel = {
       let label = CustomSesacTitleLabel()
        label.text = "정확한 시간 약속"
        label.textColor = sesacTitleTextColor(i: User.reputation[1]).foregroundColor
        label.backgroundColor = sesacTitleBackgroundColor(i: User.reputation[1]).foregroundColor
        return label
    }()
    
    let responseTitleLabel: CustomSesacTitleLabel = {
       let label = CustomSesacTitleLabel()
        label.text = "빠른 응답"
        label.textColor = sesacTitleTextColor(i: User.reputation[2]).foregroundColor
        label.backgroundColor = sesacTitleBackgroundColor(i: User.reputation[2]).foregroundColor
        return label
    }()
    
    let niceTitleLabel: CustomSesacTitleLabel = {
       let label = CustomSesacTitleLabel()
        label.text = "친절한 성격"
        label.textColor = sesacTitleTextColor(i: User.reputation[3]).foregroundColor
        label.backgroundColor = sesacTitleBackgroundColor(i: User.reputation[3]).foregroundColor
        return label
    }()
    
    let handyTitleLabel: CustomSesacTitleLabel = {
       let label = CustomSesacTitleLabel()
        label.text = "능숙한 실력"
        label.textColor = sesacTitleTextColor(i: User.reputation[4]).foregroundColor
        label.backgroundColor = sesacTitleBackgroundColor(i: User.reputation[4]).foregroundColor
        return label
    }()
    
    let beneficialTitleLabel: CustomSesacTitleLabel = {
       let label = CustomSesacTitleLabel()
        label.text = "유익한 시간"
        label.textColor = sesacTitleTextColor(i: User.reputation[4]).foregroundColor
        label.backgroundColor = sesacTitleBackgroundColor(i: User.reputation[4]).foregroundColor
        return label
    }()
    
    let sesacReviewLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.BaseColor.black
        label.backgroundColor = .clear
        label.text = "새싹 리뷰"
        label.font = UIFont(name: "NotoSansKR-Medium", size: 12)
        label.textAlignment = .left
        return label
    }()
    
    override func configure() {
        [scrollView].forEach {
            self.addSubview($0)
        }
        [backgroundImageView, profileImageView, expandButton, profileLabel, arrowImage, secondView, thirdView].forEach {
            scrollView.addSubview($0)
        }
        [sesacTitleLabel, mannerTitleLabel, timeTitleLabel, responseTitleLabel, niceTitleLabel, handyTitleLabel, beneficialTitleLabel, sesacReviewLabel].forEach {
            stackView.addSubview($0)
        }
        secondView.addSubview(stackView)
    }
    
    override func setConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        backgroundImageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(12)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.9)
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.3)
            make.centerX.equalTo(safeAreaLayoutGuide)
        }
        profileImageView.snp.makeConstraints { make in
            make.bottom.equalTo(backgroundImageView.snp.bottom).multipliedBy(1)
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.width.equalTo(backgroundImageView.snp.width).multipliedBy(0.6)
            make.height.equalTo(backgroundImageView.snp.height).multipliedBy(0.85)
        }
        profileLabel.snp.makeConstraints { make in
            make.top.equalTo(expandButton.snp.top)
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.8)
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.1)
        }
        arrowImage.snp.makeConstraints { make in
            make.centerY.equalTo(profileLabel.snp.centerY)
            make.width.equalTo(profileLabel.snp.width).multipliedBy(0.05)
            make.height.equalTo(arrowImage.snp.width)
            make.trailing.equalTo(profileLabel.snp.trailing)
        }
        expandButton.snp.makeConstraints { make in
            make.top.equalTo(backgroundImageView.snp.bottom).offset(20)
            make.width.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.1)
        }
        secondView.snp.makeConstraints { make in
            make.top.equalTo(expandButton.snp.bottom)
            make.width.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(0)
        }
        thirdView.snp.makeConstraints { make in
            make.top.equalTo(secondView.snp.bottom).offset(20)
            make.width.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.2)
        }
        
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(300)
        }
        
        // hiddenView
        sesacTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(8)
            make.leading.equalTo(safeAreaLayoutGuide)
            make.width.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(safeAreaLayoutGuide).offset(0.1)
        }
        mannerTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(sesacTitleLabel.snp.bottom)
            make.leading.equalTo(sesacTitleLabel.snp.leading)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.45)
            make.height.equalTo(sesacTitleLabel.snp.height)
        }
        timeTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(sesacTitleLabel.snp.bottom)
            make.trailing.equalTo(sesacTitleLabel.snp.trailing)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.45)
            make.height.equalTo(sesacTitleLabel.snp.height)
        }
        responseTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(mannerTitleLabel.snp.bottom)
            make.leading.equalTo(sesacTitleLabel.snp.leading)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.45)
            make.height.equalTo(sesacTitleLabel.snp.height)
        }
        niceTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(mannerTitleLabel.snp.bottom)
            make.trailing.equalTo(sesacTitleLabel.snp.trailing)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.45)
            make.height.equalTo(sesacTitleLabel.snp.height)
        }
        handyTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(responseTitleLabel.snp.bottom)
            make.leading.equalTo(sesacTitleLabel.snp.leading)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.45)
            make.height.equalTo(sesacTitleLabel.snp.height)
        }
        beneficialTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(responseTitleLabel.snp.bottom)
            make.trailing.equalTo(sesacTitleLabel.snp.trailing)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.45)
            make.height.equalTo(sesacTitleLabel.snp.height)
        }
        sesacReviewLabel.snp.makeConstraints { make in
            make.top.equalTo(beneficialTitleLabel.snp.bottom)
            make.leading.equalTo(safeAreaLayoutGuide)
            make.width.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(safeAreaLayoutGuide).offset(0.1)
        }
    }
}
