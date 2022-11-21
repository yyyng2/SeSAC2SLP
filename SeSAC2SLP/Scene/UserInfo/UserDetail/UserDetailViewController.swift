//
//  UserDetailViewController.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/14.
//

import UIKit

import FirebaseAuth
import MultiSlider

class UserDetailViewController: BaseViewController {
    let mainView = UserDetailView()
    let viewModel = UserDetailViewModel()
    var viewHeight: CGFloat = 300
    
    var isExpanded = false
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.topView.expandButton.addTarget(self, action: #selector(buttonEvent), for: .touchUpInside)
        
        mainView.scrollView.delegate = self
        
        print(User.reputation[0], User.reputation[1])
    }
    
    override func configure() {
        super.configure()
        guard let profileImage = SesacCode(rawValue: User.sesac)?.sesacImageName else { return }
        guard let backgroundImage = BackgroundCode(rawValue: User.background)?.backgroundImageName else { return }
        mainView.topView.backgroundImageView.image = UIImage(named: backgroundImage)
        mainView.topView.profileImageView.image = UIImage(named: profileImage)
        mainView.topView.profileLabel.text = User.signedName
        
        mainView.underView.slider.addTarget(self, action: #selector(sliderChanged), for: .valueChanged)
        mainView.underView.withDrawButton.addTarget(self, action: #selector(withDrawButtonTapped), for: .touchUpInside)
        
        if User.comment == [""] {
            mainView.middleView.sesacReviewTextView.text = "첫 리뷰를 기다리는 중이에요!"
            mainView.middleView.sesacReviewTextView.textColor = Constants.grayScale.gray6
        } else {
            mainView.middleView.sesacReviewTextView.text = ""
        }
        
        mainView.underView.slider.value = [CGFloat(User.ageMin), CGFloat(User.ageMax)]
        sliderChanged(mainView.underView.slider)
        
    }
    
    override func bind() {
        viewModel.userGender.bind { int in
            switch int {
            case 0:
                self.viewModel.setButtonUI(genderButton: self.mainView.underView.femaleButton)
            case 1:
                self.viewModel.setButtonUI(genderButton: self.mainView.underView.maleButton)
            default:
               break
            }
        }
    }
    
    override func setNavigationUI() {
        self.title = "정보 관리"
        navigationController?.navigationBar.isHidden = false
        let saveButton = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonTapped))
        self.navigationItem.rightBarButtonItem = saveButton
    }

    
    @objc private func buttonEvent() {

        if isExpanded == true {
            
            isExpanded = false
          
            self.mainView.middleView.snp.updateConstraints { make in
                make.height.equalTo(300)
            }
            self.mainView.backgroundView.snp.updateConstraints { make in
                make.height.equalTo(340)
            }
            mainView.middleView.sesacReviewButton.isHidden = false

            self.mainView.topView.arrowImage.image = UIImage(systemName: "chevron.up")
            UIView.animate(withDuration: 1) {
                self.view.layoutIfNeeded()
            }
         
        } else {
            
            isExpanded = true
            
            self.mainView.middleView.snp.updateConstraints { make in
                make.height.equalTo(0)
            }
            self.mainView.backgroundView.snp.updateConstraints { make in
                make.height.equalTo(50)
            }
            mainView.middleView.sesacReviewButton.isHidden = true
            self.mainView.topView.arrowImage.image = UIImage(systemName: "chevron.down")
            UIView.animate(withDuration: 1) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc func sliderChanged(_ slider: MultiSlider) {
        self.mainView.underView.ageLabel.text = "\(Int(self.mainView.underView.slider.value[0])) ~ \(Int(self.mainView.underView.slider.value[1]))"
    }
    
    @objc func withDrawButtonTapped() {
        APIService().withDraw { code in
            switch code {
            case 200:
                for key in UserDefaults.standard.dictionaryRepresentation().keys {
                    UserDefaults.standard.removeObject(forKey: key.description)
                }
                let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                let sceneDelegate = windowScene?.delegate as? SceneDelegate
                let rootViewController = LaunchScreenViewController()
                let navi = UINavigationController(rootViewController: rootViewController)
                sceneDelegate?.window?.rootViewController = navi
            default:
                self.mainView.makeToast("Error")
            }
        }
    }
    
    @objc func genderButtonTapped() {
        if mainView.underView.maleButton.isSelected == true {
            mainView.underView.femaleButton.isSelected == false
        } else {
            mainView.underView.femaleButton.isSelected == true
        }
    }
    
    @objc func saveButtonTapped() {
//        APIService().mapageUpdate(searchable: <#T##Int#>, ageMin: <#T##Int#>, ageMax: <#T##Int#>, gender: <#T##Int#>, study: <#T##String#>, completionHandler: <#T##(Int) -> Void#>)
    }
}

extension UserDetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x > 0 {
            scrollView.contentOffset.x = 0
        }
        scrollView.isPagingEnabled = false
    }
}
