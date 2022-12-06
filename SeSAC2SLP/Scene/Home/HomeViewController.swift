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
    
    var results = [Study]()
    
    var gender = 2
    
    var queueState = User.matched
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.topItem?.title = ""
        self.tabBarController?.tabBar.isHidden = false
        self.tabBarController?.tabBar.isTranslucent = false
        networkMoniter()
        setQueueState()
        
        //스터디 다시 찾기 누른 경우
        if User.matched == 3 {
            self.viewModel.addAnnotation(gender: 2, mapView: self.mainView.mapView)
            User.matched = 2
            let vc = SearchQueueViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(User.birth)
        navigationController?.navigationBar.isHidden = true
        
        locationManager.delegate = self
        
        mainView.mapView.delegate = self
            
        userCurrentLocationButtonTapped()
        
        self.locationManager.requestWhenInUseAuthorization()
    }
    
    override func bind() {
        viewModel.currentGender.bind { int in
            switch int {
            case 0:
                self.viewModel.addAnnotation(gender: 0, mapView: self.mainView.mapView)
            case 1:
                self.viewModel.addAnnotation(gender: 1, mapView: self.mainView.mapView)
            case 2:
                self.viewModel.addAnnotation(gender: 2, mapView: self.mainView.mapView)
            default:
                break
            }
        }
    }
  
    override func configure() {
        [mainView.allGenderButton, mainView.maleButton, mainView.femaleButton].forEach {
            $0.addTarget(self, action: #selector(genderButtonTapped(sender:)), for: .touchUpInside)
        }
        mainView.allGenderButton.isSelected = true
        mainView.userCurrentLocationButton.addTarget(self, action: #selector(userCurrentLocationButtonTapped), for: .touchUpInside)
        mainView.statusButton.addTarget(self, action: #selector(statusButtonTapped), for: .touchUpInside)
    }
    
    func setQueueButtonImage() {
        guard let image = MatchedCode(rawValue: User.matched)?.maatchedImageName else { return }
        mainView.statusButton.setImage(UIImage(named: image), for: .normal)
    }
    
    func setQueueState() {
        APIService().requestQueueState { code in
            switch code {
            case 200:
                print("requestQueueState1:",code)
                DispatchQueue.main.async {
                    self.setQueueButtonImage()
                }
            case 201:
                DispatchQueue.main.async {
                    self.setQueueButtonImage()
                }
            case 401:
                AuthenticationManager.shared.updateIdToken { result in
                    switch result {
                    case true:
                        APIService().requestQueueState { code in
                            switch code {
                            case 200:
                                DispatchQueue.main.async {
                                    self.setQueueButtonImage()
                                }
                            case 201:
                                DispatchQueue.main.async {
                                    self.setQueueButtonImage()
                                }
                            default:
                                print("requestQueueStateError1",code)
                            }
                        }
                    case false:
                        self.mainView.makeToast("Error")
                    }
                }
               
                
            default:
                print("requestQueueStateError1",code)
            }
           
        }
    }
    
    func setRegionAndAnnotation(coordinate: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mainView.mapView.setRegion(region, animated: true)
    }
    
    func addCustomPin(sesac_image: Int, coordinate: CLLocationCoordinate2D) {
       let pin = CustomAnnotation(sesac_image: sesac_image, coordinate: coordinate)
        mainView.mapView.addAnnotation(pin)
    }
    
    func deniedMapPermissionCenter() {
        networkMoniter()
        APIService().requestSearchQueue(lat: 37.517829, long: 126.886270) { result, code in
            print("requestSearchQueue2:",result)
//            print("requestSearchQueue2:",code)
            switch code {
            case 200:
                guard let results = result else { return }
                self.viewModel.queueResult = results.fromQueueDB
            case 401:
                AuthenticationManager.shared.updateIdToken { result in
                    switch result {
                    case true:
                        APIService().requestSearchQueue(lat: 37.517829, long: 126.886270) { result, code in
                            switch code {
                            case 200:
                                guard let results = result else { return }
                                self.viewModel.queueResult = results.fromQueueDB
                            default:
                                print("requestSearchQueueError2:",code)
                            }
                        }
                    case false:
                        self.mainView.makeToast("Error")
                    }
                }
            default:
                print("requestSearchQueueError2:",code)
            }
        }
      
    }
    
    override func setNavigationUI() {
        self.navigationController?.navigationBar.tintColor = Constants.BaseColor.black
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "arrow")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "arrow")
        
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(backTapped))
        self.navigationItem.backBarButtonItem = backBarButtonItem
        
    }
    
    @objc func backTapped() {
        navigationController?.popToViewController((self.navigationController?.viewControllers[0])!,
                                                   animated: true)
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
    
    @objc func statusButtonTapped() {
        switch User.matched {
        case 0:
            let vc = TabManViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        case 1:
            let vc = ChatViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        case 2:
            let vc = SearchQueueViewController()
            navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
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
              //기본 새싹 센터로
              let center = CLLocationCoordinate2D(latitude: 37.517829, longitude: 126.886270)
              setRegionAndAnnotation(coordinate: center)
              deniedMapPermissionCenter()
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

extension HomeViewController: CLLocationManagerDelegate {
    
    //location 5. 사용자의 위치를 성공적으로 가지고 온 경우
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(#function, locations)
        
        //ex. 위도경도 기반 날씨 조회
        //ex. 지도 다시 세팅
        if let coordinate = locations.last?.coordinate {
            
            setRegionAndAnnotation(coordinate: coordinate)

        
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

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            
            self.searchQueue(lat: latitude, long: longitude)
            
        }
        
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    
    private func searchQueue(lat: Double, long: Double) {
        networkMoniter()
        APIService().requestSearchQueue(lat: lat, long: long) { result, code in
            print("requestSearchQueue1:",result)
//            print("code1:",code)
            
            switch code {
            case 200:
                guard let results = result else { return }
                self.viewModel.queueResult = results.fromQueueDB
            case 401:
                AuthenticationManager.shared.updateIdToken { result in
                    switch result {
                    case true:
                        APIService().requestSearchQueue(lat: lat, long: long) { result, code in
                            switch code {
                            case 200:
                                guard let results = result else { return }
                                self.viewModel.queueResult = results.fromQueueDB
                            default:
                                print("searchQueueError1:",code)
                            }
                        }
                    case false:
                        self.mainView.makeToast("Error")
                    }
                }
            default:
                print("searchQueueError1:",code)
            }
        }
      
    }

    
    
}

extension HomeViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        _ = self.getCenterLocation(for: mapView)
      
        let lat = mapView.centerCoordinate.latitude
        let long = mapView.centerCoordinate.longitude

        User.currentLat = lat
        User.currentLong = long
        
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
