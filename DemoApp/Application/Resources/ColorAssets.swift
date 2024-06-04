//
//  ColorAssets.swift
//  DemoApp
//
//  Created by Karpenko Bohdan on 04.06.2024.
//

import UIKit

enum ColorAssets: String {
    case grayDark = "gray-dark"
    case blue = "blue"
    case blueLight = "blue-light"
    
    func color() -> UIColor {
        UIColor(named: rawValue) ?? UIColor()
    }
}
