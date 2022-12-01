//
//  ChatView.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/27.
//

import UIKit

class ChatView: BaseView {
    let tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.sectionFooterHeight = 0
        return view
    }()
    
    let messageView: UIView = {
        let view = UIView()
        return view
    }()
    
    let textView: UITextView = {
       let view = UITextView()
        view.backgroundColor = Constants.grayScale.gray1
        view.font = UIFont(name: "NotoSansKR-Regular", size: 14)
        view.layer.cornerRadius = 8
        return view
    }()
    
    let sendButton: UIButton = {
       let button = UIButton()
        button.setTitle(">", for: .normal)
        button.tintColor = .systemMint
        button.backgroundColor = .systemMint
        return button
    }()
    
    override func configure() {
        [tableView, messageView].forEach {
            self.addSubview($0)
        }
        [textView, sendButton].forEach {
            messageView.addSubview($0)
        }
    }
    
    override func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.width.equalToSuperview()
            make.bottom.equalTo(textView.snp.top)
        }
        messageView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        textView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(12)
            make.height.equalTo(35)
            make.top.bottom.equalToSuperview().inset(14)
            make.trailing.equalTo(sendButton.snp.leading).offset(-8)
        }
        sendButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(12)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(24)
        }
    }
}
