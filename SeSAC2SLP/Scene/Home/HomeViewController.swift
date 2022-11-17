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
    
    let locationManager = CLLocationManager()
    
    let viewModel = HomeViewModel()
    
    var gender = 2
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        APIService().requestQueueState()
        
      
        
        mainView.statusButton.setImage(UIImage(named: "matched\(User.matched)"), for: .normal)
        print(mainView.statusButton.isEnabled)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        
        locationManager.delegate = self
        
        mainView.mapView.delegate = self
        
        APIService().requestSearchQueue(lat: 37.517829, long: 126.886270) { result, code in
            print("Queue:",result)
            print("code:",code)
            guard let results = result?.fromQueueDB else { return }
            self.viewModel.queueResult = results
        }
            
//        let center = CLLocationCoordinate2D(latitude: 37.517829, longitude: 126.886270)
//             setRegionAndAnnotation(center: center)
        
        self.locationManager.requestWhenInUseAuthorization()
    }
    
    override func bind() {
        viewModel.currentGender.bind { int in
            switch int {
            case 0:
                self.viewModel.addAnnotation(gender: 0, mapView: self.mainView.mapView)
                self.gender = 0
            case 1:
                self.viewModel.addAnnotation(gender: 1, mapView: self.mainView.mapView)
                self.gender = 1
            default:
                self.viewModel.addAnnotation(gender: 2, mapView: self.mainView.mapView)
                self.gender = 2
            }
        }
    }
  
    override func configure() {
        [mainView.allGenderButton, mainView.maleButton, mainView.femaleButton].forEach {
            $0.addTarget(self, action: #selector(genderButtonTapped(sender:)), for: .touchUpInside)
        }
        mainView.allGenderButton.isSelected = true
        mainView.userCurrentLocationButton.addTarget(self, action: #selector(userCurrentLocationButtonTapped), for: .touchUpInside)
    }
    
    
    func setRegionAndAnnotation(coordinate: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mainView.mapView.setRegion(region, animated: true)
        
//        let annotation = CustomAnnotation(sesac_image: User.sesac, coordinate: coordinate)
//        mainView.mapView.addAnnotation(annotation)
    }
    
    func addCustomPin(sesac_image: Int, coordinate: CLLocationCoordinate2D) {
       let pin = CustomAnnotation(sesac_image: sesac_image, coordinate: coordinate)
        mainView.mapView.addAnnotation(pin)
    }
    
    @objc func genderButtonTapped(sender: UIButton) {
        mainView.allGenderButton.isSelected = false
        mainView.maleButton.isSelected = false
        mainView.femaleButton.isSelected = false
        
        sender.isSelected = true
        
        
        viewModel.removeAnnotations(mapView: mainView.mapView) {
            
        }
        
        viewModel.currentGender.value = sender.tag
        gender = sender.tag
    }
    
    @objc func userCurrentLocationButtonTapped() {
        locationManager.startUpdatingLocation()
    }
    
  
}

extension HomeViewController {
    func checkUserDeviceLocationServiceAuthorization() {
           
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
        if let coordinate = locations.last?.coordinate {
            
            setRegionAndAnnotation(coordinate: coordinate)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
              
            }
            self.viewModel.currentGender.value = self.gender
        
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
            self.viewModel.pins = []
            self.viewModel.queueResult = results
        }
        
        switch self.viewModel.currentGender.value {
        case 0:
            self.viewModel.currentGender.value = self.gender
        case 1:
            self.viewModel.currentGender.value = self.gender
        case 2:
            self.viewModel.currentGender.value = self.gender
        default:
            self.viewModel.currentGender.value = self.gender
        }
      
    }

    
    
}

extension HomeViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
//        let lat = mapView.centerCoordinate.latitude
//        let long = mapView.centerCoordinate.longitude
//
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
//            APIService().requestSearchQueue(lat: lat, long: long) { result, code in
//                guard let results = result?.fromQueueDB else { return }
//                self.viewModel.queueResult = results
//            }
//        }
        viewModel.currentGender.value = gender
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard let annotation = annotation as? CustomAnnotation else { return nil }
        
        var annotationView = self.mainView.mapView.dequeueReusableAnnotationView(withIdentifier: CustomAnnotationView.identifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: CustomAnnotationView.identifier)
            annotationView?.canShowCallout = false
            
        } else {
            annotationView?.annotation = annotation
        }
        
        let sesacImage: UIImage!
        
        guard let num = annotation.sesac_image.value else { return nil }
        
        guard let image = SesacCode(rawValue: num)?.sesacImageName else { return nil }
        
        sesacImage = UIImage(named: image)

        
        annotationView!.snp.makeConstraints { make in
            make.width.height.equalTo(110)
        }
        annotationView!.image = sesacImage
        
        return annotationView
    }
}
