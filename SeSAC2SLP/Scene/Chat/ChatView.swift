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
        view.separatorStyle = .none
        view.rowHeight = UITableView.automaticDimension
        view.estimatedRowHeight = UITableView.automaticDimension
        return view
    }()
    
    let messageView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.grayScale.gray1
        view.layer.cornerRadius = 8
        return view
    }()
    
    let textView: UITextView = {
       let view = UITextView()
        view.font = UIFont(name: "NotoSansKR-Regular", size: 14)
        view.backgroundColor = .clear
        return view
    }()
    
    let sendButton: UIButton = {
       let button = UIButton()
        button.isEnabled = false
        button.setImage(UIImage(named: "unenabledSend"), for: .disabled)
        button.setImage(UIImage(named: "enabledSend"), for: .normal)
        return button
    }()
    
    let moreMenuView = MoreMenuView()
    
    override func configure() {
        backgroundColor = Constants.BaseColor.white
        
        [tableView, messageView, moreMenuView].forEach {
            self.addSubview($0)
        }
        [textView, sendButton].forEach {
            messageView.addSubview($0)
        }
        
        moreMenuView.isHidden = true
    }
    
    override func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.width.equalToSuperview()
            make.bottom.equalTo(messageView.snp.top)
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
        moreMenuView.snp.makeConstraints { make in
            make.top.width.centerX.equalTo(safeAreaLayoutGuide)
            make.centerX.equalTo(tableView)
            make.height.equalTo(UIScreen.main.bounds.maxY)
        }
    }
}
