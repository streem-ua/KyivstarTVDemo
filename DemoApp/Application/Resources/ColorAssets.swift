//
//  ColorAssets.swift
//  DemoApp
//
//  Created by Karpenko Bohdan on 04.06.2024.
//

import UIKit
import SwiftUI

enum ColorAssets: String {
    case grayDark = "gray-dark"
    case blue = "blue"
    case blueLight = "blue-light"
    case grayLight = "gray-light"
    case white = "white"
    
    func color() -> UIColor {
        UIColor(named: rawValue) ?? UIColor()
    }
    
    func color() -> Color {
        Color(asset: self)
    }
}
