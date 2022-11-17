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
        
        config.buttonSize = .large
        config.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        
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
        
        config.buttonSize = .large
        config.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        
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
        
        config.buttonSize = .large
        config.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        
        let button = CustomMapGenderButton(configuration: config)
        button.layer.cornerRadius = 0
        button.tag = 0
        return button
    }()
    let userCurrentLocationButton: UIButton = {
        let button = UIButton()
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
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        statusButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-16)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-16)
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
                make.width.height.equalTo(49)
            }
        }
        userCurrentLocationButton.snp.makeConstraints { make in
            make.leading.equalTo(safeAreaLayoutGuide).offset(16)
            make.top.equalTo(genderButtonStackView.snp.bottom).offset(16)
        }
    }
}
