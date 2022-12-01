//
//  ReusableProtocol.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/12/02.
//

import UIKit

protocol ReusableViewProtocol: AnyObject {
    static var identifier: String{ get }
}

extension UIViewController: ReusableViewProtocol {
    static var identifier: String{
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableViewProtocol {
    static var identifier: String{
        return String(describing: self)
    }
}

extension UICollectionReusableView: ReusableViewProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UITableViewHeaderFooterView: ReusableViewProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}
