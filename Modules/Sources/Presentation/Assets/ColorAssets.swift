//
//  ColorAssets.swift
//
//
//  Created by Vadim Marchenko on 10.04.2024.
//

import Foundation
import UIKit

enum ColorAssets {
    static var text: UIColor {
        guard let color = UIColor(named: "dark") else {
            fatalError("Color not found")
        }
        return color
    }
    
    static var hint: UIColor {
        guard let color = UIColor(named: "gray") else {
            fatalError("Color not found")
        }
        return color
    }
    
    static var action: UIColor {
        guard let color = UIColor(named: "blue") else {
            fatalError("Color not found")
        }
        return color
    }
    
    static var actionLight: UIColor {
        guard let color = UIColor(named: "blue") else {
            fatalError("Color not found")
        }
        return color
    }
    
    static var borderBlue: UIColor {
        guard let color = UIColor(named: "border-blue") else {
            fatalError("Color not found")
        }
        return color
    }
    
    static var accGray: UIColor {
        guard let color = UIColor(named: "gray-accent") else {
            fatalError("Color not found")
        }
        return color
    }
    
    static var grayLight: UIColor {
        guard let color = UIColor(named: "gray-light") else {
            fatalError("Color not found")
        }
        return color
    }
    
    static var placeholder: UIColor {
        action.withAlphaComponent(0.2)
    }
}
