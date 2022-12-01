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
