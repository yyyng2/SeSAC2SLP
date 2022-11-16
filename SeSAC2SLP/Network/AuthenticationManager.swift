//
//  AuthenticationManager.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/10.
//

import UIKit

import FirebaseAuth

class AuthenticationManager {
    static let shared = AuthenticationManager()
    
    func sendCode(completionHandler: @escaping (Bool) -> Void) {
        PhoneAuthProvider.provider().verifyPhoneNumber(User.phoneNumber, uiDelegate: nil) { verificationID, error in
                guard let verificationID = verificationID, error == nil else {
                    completionHandler(false)
                    return
                }
              
                User.authVerificationID = verificationID
                completionHandler(true)
                
          }
    }
    
    func checkVerifyId(code: String, completionHandler: @escaping (Bool) -> Void) {
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: User.authVerificationID,
            verificationCode: code
        )
        
        Auth.auth().signIn(with: credential) { result, error in
            guard result != nil, error == nil else {
                completionHandler(false)
                return
            }
            
            Auth.auth().currentUser?.getIDTokenForcingRefresh(true) { idToken, error in
                if error != nil {
                    return
                }
                guard let id = idToken else { return }
                print(id)
                User.IDToken = id
            }
            completionHandler(true)
        }
    }
    
    func updateIdToken() {
        Auth.auth().currentUser?.getIDTokenForcingRefresh(true) { idToken, error in
            if error != nil {
                print("error: updateIdTotken")
                let rootViewController = AuthenticationViewController()
                let navigationController = UINavigationController(rootViewController: rootViewController)
            }
            guard let id = idToken else { return }
            print("success: updateIdTotken")
            print(id)
            User.IDToken = id
        }
    }
    
}
