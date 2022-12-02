//
//  ChatViewController.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/30.
//

import UIKit

class ChatViewController: UIViewController {
    let mainView = ChatView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setKeyboard()
        
        setNavigationUI()
        configure()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func setNavigationUI() {
        self.title = "닉네임"
        
        self.navigationController?.navigationBar.tintColor = Constants.BaseColor.black
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        let backBarButtonItem = UIBarButtonItem(image: UIImage(named: "arrow"), style: .plain, target: self, action: #selector(backButtonTapped))
        self.navigationItem.leftBarButtonItem = backBarButtonItem
        
        let moreButton = UIBarButtonItem(image: UIImage(named: "more"), style: .plain, target: self, action: #selector(moreButtonTapped))
        self.navigationItem.rightBarButtonItem = moreButton
    }
    
    func configure() {
        mainView.textView.delegate = self
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.register(ChatTableViewHeaderCell.self, forHeaderFooterViewReuseIdentifier: ChatTableViewHeaderCell.identifier)
        mainView.tableView.register(MyChatTableViewCell.self, forCellReuseIdentifier: MyChatTableViewCell.identifier)
        mainView.tableView.register(PersonChatTableViewCell.self, forCellReuseIdentifier: PersonChatTableViewCell.identifier)
        mainView.tableView.register(FirstChatTableViewCell.self, forCellReuseIdentifier: FirstChatTableViewCell.identifier)
    }
    
    func setKeyboard() {
        mainView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
        mainView.moreMenuView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissMoreMenu)))
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardUp), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardDown), name: UIResponder.keyboardDidHideNotification, object: nil)
       
    }
    
    @objc func backButtonTapped() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func moreButtonTapped() {
        switch mainView.moreMenuView.isHidden {
        case true:
            mainView.moreMenuView.isHidden = false
            mainView.moreMenuView.menuView.snp.updateConstraints { make in
                make.height.equalTo(90)
            }
            UIView.animate(withDuration: 1) {
                self.mainView.layoutIfNeeded()
            }
        case false:
            dismissMoreMenu()
        }
       
    }
    
    @objc func keyBoardUp(notification: Notification){
    
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardSize.height - view.safeAreaInsets.bottom

            self.mainView.messageView.snp.updateConstraints { make in
                make.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(keyboardHeight)
            }

            UIView.animate(withDuration: 1) {
                self.mainView.layoutIfNeeded()
            }
        }
        
        mainView.tableView.scrollToRow(at: [2, 2], at: .bottom, animated: false)
        
    }
    
    @objc func keyBoardDown(notification: NSNotification) {
        mainView.messageView.snp.updateConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        UIView.animate(withDuration: 0.5) {
            self.mainView.layoutIfNeeded()
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func dismissMoreMenu() {
        mainView.moreMenuView.isHidden = true
        mainView.moreMenuView.menuView.snp.updateConstraints { make in
            make.height.equalTo(0)
        }
        UIView.animate(withDuration: 1) {
            self.mainView.layoutIfNeeded()
        }
    }
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: ChatTableViewHeaderCell.identifier) as? ChatTableViewHeaderCell else { return UIView() }
        header.dateLabel.text = "12월 1일 목요일"
        return header
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 1:
            return 0
        default:
            return 30
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 3
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
  
        if indexPath.section == 0 {
            guard let firstCell = tableView.dequeueReusableCell(withIdentifier: FirstChatTableViewCell.identifier, for: indexPath) as? FirstChatTableViewCell else { return UITableViewCell() }
            firstCell.topLabel.text = "test님과 매칭되었습니다"
            return firstCell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PersonChatTableViewCell.identifier, for: indexPath) as? PersonChatTableViewCell else { return UITableViewCell() }
            cell.chatLabel.text = """
                            asdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfadf
                            """
            cell.timeLabel.text = "11:11"
            return cell
        }
        
//        if indexPath.section == 0 {
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: MyChatTableViewCell.identifier, for: indexPath) as? MyChatTableViewCell else { return UITableViewCell() }
//            cell.chatLabel.text = """
//                                asdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfadf
//                                """
//            cell.timeLabel.text = "11:11"
//            return cell
//        } else {
          
//        }
    }
}

extension ChatViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        
        if textView.text.count > 1 {
            mainView.sendButton.isEnabled = true
        } else {
            mainView.sendButton.isEnabled = false
        }
        
        let contentHeight = textView.contentSize.height
        
        DispatchQueue.main.async {
            if contentHeight <= 35 {
                self.mainView.textView.snp.updateConstraints { make in
                    make.height.equalTo(35)
                }
            }
            else if contentHeight >= 70 {
                self.mainView.textView.snp.updateConstraints { make in
                    make.height.equalTo(70)
                }
            }
            else {
                self.mainView.textView.snp.updateConstraints { make in
                    make.height.equalTo(contentHeight)
                }
            }
        }
        
        
    }
}
