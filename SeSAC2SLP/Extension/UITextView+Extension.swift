//
//  UITextView+Extension.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/12/01.
//

import UIKit

extension UITextView {
    func numberOfLine() -> Int {
        
        let size = CGSize(width: frame.width, height: .infinity)
        let estimatedSize = sizeThatFits(size)
        
        return Int(estimatedSize.height / (self.font!.lineHeight))
    }
}
