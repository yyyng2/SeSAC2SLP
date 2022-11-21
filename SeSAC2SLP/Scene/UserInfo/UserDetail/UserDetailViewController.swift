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
        
        configureUnderView()
    }
    
    override func configure() {
        super.configure()
        guard let profileImage = SesacCode(rawValue: User.sesac)?.sesacImageName else { return }
        guard let backgroundImage = BackgroundCode(rawValue: User.background)?.backgroundImageName else { return }
        mainView.topView.backgroundImageView.image = UIImage(named: backgroundImage)
        mainView.topView.profileImageView.image = UIImage(named: profileImage)
        mainView.topView.profileLabel.text = User.signedName
        
        if User.comment == [""] {
            mainView.middleView.sesacReviewTextView.text = "첫 리뷰를 기다리는 중이에요!"
            mainView.middleView.sesacReviewTextView.textColor = Constants.grayScale.gray6
        } else {
            mainView.middleView.sesacReviewTextView.text = ""
        }
    }
    
    func configureUnderView() {
        mainView.underView.slider.addTarget(self, action: #selector(sliderChanged), for: .valueChanged)
        mainView.underView.withDrawButton.addTarget(self, action: #selector(withDrawButtonTapped), for: .touchUpInside)
        
        mainView.underView.slider.value = [CGFloat(User.ageMin), CGFloat(User.ageMax)]
        sliderChanged(mainView.underView.slider)
        
        [mainView.underView.maleButton, mainView.underView.femaleButton].forEach {
            $0.addTarget(self, action: #selector(genderButtonTapped(sender:)), for: .touchUpInside)
        }
        
        if User.study == "" {
            mainView.underView.favoriteStudyTextField.text = ""
        } else {
            mainView.underView.favoriteStudyTextField.text = User.study
        }

    }
    
    override func bind() {
        viewModel.userGender.bind { int in
            switch int {
            case 0:
                self.viewModel.setGenderButtonUI(genderButton: self.mainView.underView.femaleButton)
            case 1:
                self.viewModel.setGenderButtonUI(genderButton: self.mainView.underView.maleButton)
            default:
               break
            }
        }
        
        viewModel.userSearchable.bind { int in
            self.mainView.underView.numberPublicStatusSwitch.isOn = int == 1 ? true : false
            switch self.mainView.underView.numberPublicStatusSwitch.isOn {
            case true:
                User.searchable = 1
            case false:
                User.searchable = 0
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
        let min = Int(self.mainView.underView.slider.value[0])
        let max = Int(self.mainView.underView.slider.value[1])
        self.mainView.underView.ageLabel.text = "\(min) ~ \(max)"
    }
    
    @objc func withDrawButtonTapped() {
        let vc = WithDrawViewController()
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true)
    }
    
    
    @objc func genderButtonTapped(sender: UIButton) {
        mainView.underView.maleButton.isSelected = false
        mainView.underView.femaleButton.isSelected = false
        
        sender.isSelected = true
    
        viewModel.userGender.value = sender.tag
        User.gender = sender.tag
        print(User.gender)
    }
    
    @objc func saveButtonTapped() {
        let min = Int(mainView.underView.slider.value[0])
        let max = Int(mainView.underView.slider.value[1])
       
        if mainView.underView.favoriteStudyTextField.text == "" {
            User.study = ""
        } else {
            guard let study = mainView.underView.favoriteStudyTextField.text else { return }
            User.study = study
        }
        
        APIService().mapageUpdate(searchable: User.searchable, ageMin: min, ageMax: max, gender: User.gender, study: User.study) { code in
            print("mypageSave",code)
            switch code {
            case 200:
                let vc = HomeViewController()
                self.navigationController?.popViewController(animated: true)
            default:
                self.mainView.makeToast("정보 저장에 실패했습니다")
            }
        }
    }
    
}

extension UserDetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x > 0 {
            scrollView.contentOffset.x = 0
        }
        scrollView.isPagingEnabled = false
        

        self.mainView.underView.favoriteStudyTextField.resignFirstResponder()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.mainView.underView.favoriteStudyTextField.endEditing(true)
    }
}
