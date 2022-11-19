//
//  UserInfoViewController.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/14.
//

import UIKit

class UserInfoViewController: BaseViewController {
    let mainView = UserInfoView()
    
    let menuList = UserMenuList()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mainView.tableView.delegate = self
        self.mainView.tableView.dataSource = self
    }
    
}

extension UserInfoViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return 5
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: UserInfoTableViewCell.id, for: indexPath) as? UserInfoTableViewCell else { return UITableViewCell() }
            
            guard let image = SesacCode(rawValue: User.sesac)?.sesacImageName else { return cell }
            
            cell.profileView.image = UIImage(named: image)
            cell.profileLabel.text = User.signedName
            
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: UserMenuTableViewCell.id, for: indexPath) as? UserMenuTableViewCell else { return UITableViewCell() }
            
            cell.menuView.image = UIImage(named: menuList.menu[indexPath.row].menuImage)
            cell.menuLabel.text = menuList.menu[indexPath.row].menuName
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.section {
        case 0:
            let vc = UserDetailViewController()
            navigationController?.pushViewController(vc, animated: true)
        default:
            return
        }
    }
}
