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
}
