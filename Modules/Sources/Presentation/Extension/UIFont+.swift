//
//  File.swift
//
//
//  Created by Vadim Marchenko on 12.04.2024.
//

import Foundation
import UIKit

extension UIFont {
    static func robotoRegular(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "Roboto-Regular", size: size) else {
            fatalError("Could not load font")
        }
        return font
    }
}
