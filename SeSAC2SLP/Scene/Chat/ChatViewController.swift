//
//  ChatViewController.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/30.
//

import UIKit

class ChatViewController: BaseViewController {
    let mainView = ChatView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setKeyboard()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func configure() {
        mainView.textView.delegate = self
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.register(ChatTableViewHeaderCell.self, forHeaderFooterViewReuseIdentifier: ChatTableViewHeaderCell.identifier)
        mainView.tableView.register(MyChatTableViewCell.self, forCellReuseIdentifier: MyChatTableViewCell.identifier)
        mainView.tableView.register(PersonChatTableViewCell.self, forCellReuseIdentifier: PersonChatTableViewCell.identifier)
    }
    
    func setKeyboard() {
        mainView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardUp), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardDown), name: UIResponder.keyboardDidHideNotification, object: nil)
       
    }
    
    @objc func keyBoardUp(notification: Notification){
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardSize.height - view.safeAreaInsets.bottom
            mainView.messageView.snp.updateConstraints { make in
                make.bottom.equalTo(view.safeAreaLayoutGuide).inset(keyboardHeight)
            }
            UIView.animate(withDuration: 1) {
                self.mainView.layoutIfNeeded()
            }
        }
        
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
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: ChatTableViewHeaderCell.identifier) as? ChatTableViewHeaderCell else { return UIView() }
        header.dateLabel.text = "12월 1일 목요일"
        return header
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyChatTableViewCell.identifier, for: indexPath) as? MyChatTableViewCell else { return UITableViewCell() }
        cell.chatLabel.text = " asdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfadf "
        cell.timeLabel.text = "11:11"
        return cell
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
