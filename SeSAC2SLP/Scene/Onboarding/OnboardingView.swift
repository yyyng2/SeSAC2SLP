//
//  OnboardingView.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/08.
//

import UIKit

final class OnboardingView: BaseView {
    
    let contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    let pageControl: UIPageControl = {
       let control = UIPageControl()
        control.currentPageIndicatorTintColor = Constants.BaseColor.black
        control.pageIndicatorTintColor = Constants.grayScale.gray5
        return control
    }()
    
    let startButton: UIButton = {
       let button = UIButton()
        button.layer.cornerRadius = 10
        button.backgroundColor = Constants.brandColor.green
        button.setTitle("시작하기", for: .normal)
        return button
    }()
    
    
    override func configure() {
        backgroundColor = Constants.BaseColor.white
        [contentView, pageControl, startButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        contentView.snp.makeConstraints { make in
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.8)
            make.centerX.top.width.equalTo(safeAreaLayoutGuide)
        }
        pageControl.snp.makeConstraints { make in
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.1)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.9)
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.top.equalTo(contentView.snp.bottom)
        }
        startButton.snp.makeConstraints { make in
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.1)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.8)
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.top.equalTo(pageControl.snp.bottom)
        }
    }
}
