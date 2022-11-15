//
//  UserDefaultsHelper.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/07.
//

import Foundation

@propertyWrapper struct UserDefaultsHelper<T> {
    private var key: String
    private let defaultValue: T
    
    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}

enum keyEnum: String {
    case isAppFirstLaunch = "isAppFirstLaunch"
    case signStatus = "signStatus"
    case phoneNumber = "phoneNumber"
    case authVerificationID = "authVerificationID"
    case verificationCode = "verificationCode"
    case IDToken = "IDToken"
    case fcm = "fcm"
    case nickname = "nickname"
    case birth = "birth"
    case email = "email"
    case gender = "gender"
    case sesac = "sesac"
    case sesacCollection = "sesacCollection"
    case background = "background"
    case backgroundCollection = "backgroundCollection"
    case signedName = "signedName"
    case comment = "comment"
    case reputation = "reputation"
}

struct User {
    @UserDefaultsHelper(key: keyEnum.isAppFirstLaunch.rawValue, defaultValue: true)
    static var isAppFirstLaunch: Bool
    @UserDefaultsHelper(key: keyEnum.signStatus.rawValue, defaultValue: 0)
    static var signStatus: Int
    @UserDefaultsHelper(key: keyEnum.phoneNumber.rawValue, defaultValue: "")
    static var phoneNumber: String
    @UserDefaultsHelper(key: keyEnum.authVerificationID.rawValue, defaultValue: "")
    static var authVerificationID: String
    @UserDefaultsHelper(key: keyEnum.verificationCode.rawValue, defaultValue: 0)
    static var verificationCode: Int
    @UserDefaultsHelper(key: keyEnum.IDToken.rawValue, defaultValue: "")
    static var IDToken: String
    @UserDefaultsHelper(key: keyEnum.fcm.rawValue, defaultValue: "")
    static var fcm: String
    @UserDefaultsHelper(key: keyEnum.nickname.rawValue, defaultValue: "")
    static var nickname: String
    @UserDefaultsHelper(key: keyEnum.birth.rawValue, defaultValue: "")
    static var birth: String
    @UserDefaultsHelper(key: keyEnum.email.rawValue, defaultValue: "")
    static var email: String
    @UserDefaultsHelper(key: keyEnum.gender.rawValue, defaultValue: 2)
    static var gender: Int
    @UserDefaultsHelper(key: keyEnum.sesac.rawValue, defaultValue: 0)
    static var sesac: Int
    @UserDefaultsHelper(key: keyEnum.sesacCollection.rawValue, defaultValue: [0])
    static var sesacCollection: [Int]
    @UserDefaultsHelper(key: keyEnum.background.rawValue, defaultValue: 0)
    static var background: Int
    @UserDefaultsHelper(key: keyEnum.backgroundCollection.rawValue, defaultValue: [0])
    static var backgroundCollection: [Int]
    @UserDefaultsHelper(key: keyEnum.signedName.rawValue, defaultValue: "")
    static var signedName: String
    @UserDefaultsHelper(key: keyEnum.comment.rawValue, defaultValue: [""])
    static var comment: [String]
    @UserDefaultsHelper(key: keyEnum.reputation.rawValue, defaultValue: [0,0,0,0,0,0,0,0,0])
    static var reputation: [Int]
}
