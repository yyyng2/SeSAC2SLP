//
//  SecondPageViewController.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/07.
//

import UIKit

final class SecondPageViewController: BaseViewController {
    let label: UILabel = {
       let label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = UIFont(name: "NotoSansKR-Regular", size: 24.0)
        label.text = """
                    스터디를 원하는 친구를
                    찾을 수 있어요
                    """
        return label
    }()
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "onboarding_img2")
        return view
    }()
    
    override func configure() {
        super.configure()
        view.backgroundColor = Constants.BaseColor.white
        [label, imageView].forEach {
            view.addSubview($0)
        }
        let targetString = "스터디를 원하는 친구"
        label.asFontColor(targetString: targetString, font: UIFont(name: "NotoSansKR-Medium", size: 24.0), color: Constants.brandColor.green)
    }
    
    override func setConstraints() {
        label.snp.makeConstraints { make in
            make.centerX.width.equalTo(view)
            make.centerY.equalTo(view).multipliedBy(0.6)
            make.height.equalTo(view).multipliedBy(0.4)
        }
        imageView.snp.makeConstraints { make in
            make.centerX.width.equalTo(view)
            make.centerY.equalTo(view).multipliedBy(1.3)
            make.height.equalTo(view).multipliedBy(0.5)
        }
    }
}
