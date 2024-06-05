//
//  UIButton+Extension.swift
//  DemoApp
//
//  Created by Karpenko Bohdan on 02.06.2024.
//

import UIKit

extension UIButton {
    
    convenience init(
        backGroundImage: UIImage? = nil,
        image: UIImage? = nil,
        backgroundColor: UIColor = .clear,
        title: String? = "",
        titleFont: UIFont = UIFont.systemFont(ofSize: 12),
        titleTextColor: UIColor = .black,
        cornerRadius: Double = 0,
        clipsToBounds: Bool = false,
        target: Any? = nil,
        action: Selector? = nil,
        borderWidth: Double = 0,
        borderColor: UIColor = .clear,
        isHidden: Bool = false,
        isEnabled: Bool = true,
        contentHorizontalAlignment: UIControl.ContentHorizontalAlignment = .center
    ) {
        self.init()
        self.backgroundColor = backgroundColor
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
        setBackgroundImage(backGroundImage, for: .normal)
        setImage(image, for: .normal)
        self.backgroundColor = backgroundColor
        setTitle(title, for: .normal)
        titleLabel?.font = titleFont
        titleLabel?.textColor = titleTextColor
        setTitleColor(titleTextColor, for: .normal)
        layer.cornerRadius = cornerRadius
        self.clipsToBounds = clipsToBounds
        self.setTitleColor(.gray, for: .highlighted)
        imageView?.contentMode = .scaleAspectFit
        self.isHidden = isHidden
        if let action = action {
            addTarget(target, action: action, for: .touchUpInside)
        }
        self.isEnabled = isEnabled
        self.contentHorizontalAlignment = contentHorizontalAlignment
    }
}
