//
//  ThirdPageView.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/07.
//

import UIKit

class ThirdPageViewController: BaseViewController {
    let label: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.text = "SeSAC Study"
        label.font = UIFont(name: "NotoSansKR-Medium", size: 24.0)
        return label
    }()
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "onboarding_img3")
        return view
    }()
    
    override func configure() {
        super.configure()
        view.backgroundColor = Constants.BaseColor.white
        [label, imageView].forEach {
            view.addSubview($0)
        }
    }
    
    override func setConstraints() {
        label.snp.makeConstraints { make in
            make.centerX.width.equalTo(view)
            make.centerY.equalTo(view).multipliedBy(0.7)
            make.height.equalTo(view).multipliedBy(0.4)
        }
        imageView.snp.makeConstraints { make in
            make.centerX.width.equalTo(view)
            make.centerY.equalTo(view).multipliedBy(1.2)
            make.height.equalTo(view).multipliedBy(0.4)
        }
    }
}
