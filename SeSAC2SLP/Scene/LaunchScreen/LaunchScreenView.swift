//
//  LaunchScreenView.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/14.
//

import UIKit

class LaunchScreenView: BaseView {
    let imageLogoView: UIImageView = {
       let view = UIImageView()
        view.image = UIImage(named: "splash_logo")
        view.contentMode = .scaleAspectFit
        return view
    }()
    let textLogoView: UIImageView = {
       let view = UIImageView()
        view.image = UIImage(named: "splash_txt")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    override func configure() {
        super.configure()
        [imageLogoView, textLogoView].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        imageLogoView.snp.makeConstraints { make in
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.55)
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.3)
            make.centerY.equalTo(safeAreaLayoutGuide).multipliedBy(0.9)
        }
        
        textLogoView.snp.makeConstraints { make in
            make.centerY.equalTo(safeAreaLayoutGuide).multipliedBy(1.3)
            make.centerX.equalTo(safeAreaLayoutGuide).multipliedBy(1)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.8)
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.1)
        }
    }
}
