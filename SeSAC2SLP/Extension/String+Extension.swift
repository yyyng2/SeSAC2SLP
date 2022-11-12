//
//  String+Extension.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/09.
//

import Foundation

extension String {
  // MARK: - 휴대폰 번호 하이픈 추가
  public var underFirstWithHypen: String {
      
      let stringWithHyphen: String = self
      var result = stringWithHyphen.components(separatedBy: ["-"]).joined()
      result.insert("-", at: stringWithHyphen.index(stringWithHyphen.startIndex, offsetBy: 3))
      
    
      return result
  }
    
    public var underSecondWithHypen: String {
        
        let stringWithHyphen: String = self
        var result = stringWithHyphen.components(separatedBy: ["-"]).joined()
        result.insert("-", at: result.index(result.startIndex, offsetBy: 3))
        result.insert("-", at: result.index(result.startIndex, offsetBy: 7))
        
        return result
    }
    
    public var underThirdWithHypen: String {
        
        let stringWithHypen: String = self
        var result = stringWithHypen.components(separatedBy: ["-"]).joined()
        result.insert("-", at: result.index(result.startIndex, offsetBy: 3))
        result.insert("-", at: result.index(result.startIndex, offsetBy: 8))
     
        return result
    }
    
    public var thirdWithHypen: String {
        
        let stringWithHyphen: String = self
        var result = stringWithHyphen.components(separatedBy: ["-"]).joined()
        result.insert("-", at: result.index(result.startIndex, offsetBy: 3))
        result.insert("-", at: result.index(result.startIndex, offsetBy: 8))
        
        return result
    }
    
    public var deleteNumberOverRange: String {
        
        var stringWithHyphen: String = self
        if stringWithHyphen.contains("011-") {
            let index = stringWithHyphen.index(stringWithHyphen.startIndex, offsetBy: 12)
            stringWithHyphen = String(stringWithHyphen[..<index])

            return stringWithHyphen.underSecondWithHypen
        } else {
            let index = stringWithHyphen.index(stringWithHyphen.startIndex, offsetBy: 13)
            stringWithHyphen = String(stringWithHyphen[..<index])

            return stringWithHyphen
        }
    }
    
    public var deleteHyphen: String {
        let stringWithHyphen: String = self
        let result = stringWithHyphen.components(separatedBy: ["-"]).joined()
        return result
        
    }
    
    public var deleteHyphenToSave: String {
        let stringWithHyphen: String = self
        let result = stringWithHyphen.deleteHyphen
        return "+82\(result.dropFirst(1))"
    }
    
    public var deleteCodeOverRange: String {
        
        var code: String = self
     
        let index = code.index(code.startIndex, offsetBy: 6)
        code = String(code[..<index])
        
        return code
        
    }
    
    public var deleteNameOverRange: String {
        
        var name: String = self
     
        let index = name.index(name.startIndex, offsetBy: 10)
        name = String(name[..<index])
        
        return name
        
    }
    
    func changeToDate() -> Date {
        let date: String = self
     
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy-MM-dd"
        
        guard let result = formatter.date(from: date) else { return Date() }
        
        return result
    }
    
}
