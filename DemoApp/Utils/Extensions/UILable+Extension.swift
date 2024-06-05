//
//  UILable+Extension.swift
//  DemoApp
//
//  Created by Karpenko Bohdan on 02.06.2024.
//

import UIKit

extension UILabel {
    
    //MARK: - Convenience Init
    
    convenience init(
        font: UIFont = UIFont.systemFont(ofSize: 12),
        textColor: UIColor = .black,
        textAlignment: NSTextAlignment = .left,
        text: String? = nil,
        numberOfLines: Int = 1,
        adjustsFontSizeToFitWidth: Bool = false,
        minimumScaleFactor: Double = 0.5,
        isHidden: Bool = false
    ){
        self.init()
        self.font = font
        self.textColor = textColor
        self.numberOfLines = numberOfLines
        self.text = text
        self.textAlignment = textAlignment
        self.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth
        self.minimumScaleFactor = minimumScaleFactor
        self.isHidden = isHidden
    }
}

