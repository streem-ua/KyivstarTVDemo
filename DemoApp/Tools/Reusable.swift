//
//  Reusable.swift
//  DemoApp
//
//  Created by Nik Dub on 06.07.2024.
//

import UIKit

protocol Reusable {}

extension Reusable {
    static var identifier: String {
        return String(describing: self)
    }
}

extension Reusable where Self: UITableViewCell {
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: Bundle(for: self))
    }
}

extension Reusable where Self: UICollectionViewCell {
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: Bundle(for: self))
    }
}

extension Reusable where Self: UICollectionReusableView {
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: Bundle(for: self))
    }
}

extension UITableViewCell: Reusable {}
extension UICollectionReusableView: Reusable {}
extension UIViewController: Reusable {}
