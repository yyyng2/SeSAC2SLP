//
//  UserDetailViewController.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/14.
//

import UIKit

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
        
        mainView.expandButton.addTarget(self, action: #selector(buttonEvent), for: .touchUpInside)
        
        print(User.reputation[0], User.reputation[1])
    }
    
    override func configure() {
        super.configure()
        guard let profileImage = SesacCode(rawValue: User.sesac)?.sesacImageName else { return }
        guard let backgroundImage = BackgroundCode(rawValue: User.background)?.backgroundImageName else { return }
        mainView.backgroundImageView.image = UIImage(named: backgroundImage)
        mainView.profileImageView.image = UIImage(named: profileImage)
        mainView.profileLabel.text = User.signedName
    }

    
    @objc private func buttonEvent() {

        if isExpanded == true {
            
            isExpanded = false
            
            self.mainView.secondView.snp.updateConstraints { make in
                make.height.equalTo(300)
            }

            self.mainView.arrowImage.image = UIImage(systemName: "chevron.up")
            UIView.animate(withDuration: 1) {
                self.view.layoutIfNeeded()
            }
         
        } else {
            
            isExpanded = true
            
            self.mainView.secondView.snp.updateConstraints { make in
                make.height.equalTo(0)
            }

            self.mainView.arrowImage.image = UIImage(systemName: "chevron.down")
            UIView.animate(withDuration: 1) {
                self.view.layoutIfNeeded()
            }
        }
    }
}
