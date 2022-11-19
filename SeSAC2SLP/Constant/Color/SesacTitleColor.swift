//
//  SesacTitleColor.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/15.
//

import UIKit

enum SesacTitleColor {
    case none
    case value
    
    var backgroundColor: UIColor {
        switch self {
        case .none:
            return Constants.BaseColor.white!
        case .value:
            return Constants.brandColor.green!
        }
    }
    
    var textColor: UIColor {
        switch self {
        case .none:
            return Constants.BaseColor.black!
        case .value:
            return Constants.BaseColor.white!
        }
    }
    
    var borderColor: CGColor {
        switch self {
        case .none:
            return Constants.grayScale.gray4!.cgColor
        case .value:
            return Constants.brandColor.green!.cgColor
        }
    }
    
}

func sesacTitleColor(i: Int) -> SesacTitleColor {
    if i == 0 {
        return SesacTitleColor.none
    } else {
        return SesacTitleColor.value
    }
}
