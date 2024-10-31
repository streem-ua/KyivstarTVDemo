//
//  UIFont + ext.swift
//  DemoApp
//
//  Created by Alex Oliynyk on 23.10.2024.
//

import UIKit

extension UIFont {
    enum Roboto {
        case regular

        var value: String {
            switch self {
            case .regular:
                return "Roboto-Regular"
            }
        }
    }

    static func roboto(_ type: Roboto, size: CGFloat) -> UIFont {
        return UIFont(name: type.value, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
