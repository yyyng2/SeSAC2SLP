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
        return view
    }()
    
    let statusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "match\(User.matced)"), for: .normal)
        button.backgroundColor = .clear
        return button
    }()
    
    override func configure() {
        [mapView, statusButton].forEach {
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
    }
}
