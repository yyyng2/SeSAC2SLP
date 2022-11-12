//
//  NicknameViewModel.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/09.
//

import Foundation

import RxSwift
import RxCocoa

enum nameRange {
    case over
    case under
    case normal
}

final class NicknameCheckViewModel {
    
    struct Input {
        let nameText: ControlProperty<String?>
        let buttonTap: ControlEvent<Void>

    }

    struct Output {
        let validStatus: Observable<Bool>
        let nameCheck: Observable<nameRange>
        let buttonTap: ControlEvent<Void>
    }

    func transform(input: Input) -> Output {
        let nameTextResult = input.nameText
                  .orEmpty
                  .map { $0.count >= 1 }
                  .share()
        
        let nameCheck = input.nameText
            .orEmpty
            .map(checkRange(_:))

        return Output(validStatus: nameTextResult, nameCheck: nameCheck, buttonTap: input.buttonTap)
    }
    
    private func checkRange(_ id: String) -> nameRange {
        if id.count < 1 {
            return .under
        }
        
        if id.count > 10 {
            return .over
        }
        
        return .normal
    }
    
    func checkPattern(name: String) -> Bool {
     
        let pattern = "^[가-힣A-Za-z0-9]{1,10}$"
        let result = NSPredicate(format:"SELF MATCHES %@", pattern)
        
        return result.evaluate(with: name)
      
     
    }

    
    
}
