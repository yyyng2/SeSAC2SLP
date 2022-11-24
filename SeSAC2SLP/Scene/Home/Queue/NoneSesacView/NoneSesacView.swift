//
//  NoneSesacView.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/25.
//

import UIKit

class NoneSesacView: BaseView {
    let noneSesacImage: UIImageView = {
       let view = UIImageView()
        view.image = UIImage(named: "noneSesac")
        return view
    }()
    
    let noneSesacFirstLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NotoSansKR-Regular", size: 20)
        label.textAlignment = .center
        label.text = "아쉽게도 주변에 새싹이 없어요ㅠ"
        return label
    }()
    
    let noneSesacSecondLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NotoSansKR-Regular", size: 14)
        label.textAlignment = .center
        label.text = "스터디를 변경하거나 조금만 더 기다려 주세요!"
        return label
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
    
    override func configure() {
        [studyChangeButton, refreshButton].forEach {
            buttonStackView.addArrangedSubview($0)
        }
        
        [noneSesacImage, noneSesacFirstLabel, noneSesacSecondLabel, buttonStackView].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        <#code#>
    }
}
