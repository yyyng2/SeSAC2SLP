//
//  UserDetailViewController.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/14.
//

import UIKit

import MultiSlider

class UserDetailViewController: BaseViewController {
    let mainView = UserDetailView()
    
    var viewHeight: CGFloat = 300
    
    var isExpanded = false
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "정보 관리"
        
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
        
        mainView.underView.slider.value = [CGFloat(User.ageMin), CGFloat(User.ageMax)]
        sliderChanged(mainView.underView.slider)
    }

    
    @objc private func buttonEvent() {

        if isExpanded == true {
            
            isExpanded = false
          
            self.mainView.middleView.snp.updateConstraints { make in
                make.height.equalTo(300)
            }

            self.mainView.topView.arrowImage.image = UIImage(systemName: "chevron.up")
            UIView.animate(withDuration: 1) {
                self.view.layoutIfNeeded()
            }
         
        } else {
            
            isExpanded = true
            
            self.mainView.middleView.snp.updateConstraints { make in
                make.height.equalTo(0)
            }

            self.mainView.topView.arrowImage.image = UIImage(systemName: "chevron.down")
            UIView.animate(withDuration: 1) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc func sliderChanged(_ slider: MultiSlider) {
        self.mainView.underView.ageLabel.text = "\(Int(self.mainView.underView.slider.value[0])) ~ \(Int(self.mainView.underView.slider.value[1]))"
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
