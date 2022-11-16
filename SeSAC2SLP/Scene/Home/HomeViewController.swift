//
//  MainViewController.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/15.
//

import Foundation
import MapKit
import CoreLocation

class HomeViewController: BaseViewController {
    let mainView = HomeView()
    
    var queueResult = [FromQueueDB]()
    
    var pins: [CustomAnnotation] = []
    
    var man
    
    
    let locationManager = CLLocationManager()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        APIService().requestQueueState()
        
      
        
        mainView.statusButton.setImage(UIImage(named: "matched\(User.matced)"), for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        
        locationManager.delegate = self
        
        
        APIService().requestSearchQueue(lat: 37.517829, long: 126.886270) { result, code in
            print("Queue:",result)
            print("code:",code)
            guard let results = result?.fromQueueDB else { return }
            self.queueResult = results
        }
            
//        let center = CLLocationCoordinate2D(latitude: 37.517829, longitude: 126.886270)
//             setRegionAndAnnotation(center: center)
        
        self.locationManager.requestWhenInUseAuthorization()
    }
    
    func setGender() {
        let man = queueResult.forEach { $0.gender }
    }
    
    func setRegionAndAnnotation(center: CLLocationCoordinate2D){
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mainView.mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = center
        mainView.mapView.addAnnotation(annotation)
       }
    
    func addCustomPin(sesac_image: Int, coordinate: CLLocationCoordinate2D) {
       let pin = CustomAnnotation(sesac_image: sesac_image, coordinate: coordinate)
        mainView.mapView.addAnnotation(pin)
    }
    
    func addAnnotation(gender: Int?, mapView: MKMapView, completion: @escaping() -> Void) {

        switch gender {
        case 0:
            maleSesacArray.value?.forEach({ sesacs in
                let anno = CustomAnnotation(sesac_image: sesacs.sesac, coordinate: CLLocationCoordinate2D(latitude: sesacs.lat, longitude: sesacs.long))
                
                self.pins.append(anno)
            })
        case 1:
            femaleSesacArray.value?.forEach({ sesacs in
                let anno = CustomAnnotation(sesac_image: sesacs.sesac, coordinate: CLLocationCoordinate2D(latitude: sesacs.lat, longitude: sesacs.long))
                
                self.annotations.append(anno)
            })
            
            
        case 2:
            queueResult.forEach({ sesacs in
                let pin = CustomAnnotation(sesac_image: sesacs.sesac, coordinate: CLLocationCoordinate2D(latitude: sesacs.lat, longitude: sesacs.long))
                self.pins.append(pin)
            })
        case .none:
            queueResult.forEach({ sesacs in
                let pin = CustomAnnotation(sesac_image: sesacs.sesac, coordinate: CLLocationCoordinate2D(latitude: sesacs.lat, longitude: sesacs.long))
                
                mainView.mapView.addAnnotation(pin)
            })
        case .some(_):
            queueResult.forEach({ sesacs in
                let pin = CustomAnnotation(sesac_image: sesacs.sesac, coordinate: CLLocationCoordinate2D(latitude: sesacs.lat, longitude: sesacs.long))
                
                mainView.mapView.addAnnotation(pin)
            })
        }
        
            mainView.mapView.addAnnotations(self.pins)

    }
    
    func removeAnnotations(mapView: MKMapView, completion: @escaping () -> Void) {
        mapView.removeAnnotations(mapView.annotations)
    }
}

extension HomeViewController {
    func checkUserDeviceLocationServiceAuthorization(){
           
           let authorizationStatus: CLAuthorizationStatus
           //ios 14.0 이상이라면
           if #available(iOS 14.0, *){
               //인스턴스를 통해 locationManager가 가지고 있는 상태를 가져옴
               authorizationStatus = locationManager.authorizationStatus
           } else {
               authorizationStatus = CLLocationManager.authorizationStatus()
           }
           
           //"iOS 위치서비스 활성화" 여부 체크 : locationServicesEnabled()
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                //위치 서비스가 활성화돼 있으므로 위치권한 요청이 가능해서 위치 권한을 요청(3)
                self.checkUserCurrentLocationAuthorization(authorizationStatus)
            } else {
                print("위치서비스가 꺼져있어 권한을 요청하지 못 합니다.")
            }
        }
          
       }
    
    func checkUserCurrentLocationAuthorization(_ authorizationStatus: CLAuthorizationStatus){
          switch authorizationStatus {
          case .notDetermined:
              print("NotDetermined")
                                                //정확도 : kCLLocationAccuracy
              locationManager.desiredAccuracy = kCLLocationAccuracyBest
              
                              //앱을 사용하는 동안에 대한 위치 권한 요청, plist의 whenInUse 해줘야 -> request 메서드 사용 가능
              locationManager.requestWhenInUseAuthorization()
              
  //            locationManager.startUpdatingLocation() //제거가능
              
          case .restricted, .denied:
              print("Denied, 아이폰 설정으로 유도")
              //얼럿을 띄워 설정으로 유도
              showRequestLocationServiceAlert()
          case .authorizedWhenInUse:
              print("When In Use")
              //사용자가 위치를 허용해둔 상태라면, startUpdatingLocation을 통해 didUpdateLocations 메서드 실행
              locationManager.startUpdatingLocation()
          default: print("Default")
          }
      }
      
      //Alert 구현
      func showRequestLocationServiceAlert() {
        let requestLocationServiceAlert = UIAlertController(title: "위치정보 이용", message: "위치 서비스를 사용할 수 없습니다. 기기의 '설정>개인정보 보호'에서 위치 서비스를 켜주세요.", preferredStyle: .alert)
        let goSetting = UIAlertAction(title: "설정으로 이동", style: .destructive) { _ in
            if let appSetting = URL(string: UIApplication.openSettingsURLString){
                UIApplication.shared.open(appSetting)
            }
        }
        let cancel = UIAlertAction(title: "취소", style: .default)
        requestLocationServiceAlert.addAction(cancel)
        requestLocationServiceAlert.addAction(goSetting)
        
        present(requestLocationServiceAlert, animated: true, completion: nil)
      }
}

