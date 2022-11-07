//
//  UILabel+Extension.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/08.
//

import UIKit

extension UILabel {
    func asFontColor(targetString: String, font: UIFont?, color: UIColor?) {
        let fullText = text ?? ""
        let attributedString = NSMutableAttributedString(string: fullText)
        let range = (fullText as NSString).range(of: targetString)
        attributedString.addAttributes([.font: font as Any, .foregroundColor: color as Any], range: range)
        attributedText = attributedString
    }
    
    func asFontColor(targetStringList: [String], font: UIFont?, color: UIColor?) {
           let fullText = text ?? ""
           let attributedString = NSMutableAttributedString(string: fullText)

           targetStringList.forEach {
               let range = (fullText as NSString).range(of: $0)
               attributedString.addAttributes([.font: font as Any, .foregroundColor: color as Any], range: range)
           }
           attributedText = attributedString
       }
}
