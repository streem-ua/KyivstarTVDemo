//
//  Font.swift
//  DemoApp
//
//  Created by Karpenko Bohdan on 02.06.2024.
//

import UIKit

enum Font: String {
    case regular = "SFProText-Regular"
    case light = "SFProText-Light"
    case semibold = "SFProText-Semibold"
    case bold = "SFProText-Bold"
    
    func font(size: Double) -> UIFont {
        return UIFont(name: rawValue, size: size) ?? UIFont.systemFont(ofSize: size)
        
    }
}

