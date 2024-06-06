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
}
