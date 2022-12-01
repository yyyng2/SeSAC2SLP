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
        mainView.textView.delegate = self
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
