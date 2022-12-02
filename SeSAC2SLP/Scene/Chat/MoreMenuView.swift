//
//  MoreMenuView.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/12/02.
//

import UIKit

class MoreMenuView: BaseView {
    let menuView: UIView = {
       let view = UIView()
        view.backgroundColor = Constants.BaseColor.white
        return view
    }()
    
    let sirenButton: UIButton = {
        var config = UIButton.Configuration.plain()
        var titleAttr = AttributedString.init("새싹 신고")
        titleAttr.font = UIFont(name: "NotoSansKR-Regular", size: 14)
        config.attributedTitle = titleAttr
        
       
        config.image = UIImage(named: "siren")
        config.imagePlacement = .top
        config.imagePadding = 10
        config.baseForegroundColor = Constants.BaseColor.black
        

        let button = UIButton(configuration: config)
        button.contentHorizontalAlignment = .center
        button.contentVerticalAlignment = .bottom
        button.configuration = config
        return button
    }()
    
    let cancelButton: UIButton = {
        var config = UIButton.Configuration.plain()
        var titleAttr = AttributedString.init("스터디 취소")
        titleAttr.font = UIFont(name: "NotoSansKR-Regular", size: 14)
        config.attributedTitle = titleAttr
        
       
        config.image = UIImage(named: "cancel_match")
        config.imagePlacement = .top
        config.imagePadding = 10
        config.baseForegroundColor = Constants.BaseColor.black
        

        let button = UIButton(configuration: config)
        button.contentHorizontalAlignment = .center
        button.contentVerticalAlignment = .bottom
        button.configuration = config
        return button
    }()
    
    let writeButton: UIButton = {
        var config = UIButton.Configuration.plain()
        var titleAttr = AttributedString.init("리뷰 등록")
        titleAttr.font = UIFont(name: "NotoSansKR-Regular", size: 14)
        config.attributedTitle = titleAttr
        
       
        config.image = UIImage(named: "write_review")
        config.imagePlacement = .top
        config.imagePadding = 10
        config.baseForegroundColor = Constants.BaseColor.black
        

        let button = UIButton(configuration: config)
        button.contentHorizontalAlignment = .center
        button.contentVerticalAlignment = .bottom
        button.configuration = config
        return button
    }()
    
    override func configure() {
        backgroundColor = Constants.BaseColor.black?.withAlphaComponent(0.8)
        
        self.addSubview(menuView)

        [sirenButton, cancelButton, writeButton].forEach {
            menuView.addSubview($0)
        }
       
        
    }
    
    override func setConstraints() {
        menuView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.width.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(0)
        }
        sirenButton.snp.makeConstraints { make in
            make.top.equalTo(menuView.snp.top)
            make.centerX.equalToSuperview().multipliedBy(0.3)
            make.height.equalTo(sirenButton.snp.width)
        }
        cancelButton.snp.makeConstraints { make in
            make.top.equalTo(menuView.snp.top)
            make.centerX.equalToSuperview()
            make.height.equalTo(sirenButton.snp.width)
        }
        writeButton.snp.makeConstraints { make in
            make.top.equalTo(menuView.snp.top)
            make.centerX.equalToSuperview().multipliedBy(1.75)
            make.height.equalTo(sirenButton.snp.width)
        }
    }
}
