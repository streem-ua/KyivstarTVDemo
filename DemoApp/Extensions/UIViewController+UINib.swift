//
//  UIViewController+UINib.swift
//  DemoApp
//
//  Created by Nik Dub on 06.07.2024.
//

import UIKit

extension UIViewController {
    static func instantiateFromNib() -> Self {
        return Self(nibName: Self.identifier, bundle: nil)
    }
}
