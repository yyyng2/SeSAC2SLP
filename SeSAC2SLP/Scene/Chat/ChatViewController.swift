//
//  ChatViewController.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/30.
//

import UIKit

class ChatViewController: UIViewController {
    let mainView = ChatView()
    
    var otherUid = ""
    
    var chatList: [Chat] = []
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.isTranslucent = true
        setNavigationUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setKeyboard()
        setNotification()
        setLoadChat()
        setMoreMenuButton()
        configure()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        SocketIOManager.shared.closeConnetcion()
    }
    
    func setNavigationUI() {
        self.title = "\(User.matchedNick)"
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.tintColor = Constants.BaseColor.black
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        let backBarButtonItem = UIBarButtonItem(image: UIImage(named: "arrow"), style: .plain, target: self, action: #selector(backButtonTapped))
        self.navigationItem.leftBarButtonItem = backBarButtonItem
        
        let moreButton = UIBarButtonItem(image: UIImage(named: "more"), style: .plain, target: self, action: #selector(moreButtonTapped))
        self.navigationItem.rightBarButtonItem = moreButton
    }
    
    func configure() {
        mainView.sendButton.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
        mainView.textView.delegate = self
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.register(ChatTableViewHeaderCell.self, forHeaderFooterViewReuseIdentifier: ChatTableViewHeaderCell.identifier)
        mainView.tableView.register(MyChatTableViewCell.self, forCellReuseIdentifier: MyChatTableViewCell.identifier)
        mainView.tableView.register(PersonChatTableViewCell.self, forCellReuseIdentifier: PersonChatTableViewCell.identifier)
        mainView.tableView.register(FirstChatTableViewCell.self, forCellReuseIdentifier: FirstChatTableViewCell.identifier)
    }
    
    func setMoreMenuButton() {
        mainView.moreMenuView.cancelButton.addTarget(self, action: #selector(dodgeButtonTapped), for: .touchUpInside)
    }
    
    func setNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(getMessage), name: NSNotification.Name("getMessage"), object: nil)
    }
    
    func setLoadChat() {
        APIService().loadChat(date: "2022-12-05T10:09:37.688Z") { chat, code in
            guard let chatList = chat else { return }
     
            print(code)
            print(chatList.payload)
            self.chatList = chatList.payload
            print("print",chatList.payload.count, self.chatList.count)
            self.mainView.tableView.reloadData()
            self.mainView.tableView.scrollToRow(at: IndexPath(row: self.chatList.count - 1, section: 1), at: .bottom, animated: false)
            
            SocketIOManager.shared.establishConnection()
        }
    }
    
    func setKeyboard() {
        mainView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
        mainView.moreMenuView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissMoreMenu)))
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardUp), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardDown), name: UIResponder.keyboardDidHideNotification, object: nil)
       
    }
    
    @objc func dodgeButtonTapped() {
        let vc = PopUpViewController()
        vc.status = 3
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true)
    }
    
    @objc func getMessage(notification: NSNotification) {
        print(#function)
        let chat = notification.userInfo!["chat"] as! String
        let createdAt = notification.userInfo!["createdAt"] as! String
        let from = notification.userInfo!["from"] as! String
        let to = notification.userInfo!["to"] as! String
           
        let value = Chat(to: to, from: from, chat: chat, createdAt: createdAt)
        
        self.chatList.append(value)
        mainView.tableView.reloadData()
        mainView.tableView.scrollToRow(at: IndexPath(row: self.chatList.count - 1, section: 1), at: .bottom, animated: false)
    }
    
    @objc func sendButtonTapped() {
        print(#function)
        guard let text = mainView.textView.text else { return }
        APIService().sendChat(message: text) { result, code in
            print("sendButtonTapped",code)
            switch code {
            case 200:
                guard let reuslts = result else { return }
                print(reuslts)
                self.chatList.append(Chat(to: reuslts.to, from: reuslts.from, chat: reuslts.chat, createdAt: reuslts.createdAt))
                self.mainView.tableView.reloadData()
                self.mainView.tableView.scrollToRow(at: IndexPath(row: self.chatList.count - 1, section: 1), at: .bottom, animated: false)
                self.mainView.textView.text = ""
                self.mainView.sendButton.isEnabled = false
            case 401:
                AuthenticationManager.shared.updateIdToken { result in
                    switch result {
                    case true:
                        APIService().sendChat(message: text) { result, code in
                            switch code {
                            case 200:
                                guard let reuslts = result else { return }
                                print(reuslts)
                                self.chatList.append(Chat(to: reuslts.to, from: reuslts.from, chat: reuslts.chat, createdAt: reuslts.createdAt))
                                self.mainView.tableView.reloadData()
                                self.mainView.tableView.scrollToRow(at: IndexPath(row: self.chatList.count - 1, section: 1), at: .bottom, animated: false)
                                self.mainView.textView.text = ""
                                self.mainView.sendButton.isEnabled = false
                            default:
                                print(code)
                            }
                        }
                    case false:
                        print("auth.updateIDTokenError")
                    }
                }
            default:
                print(code)
            }
        }
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
        if chatList.count > 0 {
            mainView.tableView.scrollToRow(at: [1, chatList.count-1], at: .bottom, animated: false)
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
//        header.dateLabel.text = chatList[section].createdAt
        header.dateLabel.text = "\(Date())"
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
//        var number = 0
//        if chatList[0].payload.count > 0 {
//            number = chatList[0].payload.count
//        }
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            var number = 0
            if chatList.count > 0 {
                number = chatList.count
            }
            return number
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
  
        if indexPath.section == 0 {
            guard let firstCell = tableView.dequeueReusableCell(withIdentifier: FirstChatTableViewCell.identifier, for: indexPath) as? FirstChatTableViewCell else { return UITableViewCell() }
            firstCell.topLabel.text = "\(User.matchedNick)님과 매칭되었습니다"
            return firstCell
        } else {
            if chatList[indexPath.row].from == User.uid {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: MyChatTableViewCell.identifier, for: indexPath) as? MyChatTableViewCell else { return UITableViewCell() }
                cell.chatLabel.text = """
                                \(chatList[indexPath.row].chat)
                                """
                cell.timeLabel.text = "\(chatList[indexPath.row].createdAt)"
                return cell
            } else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: PersonChatTableViewCell.identifier, for: indexPath) as? PersonChatTableViewCell else { return UITableViewCell() }
                cell.chatLabel.text = """
                                \(chatList[indexPath.row].chat)
                                """
                cell.timeLabel.text = "\(chatList[indexPath.row].createdAt)"
                return cell
            }
          
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
