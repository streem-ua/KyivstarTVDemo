//
//  UIView+Extension.swift
//  DemoApp
//
//  Created by Karpenko Bohdan on 02.06.2024.
//

import UIKit

extension UIView {
    
    var width: Double {
        return frame.size.width
    }
    
    var height: Double {
        return frame.size.height
    }
    
    func addSubviews(_ views: [UIView]) {
        views.forEach {addSubview($0)}
    }
    
    //MARK: - Init
    convenience init(
        backgroundColor: UIColor = .clear,
        cornerRadius: Double = 0,
        isHidden: Bool = false,
        borderColor: UIColor = .clear,
        borderWidth: Double = 0,
        maskedCorners: CACornerMask = [.layerMaxXMinYCorner, .layerMinXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMaxYCorner],
        clipsToBounds: Bool = true
    ) {
        self.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = cornerRadius
        self.isHidden = isHidden
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
        self.layer.maskedCorners = maskedCorners
        self.clipsToBounds = clipsToBounds
    }
    
    func addShadow(shadowOpacity: Float = 1, shadowColor: UIColor = .black, shadowOffset: CGSize = .zero, shadowRadius: Double = 10) {
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOpacity = shadowOpacity
        layer.shadowOffset = shadowOffset
        layer.shadowRadius = shadowRadius
    }
}
