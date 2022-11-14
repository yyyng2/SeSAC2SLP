//
//  Date+Extension.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/12.
//

import Foundation

extension Date {
    
    enum DateStyle {
        case year
        case month
        case day
        case time
        case all
    }

    func formatToString(dateStyle: DateStyle) -> String {
        let formatter = DateFormatter()
        
        switch dateStyle {
        case .year:
            formatter.dateFormat = "yyyy"
        case .month:
            formatter.dateFormat = "MM"
        case .day:
            formatter.dateFormat = "dd"
        case .time:
            formatter.dateFormat = "HH:mm:ss.SSS"
        case .all:
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        }


        let date: Date = self

        let result = formatter.string(from: date)
      

        return result
    }
    
    func formatToInt(dateStyle: DateStyle) -> Int {
        let formatter = DateFormatter()
        
        switch dateStyle {
        case .year:
            formatter.dateFormat = "yyyy"
        case .month:
            formatter.dateFormat = "MM"
        case .day:
            formatter.dateFormat = "dd"
        case .time:
            formatter.dateFormat = "HH:mm:ss.SSS"
        case .all:
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        }


        let date: Date = self

        guard let result = Int(formatter.string(from: date)) else { return 0 }
      

        return result
    }
    
   
}
