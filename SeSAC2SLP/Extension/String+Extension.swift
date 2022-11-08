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
      
      let stringWithHypen: String = self
      var result = stringWithHypen.components(separatedBy: ["-"]).joined()
      result.insert("-", at: stringWithHypen.index(stringWithHypen.startIndex, offsetBy: 3))
      
    
      return result
  }
    
    public var underSecondWithHypen: String {
        
        let stringWithHypen: String = self
        var result = stringWithHypen.components(separatedBy: ["-"]).joined()
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
        
        let stringWithHypen: String = self
        var result = stringWithHypen.components(separatedBy: ["-"]).joined()
        result.insert("-", at: result.index(result.startIndex, offsetBy: 3))
        result.insert("-", at: result.index(result.startIndex, offsetBy: 8))
        
        return result
    }
    
    public var deleteOverRange: String {
        
        var stringWithHypen: String = self
        let index = stringWithHypen.index(stringWithHypen.startIndex, offsetBy: 13)
        stringWithHypen = String(stringWithHypen[..<index])

        return stringWithHypen
    }
    
    public var deleteHypen: String {
        var stringWithHypen: String = self
        var result = stringWithHypen.components(separatedBy: ["-"]).joined()
        return result
        
    }
}
