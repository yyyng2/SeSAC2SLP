//
//  GenderCheckViewModel.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/12.
//

import Foundation

import RxSwift
import RxCocoa

enum gender: Int {
    case man = 1
    case woman = 0
    case none = 2
}

final class GenderCheckViewModel {
    
    var genderInit: gender = .none
    
    struct Input {
        let leftBool: Bool?
        let rightBool: Bool?
        let leftButtonTap: ControlEvent<Void>
        let rightButtonTap: ControlEvent<Void>
        let buttonTap: ControlEvent<Void>

    }

    struct Output {
        let leftButtonTap: ControlEvent<Void>
        let rightButtonTap: ControlEvent<Void>
        let buttonTap: ControlEvent<Void>
    }

    func transform(input: Input) -> Output {

        return Output(leftButtonTap: input.leftButtonTap, rightButtonTap: input.rightButtonTap, buttonTap: input.buttonTap)
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