extension HomeViewController: CLLocationManagerDelegate{
    
    //location 5. 사용자의 위치를 성공적으로 가지고 온 경우
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(#function, locations)
        
        //ex. 위도경도 기반 날씨 조회
        //ex. 지도 다시 세팅
        if let coordinate = locations.last?.coordinate{
            setRegionAndAnnotation(center: coordinate)
//            let latitude = coordinate.latitude
//            let longitude = coordinate.longitude
//            let center = CLLocationCoordinate2D(latitude: <#T##CLLocationDegrees#>, longitude: <#T##CLLocationDegrees#>)
        }
        
        
        //위치 업데이트 멈춤
        locationManager.stopUpdatingLocation()
    }
    
    //location 6. 사용자의 위치를 못가지고 온 경우
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(#function)
    }
    
    //location 9. 사용자의 권한 상태가 바뀔때를 알려줌
    //거부 -> 허용, notDetermined -> 허용
    //허용했어서 위치 가져오는중에 설정에서 거부
    //ios 14이상: 사용자의 권한 상태가 변경이 될 때, 위치 관리자 생성할 때 호출됨(1)
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function)
        checkUserDeviceLocationServiceAuthorization()
    }
    //ios 14미만
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
    }
    
    private func getCenterLocation(for mapView: MKMapView) -> CLLocation {
        let latitude = mainView.mapView.centerCoordinate.latitude
        let longitude = mainView.mapView.centerCoordinate.longitude
                
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            
            self.searchQueue(lat: latitude, long: longitude)
            
//            self.lat = latitude
//            self.long = longitude

      
//            self.searchFriend(region: region, lat: latitude, long: longitude)
        }
        
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    
    private func searchQueue(lat: Double, long: Double) {
        APIService().requestSearchQueue(lat: lat, long: long) { result, code in
            print("Queue:",result)
            print("code:",code)
            guard let results = result?.fromQueueDB else { return }
            self.queueResult = results
            
        }

        searchFriendAllAnnotations()
    }
    
    private func searchFriendAllAnnotations() {
        let annotations = mainView.mapView.annotations
        mainView.mapView.removeAnnotations(annotations)
        
        for location in queueResult {
            let queueCoordinate = CLLocationCoordinate2D(latitude: location.lat, longitude: location.long)
            let queueAnnotation = MKPointAnnotation()
            
            queueAnnotation.coordinate = queueCoordinate
            mainView.mapView.addAnnotation(queueAnnotation)
        }
    }
    
    private func searchFriendGenderAnnotations(_ gender: Int) {
//        let annotations = homeView.mapView.annotations
//        homeView.mapView.removeAnnotations(annotations)
//
//        for location in friends {
//            if location.gender == gender {
//                let friendsCoordinate = CLLocationCoordinate2D(latitude: location.lat, longitude: location.long)
//                let friendsAnnotation = MKPointAnnotation()
//
//                friendsAnnotation.coordinate = friendsCoordinate
//                homeView.mapView.addAnnotation(friendsAnnotation)
//            }
//        }
    }
    
    
}

extension HomeViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
          _ = getCenterLocation(for: mapView)
      }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard let annotation = annotation as? CustomAnnotation else {
            return nil
        }
        
        var annotationView = self.mainView.mapView.dequeueReusableAnnotationView(withIdentifier: CustomAnnotationView.identifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: CustomAnnotationView.identifier)
            annotationView?.canShowCallout = false
            
        } else {
            annotationView?.annotation = annotation
        }
        
        let sesacImage: UIImage!
        
        switch annotation.sesac_image {
        case 0:
            sesacImage = UIImage(named: "sesac_face_1")
        case 1:
            sesacImage = UIImage(named: "sesac_face_2")
        case 2:
            sesacImage = UIImage(named: "sesac_face_3")
        case 3:
            sesacImage = UIImage(named: "sesac_face_4")
        case 4:
            sesacImage = UIImage(named: "sesac_face_5")
        default:
            sesacImage = UIImage(named: "sesac_face_1")
        }
        
        annotationView!.snp.makeConstraints { make in
            make.width.height.equalTo(110)
        }
        annotationView!.image = sesacImage
        
        return annotationView
    }
}
