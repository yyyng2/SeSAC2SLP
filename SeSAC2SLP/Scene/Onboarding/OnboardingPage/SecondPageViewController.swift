//
//  SecondPageViewController.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/07.
//

import UIKit

class SecondPageViewController: BaseViewController {
    let label: UILabel = {
       let label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = .center
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
