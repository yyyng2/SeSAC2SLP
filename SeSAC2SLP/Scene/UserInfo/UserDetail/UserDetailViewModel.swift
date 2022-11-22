//
//  UserDetailViewModel.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/20.
//

import UIKit

class UserDetailViewModel {
    
    var userGender: CObservable<Int> = CObservable(User.gender)
    
    var userSearchable: CObservable<Int> = CObservable(User.searchable)
    
    func setGenderButtonUI(genderButton: UIButton) {
        genderButton.isSelected = true
    }
    
    func checkGender(leftBool: Bool, rightBool: Bool) -> gender {
        if leftBool == true {
            return .man
        } else if rightBool == true {
            return .woman
        } else {
            return .none
        }
    }
}
