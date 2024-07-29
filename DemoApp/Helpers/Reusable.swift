//
//  Reusable.swift
//  DemoApp
//
//  Created by Denys Zaiakin on 28.03.2024.
//

import UIKit

protocol Reusable: AnyObject {
    static var reuseId: String { get }
}

extension Reusable where Self: UICollectionViewCell {
    static var reuseId: String {
        return String(describing: self)
    }
}

extension Reusable where Self: UICollectionReusableView {
    static var reuseId: String {
        return String(describing: self)
    }
}

