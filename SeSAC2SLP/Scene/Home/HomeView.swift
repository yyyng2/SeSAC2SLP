//
//  HomeView.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/15.
//

import UIKit
import MapKit

class HomeView: BaseView {
    let mapView: MKMapView = {
       let view = MKMapView()
        view.showsUserLocation = true
        view.setUserTrackingMode(.follow, animated: true)
        return view
    }()
    
    lazy var statusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "match2"), for: .normal)
        button.backgroundColor = .clear
        return button
    }()
    
    let centerPin: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "map_marker")
        return image
    }()
    
    let allGenderButton: CustomMapGenderButton = {
        var config = CustomMapGenderButton.Configuration.plain()
        
        var titleAttr = AttributedString.init("전체")
        titleAttr.font = UIFont(name: "NotoSansKR-Regular", size: 14)
        config.attributedTitle = titleAttr
        config.titleAlignment = .center
        
        let button = CustomMapGenderButton(configuration: config)
        button.layer.cornerRadius = 0
        button.tag = 2
        
        return button
    }()
    let maleButton: CustomMapGenderButton = {
        var config = CustomMapGenderButton.Configuration.plain()
        
        var titleAttr = AttributedString.init("남자")
        titleAttr.font = UIFont(name: "NotoSansKR-Regular", size: 14)
        config.attributedTitle = titleAttr
        config.titleAlignment = .center
        
        let button = CustomMapGenderButton(configuration: config)
        button.layer.cornerRadius = 0
        button.tag = 1
        return button
    }()
    let femaleButton: CustomMapGenderButton = {
        var config = CustomMapGenderButton.Configuration.plain()
        
        var titleAttr = AttributedString.init("여자")
        titleAttr.font = UIFont(name: "NotoSansKR-Regular", size: 14)
        config.attributedTitle = titleAttr
        config.titleAlignment = .center
        
        let button = CustomMapGenderButton(configuration: config)
        button.layer.cornerRadius = 0
        button.tag = 0
        return button
    }()
    let userCurrentLocationButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Constants.BaseColor.white
        button.setImage(UIImage(named: "GPS"), for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()
    let genderButtonStackView: UIStackView = {
        let view = UIStackView()
        view.layer.cornerRadius = 8
        view.axis = .vertical
        view.spacing = 0
        view.clipsToBounds = true
        return view
    }()
    
    override func configure() {
        [mapView, statusButton, centerPin, genderButtonStackView, userCurrentLocationButton].forEach {
            self.addSubview($0)
        }
        
        [allGenderButton, maleButton, femaleButton].forEach {
            genderButtonStackView.addArrangedSubview($0)
        }
    }
    
    override func setConstraints() {
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        statusButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-16)
            make.trailing.equalToSuperview().offset(-16)
        }
        centerPin.snp.makeConstraints { make in
            make.center.equalTo(safeAreaLayoutGuide)
        }
        genderButtonStackView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(52)
            make.leading.equalTo(safeAreaLayoutGuide).offset(16)
        }
        [allGenderButton, maleButton, femaleButton].forEach { button in
            button.snp.makeConstraints { make in
                make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.15)
                make.height.equalTo(button.snp.width)
            }
        }
        userCurrentLocationButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(genderButtonStackView.snp.bottom).offset(16)
            make.width.equalTo(allGenderButton.snp.width)
            make.height.equalTo(allGenderButton)
        }
    }
}
