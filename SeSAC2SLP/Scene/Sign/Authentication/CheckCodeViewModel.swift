//
//  CheckCodeViewModel.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/09.
//

import Foundation

import FirebaseAuth
import RxSwift
import RxCocoa

enum CodeRange {
    case over
    case under
    case correct
}

enum CheckCodeStatus {
    case none
    case firstStage
    case finish
}

final class CheckCodeViewModel {
    
    let number = PublishSubject<String>()
    var codeNum = PublishSubject<String>()
    
    struct Input {
        let numText: ControlProperty<String?>
        let buttonTap: ControlEvent<Void>

    }

    struct Output {
        let validStatus: Observable<Bool>
        let numCheck: Observable<CodeRange>
        let buttonTap: ControlEvent<Void>
    }

    func transform(input: Input) -> Output {
        let numTextResult = input.numText
                  .orEmpty
                  .map { $0.count > 5 }
                  .share()
        
        let numCheck = input.numText
            .orEmpty
            .map(checkRange(_:))

        return Output(validStatus: numTextResult, numCheck: numCheck, buttonTap: input.buttonTap)
    }
    
    private func checkRange(_ id: String) -> CodeRange {
        if id.count < 6 {
            return .under
        }
        
        if id.count > 6 {
            return .over
        }
            
        return .correct
    }
    
    func checkPattern(num: String) -> Bool {
        let onlyNum = num.deleteHyphen
        let pattern = "^[0-9]{6}$"
        let result = NSPredicate(format:"SELF MATCHES %@", pattern)
        return result.evaluate(with: onlyNum)
    }

    func checkSign(completionHandler: @escaping (Bool) -> Void) {
        //가입 조회후 없으면 닉네임 뷰로
    }
    
}
