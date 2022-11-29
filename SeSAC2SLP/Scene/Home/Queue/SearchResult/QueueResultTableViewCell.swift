//
//  QueueResultTableViewCell.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/27.
//

import UIKit

import SnapKit

class QueueResultTableViewCell: UITableViewCell {
    static let identifier = String(describing: QueueResultTableViewCell.self)
    
    lazy var studyList = [""]
    
    let sesacTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.BaseColor.black
        label.backgroundColor = .clear
        label.text = "새싹 타이틀"
        label.font = UIFont(name: "NotoSansKR-Regular", size: 12)
        label.textAlignment = .left
        return label
    }()
    
    var mannerTitleLabel: CustomSesacTitleLabel = {
       let label = CustomSesacTitleLabel()
        label.text = "좋은 매너"
        label.textColor = sesacTitleColor(i: User.reputation[0]).textColor
        label.layer.borderColor = sesacTitleColor(i: User.reputation[0]).borderColor
        label.backgroundColor = sesacTitleColor(i: User.reputation[0]).backgroundColor
        return label
    }()
    
    var timeTitleLabel: CustomSesacTitleLabel = {
       let label = CustomSesacTitleLabel()
        label.text = "정확한 시간 약속"
        label.textColor = sesacTitleColor(i: User.reputation[1]).textColor
        label.layer.borderColor = sesacTitleColor(i: User.reputation[1]).borderColor
        label.backgroundColor = sesacTitleColor(i: User.reputation[1]).backgroundColor
        return label
    }()
    
    var responseTitleLabel: CustomSesacTitleLabel = {
       let label = CustomSesacTitleLabel()
        label.text = "빠른 응답"
        label.textColor = sesacTitleColor(i: User.reputation[2]).textColor
        label.layer.borderColor = sesacTitleColor(i: User.reputation[2]).borderColor
        label.backgroundColor = sesacTitleColor(i: User.reputation[2]).backgroundColor
        return label
    }()
    
    var niceTitleLabel: CustomSesacTitleLabel = {
       let label = CustomSesacTitleLabel()
        label.text = "친절한 성격"
        label.textColor = sesacTitleColor(i: User.reputation[3]).textColor
        label.layer.borderColor = sesacTitleColor(i: User.reputation[3]).borderColor
        label.backgroundColor = sesacTitleColor(i: User.reputation[3]).backgroundColor
        return label
    }()
    
    var handyTitleLabel: CustomSesacTitleLabel = {
       let label = CustomSesacTitleLabel()
        label.text = "능숙한 실력"
        label.textColor = sesacTitleColor(i: User.reputation[4]).textColor
        label.layer.borderColor = sesacTitleColor(i: User.reputation[4]).borderColor
        label.backgroundColor = sesacTitleColor(i: User.reputation[4]).backgroundColor
        return label
    }()
    
    var beneficialTitleLabel: CustomSesacTitleLabel = {
       let label = CustomSesacTitleLabel()
        label.text = "유익한 시간"
        label.textColor = sesacTitleColor(i: User.reputation[5]).textColor
        label.layer.borderColor = sesacTitleColor(i: User.reputation[5]).borderColor
        label.backgroundColor = sesacTitleColor(i: User.reputation[5]).backgroundColor
        return label
    }()
    
    let sesacStudyLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.BaseColor.black
        label.backgroundColor = .clear
        label.text = "하고 싶은 스터디"
        label.font = UIFont(name: "NotoSansKR-Regular", size: 12)
        label.textAlignment = .left
        return label
    }()
    
    let collectionView: UICollectionView = {
      
        let layout = LeftAlignedCollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        return collectionView
        
    }()
    
    let sesacReviewLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.BaseColor.black
        label.backgroundColor = .clear
        label.text = "새싹 리뷰"
        label.font = UIFont(name: "NotoSansKR-Regular", size: 12)
        label.textAlignment = .left
        return label
    }()
    
    let sesacReviewButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.baseForegroundColor = Constants.BaseColor.black
        config.imagePlacement = .trailing
        config.image = UIImage(named: "more_arrow")

        let button = UIButton(configuration: config)
        button.isHidden = true
        return button
    }()
    
    let sesacReviewTextView: UILabel = {
       let view = UILabel()
        view.font = UIFont(name: "NotoSansKR-Regular", size: 14)
        view.backgroundColor = .clear
        view.sizeToFit()
        view.textAlignment = .left
        view.numberOfLines = 0
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        setConstraints()
        
        collectionView.register(QueueResultCollectionViewCell.self, forCellWithReuseIdentifier: QueueResultCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        [sesacTitleLabel, mannerTitleLabel, timeTitleLabel, responseTitleLabel, niceTitleLabel, handyTitleLabel, beneficialTitleLabel, sesacStudyLabel, collectionView, sesacReviewLabel, sesacReviewButton, sesacReviewTextView].forEach {
            contentView.addSubview($0)
        }
        
     
    }
    
    func setConstraints() {
        sesacTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(8)
            make.width.equalTo(contentView.snp.width).multipliedBy(0.85)
            make.centerX.equalTo(contentView)
            make.height.equalTo(contentView.snp.height).multipliedBy(0.1)
        }
        mannerTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(sesacTitleLabel.snp.bottom)
            make.leading.equalTo(sesacTitleLabel.snp.leading)
            make.width.equalTo(contentView.snp.width).multipliedBy(0.42)
            make.height.equalTo(sesacTitleLabel.snp.height)
        }
        timeTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(sesacTitleLabel.snp.bottom)
            make.trailing.equalTo(sesacTitleLabel.snp.trailing)
            make.width.equalTo(contentView.snp.width).multipliedBy(0.42)
            make.height.equalTo(sesacTitleLabel.snp.height)
        }
        responseTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(mannerTitleLabel.snp.bottom).offset(4)
            make.leading.equalTo(sesacTitleLabel.snp.leading)
            make.width.equalTo(contentView.snp.width).multipliedBy(0.42)
            make.height.equalTo(sesacTitleLabel.snp.height)
        }
        niceTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(mannerTitleLabel.snp.bottom).offset(4)
            make.trailing.equalTo(sesacTitleLabel.snp.trailing)
            make.width.equalTo(contentView.snp.width).multipliedBy(0.42)
            make.height.equalTo(sesacTitleLabel.snp.height)
        }
        handyTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(responseTitleLabel.snp.bottom).offset(4)
            make.leading.equalTo(sesacTitleLabel.snp.leading)
            make.width.equalTo(contentView.snp.width).multipliedBy(0.42)
            make.height.equalTo(sesacTitleLabel.snp.height)
        }
        beneficialTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(responseTitleLabel.snp.bottom).offset(4)
            make.trailing.equalTo(sesacTitleLabel.snp.trailing)
            make.width.equalTo(contentView.snp.width).multipliedBy(0.42)
            make.height.equalTo(sesacTitleLabel.snp.height)
        }
        sesacStudyLabel.snp.makeConstraints { make in
            make.top.equalTo(beneficialTitleLabel.snp.bottom)
            make.width.equalTo(contentView.snp.width).multipliedBy(0.85)
            make.centerX.equalTo(contentView)
            make.height.equalTo(contentView.snp.height).multipliedBy(0.1)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(sesacStudyLabel.snp.bottom)
            make.width.equalTo(contentView.snp.width).multipliedBy(0.85)
            make.centerX.equalTo(contentView)
            make.height.equalTo(contentView.snp.height).multipliedBy(0.1)
        }
        sesacReviewLabel.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom)
            make.width.equalTo(contentView.snp.width).multipliedBy(0.85)
            make.centerX.equalTo(contentView)
            make.height.equalTo(contentView.snp.height).multipliedBy(0.1)
        }
        sesacReviewButton.snp.makeConstraints { make in
            make.top.equalTo(sesacReviewLabel.snp.top)
            make.trailing.equalTo(beneficialTitleLabel.snp.trailing)
            make.height.equalTo(sesacReviewLabel.snp.height)
            make.width.equalTo(sesacReviewButton.snp.height)
        }
        sesacReviewTextView.snp.makeConstraints { make in
            make.top.equalTo(sesacReviewLabel.snp.bottom)
            make.width.equalTo(contentView.snp.width).multipliedBy(0.85)
            make.centerX.equalTo(contentView)
            make.bottom.equalTo(contentView.snp.bottom)
        }
       
    }
}

extension QueueResultTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      
        return studyList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: QueueResultCollectionViewCell.identifier, for: indexPath) as? QueueResultCollectionViewCell else { return UICollectionViewCell() }
      
        cell.titleLabel.textColor = Constants.BaseColor.black
        cell.layer.borderColor = Constants.grayScale.gray4?.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8
        cell.titleLabel.text = studyList[indexPath.row]
        return cell
    }
    
    
}

extension QueueResultTableViewCell: UICollectionViewDelegateFlowLayout {
    
    // 셀 크기
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel(frame: CGRect.zero)
        let viewModel = SearchResultViewModel()
       
        label.text = viewModel.fromQueueDB?.value[indexPath.section].studylist[indexPath.row]
       
        label.sizeToFit()
        return CGSize(width: label.frame.width + 28, height: 30)
    }
}
