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
    
    let statusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "match\(User.matched)"), for: .normal)
        button.backgroundColor = .clear
        return button
    }()
    
    let centerPin: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "map_marker")
        return image
    }()
    
    override func configure() {
        [mapView, statusButton, centerPin].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        mapView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        statusButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-20)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.145)
            make.height.equalTo(statusButton.snp.width)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-8)
        }
        centerPin.snp.makeConstraints { make in
            make.center.equalTo(safeAreaLayoutGuide)
        }
    }
}
