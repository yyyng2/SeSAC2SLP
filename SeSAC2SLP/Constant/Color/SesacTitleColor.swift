//
//  SesacTitleColor.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/15.
//

import UIKit

enum SesacTitleBackgroundColor {
    case none
    case value
    
    var foregroundColor: UIColor {
        switch self {
        case .none:
            return Constants.BaseColor.white!
        case .value:
            return Constants.brandColor.green!
        }
    }
}

func sesacTitleBackgroundColor(i: Int) -> SesacTitleBackgroundColor {
    if i == 0 {
        return SesacTitleBackgroundColor.none
    } else {
        return SesacTitleBackgroundColor.value
    }
}

enum SesacTitleTextColor {
    case none
    case value
    
    var foregroundColor: UIColor {
        switch self {
        case .none:
            return Constants.BaseColor.black!
        case .value:
            return Constants.BaseColor.white!
        }
    }
}

func sesacTitleTextColor(i: Int) -> SesacTitleTextColor {
    if i == 0 {
        return SesacTitleTextColor.none
    } else {
        return SesacTitleTextColor.value
    }
}

