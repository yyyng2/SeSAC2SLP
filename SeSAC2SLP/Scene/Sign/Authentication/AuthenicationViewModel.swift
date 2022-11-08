//
//  AuthenicationViewModel.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/08.
//

import Foundation

import RxSwift
import RxCocoa

enum TextRange {
    case over
    case under
    case underFirst
    case underSecond
    case underThird
    case third
}

enum TextCheck {
    case ok
    case no
}

final class AuthenticationViewModel {
    
    let number = PublishSubject<String>()
    
    struct Input {
        let numText: ControlProperty<String?>
        let buttonTap: ControlEvent<Void>

    }

    struct Output {
        let validStatus: Observable<Bool>
        let numCheck: Observable<TextRange>
        let buttonTap: ControlEvent<Void>
    }

    func transform(input: Input) -> Output {
        let numTextResult = input.numText
                  .orEmpty
                  .map { $0.count > 11 }
                  .share()
        
        let numCheck = input.numText
            .orEmpty
            .map(checkRange(_:))

        return Output(validStatus: numTextResult, numCheck: numCheck, buttonTap: input.buttonTap)
    }
    
    private func checkRange(_ id: String) -> TextRange {
        if id.count < 3 {
            return .under
        }
        
        if id.count > 13 {
            return .over
        }
        
        if id.count > 3 && id.count < 8 {
            return .underFirst
        }
        
        if id.count > 3 && id.count < 9 {
            return .underSecond
        }
        
        if id.count > 3 && id.count < 10 {
            return .underThird
        }
        
        if id.count == 13 {
            return .third
        }
        
        return .under
    }
    
    func checkPattern(num: String) -> TextCheck {
        let onlyNum = num.deleteHypen
        let pattern = "^01[0-1, 7][0-9]{7,8}$"
        let result = NSPredicate(format:"SELF MATCHES %@", pattern)
        print(result.evaluate(with: onlyNum))
        switch result.evaluate(with: onlyNum) {
        case true:
            return .ok
        case false:
            return .no
        }
    }

    
}
