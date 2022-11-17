//
//  HomeViewModel.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/17.
//

import Foundation
import MapKit

import RxSwift
import RxCocoa

class HomeViewModel {
    var queueResult: [FromQueueDB] = []
    
    var pins: [CustomAnnotation] = []
    
    var man: [FromQueueDB] = []
    
    var woman: [FromQueueDB] = []
    
    var currentGender: CObservable<Int> = CObservable(2)
    
    func setGender() {
        man = []
        woman = []
        for i in queueResult {
            if i.gender == 1 {
                man.append(i)
            } else if i.gender == 0 {
                woman.append(i)
            } else {
                break
            }
        }
    }
    
    func addAnnotation(gender: Int?, mapView: MKMapView) {
        setGender()
        
        pins.removeAll()
        
        switch gender {
        case 0:
            woman.forEach({ sesacs in
                let pin = CustomAnnotation(sesac_image: sesacs.sesac, coordinate: CLLocationCoordinate2D(latitude: sesacs.lat, longitude: sesacs.long))
                self.pins.append(pin)
                print("statud:Woman",pins)
            })
        case 1:
            man.forEach({ sesacs in
                let pin = CustomAnnotation(sesac_image: sesacs.sesac, coordinate: CLLocationCoordinate2D(latitude: sesacs.lat, longitude: sesacs.long))
                self.pins.append(pin)
                print("statud:Man",pins)
            })
        case 2:
            queueResult.forEach({ sesacs in
                let pin = CustomAnnotation(sesac_image: sesacs.sesac, coordinate: CLLocationCoordinate2D(latitude: sesacs.lat, longitude: sesacs.long))
                self.pins.append(pin)
                print("statud:ALl",pins)
            })
        case .none:
            queueResult.forEach({ sesacs in
                let pin = CustomAnnotation(sesac_image: sesacs.sesac, coordinate: CLLocationCoordinate2D(latitude: sesacs.lat, longitude: sesacs.long))
                print("statud:none")
                self.pins.append(pin)
            })
        case .some(_):
            queueResult.forEach({ sesacs in
                let pin = CustomAnnotation(sesac_image: sesacs.sesac, coordinate: CLLocationCoordinate2D(latitude: sesacs.lat, longitude: sesacs.long))
                print("statud:some")
                self.pins.append(pin)
            })
        }
        mapView.addAnnotations(self.pins)
    }
    
    func removeAnnotations(mapView: MKMapView, completion: @escaping () -> Void) {
        mapView.removeAnnotations(mapView.annotations)
    }
}
