//
//  BirthCheckViewModel.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/10.
//

import Foundation

import RxSwift
import RxCocoa

final class BirthCheckViewModel {
    
    var dateString: String?
    
    struct Input {
        let date: ControlProperty<Date>
        let yearText: ControlProperty<String?>
        let monthText: ControlProperty<String?>
        let dayText: ControlProperty<String?>
        let buttonTap: ControlEvent<Void>

    }

    struct Output {
        let date: Observable<Date>
        let yearValidStatus: Observable<Bool>
        let monthValidStatus: Observable<Bool>
        let dayValidStatus: Observable<Bool>
        let buttonTap: ControlEvent<Void>
    }

    func transform(input: Input) -> Output {
        let dateResult = input.date
            .ifEmpty(default: Date())
            .share()
        
        let dayTextResult = input.dayText
                  .orEmpty
                  .map { $0.count >= 1 }
                  .share()
        
        let monthTextResult = input.monthText
                  .orEmpty
                  .map { $0.count >= 1 }
                  .share()
        
        let yearTextResult = input.yearText
                  .orEmpty
                  .map { $0.count >= 1 }
                  .share()
        
        
   
        return Output(date: dateResult, yearValidStatus: yearTextResult, monthValidStatus: monthTextResult, dayValidStatus: dayTextResult, buttonTap: input.buttonTap)
    }

    func checkAge(date: Date) -> Bool {
    
        let currentDate = Date()
        
        let currentYear = currentDate.formatToInt(dateStyle: .year)
        let currentMonth = currentDate.formatToInt(dateStyle: .month)
        let currentDay = currentDate.formatToInt(dateStyle: .day)
        
        let userYear = date.formatToInt(dateStyle: .year)
        let userMonth = date.formatToInt(dateStyle: .month)
        let userDay = date.formatToInt(dateStyle: .day)

        if currentYear - userYear > 17 {
            return true
        } else if currentYear - userYear == 17 {
            if currentMonth >= userMonth {
                if currentDay >= userDay {
                    return true
                } else {
                    return false
                }
            } else {
                return false
            }
        } else {
            return false
        }
    }
    
}
