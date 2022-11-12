//
//  EmailCheckViewModel.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/12.
//

import Foundation

import RxSwift
import RxCocoa

final class EmailCheckViewModel {
    
    struct Input {
        let emailText: ControlProperty<String?>
        let buttonTap: ControlEvent<Void>

    }

    struct Output {
        let validStatus: Observable<Bool>
        let buttonTap: ControlEvent<Void>
    }

    func transform(input: Input) -> Output {
        let nameTextResult = input.emailText
                  .orEmpty
                  .map { $0.count >= 1 }
                  .share()
    

        return Output(validStatus: nameTextResult, buttonTap: input.buttonTap)
    }
    
    func checkPattern(email: String) -> Bool {
     
        let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let result = NSPredicate(format:"SELF MATCHES %@", pattern)
        
        return result.evaluate(with: email)
      
     
    }

    
    
}
