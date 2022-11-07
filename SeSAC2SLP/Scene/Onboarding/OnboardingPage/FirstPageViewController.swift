//
//  FirstPageViewController.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/07.
//

import UIKit

class FirstPageViewController: BaseViewController {
    let label: UILabel = {
       let label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = UIFont(name: "NotoSansKR-Regular", size: 24.0)
        label.text = """
                    위치 기반으로 빠르게
                    주위 친구를 확인
                    """
        return label
    }()
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "onboarding_img1")
        return view
    }()
    
    override func configure() {
        super.configure()
        view.backgroundColor = Constants.BaseColor.white
        [label, imageView].forEach {
            view.addSubview($0)
        }
        let targetString = "위치 기반"
        label.asFontColor(targetString: targetString, font: UIFont(name: "NotoSansKR-Medium", size: 24.0), color: Constants.brandColor.green)
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
