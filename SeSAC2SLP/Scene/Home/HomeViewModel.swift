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
    
//    struct Input {
//        let currentGender: ControlProperty<Int>
//        let genderButtonTap: ControlEvent<Void>
//        let queueStateButtonTap: ControlEvent<Void>
//    }
//
//    struct Output {
//        let validStatus: Observable<Bool>
//        let nameCheck: Observable<nameRange>
//        let buttonTap: ControlEvent<Void>
//    }
//
//    func transform(input: Input) -> Output {
//        let gender = input.currentGender
//                  .share()
//        addAnnotation(gender: gender.rawValue, mapView: self.mapView)
//
//        return Output(validStatus: nameTextResult, nameCheck: nameCheck, buttonTap: input.buttonTap)
//    }
    
    private func setGender() {
        for i in queueResult {
            if i.gender == 1 {
                man.append(i)
            } else if i.gender == 0 {
                woman.append(i)
            } else {
                
            }
        }
    }
    
    func addAnnotation(gender: Int?, mapView: MKMapView) {
        setGender()
        switch gender {
        case 0:
            woman.forEach({ sesacs in
                let pin = CustomAnnotation(sesac_image: sesacs.sesac, coordinate: CLLocationCoordinate2D(latitude: sesacs.lat, longitude: sesacs.long))
                self.pins.append(pin)
            })
        case 1:
            man.forEach({ sesacs in
                let pin = CustomAnnotation(sesac_image: sesacs.sesac, coordinate: CLLocationCoordinate2D(latitude: sesacs.lat, longitude: sesacs.long))
                self.pins.append(pin)
            })
        case 2:
            queueResult.forEach({ sesacs in
                let pin = CustomAnnotation(sesac_image: sesacs.sesac, coordinate: CLLocationCoordinate2D(latitude: sesacs.lat, longitude: sesacs.long))
                self.pins.append(pin)
            })
        case .none:
            queueResult.forEach({ sesacs in
                let pin = CustomAnnotation(sesac_image: sesacs.sesac, coordinate: CLLocationCoordinate2D(latitude: sesacs.lat, longitude: sesacs.long))
                self.pins.append(pin)
            })
        case .some(_):
            queueResult.forEach({ sesacs in
                let pin = CustomAnnotation(sesac_image: sesacs.sesac, coordinate: CLLocationCoordinate2D(latitude: sesacs.lat, longitude: sesacs.long))
                self.pins.append(pin)
            })
        }
        mapView.addAnnotations(self.pins)
    }
    
    func removeAnnotations(mapView: MKMapView, completion: @escaping () -> Void) {
        mapView.removeAnnotations(mapView.annotations)
    }
}
