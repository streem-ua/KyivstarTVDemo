//
//  UIColor + ext.swift
//  DemoApp
//
//  Created by Alex Oliynyk on 21.10.2024.
//

import Foundation
import UIKit

extension UIColor {
    enum ColorType {
        case background
        case blue
        case black
        case lightBlue
        case darkGray
        case gray
        case lightGray
        case blueBlack
    }

    static func colors(_ colorType: ColorType) -> UIColor {
        var color: UIColor?

        switch colorType {
        case .background:
            color = UIColor(named: "Background")!
        case .blue:
            color = UIColor(named: "Blue")!
        case .black:
            color = UIColor(named: "Black")!
        case .lightBlue:
            color = UIColor(named: "Light Blue")!
        case .darkGray:
            color = UIColor(named: "Dark Gray")!
        case .gray:
            color = UIColor(named: "Gray")!
        case .lightGray:
            color = UIColor(named: "Light Gray")!
        case .blueBlack:
            color = UIColor(named: "Blue Black")!
        }

        //TODO: remove
        guard let color = color else {
            fatalError("Color \(colorType) not found")
        }

        return color
    }
}
