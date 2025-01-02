//
//  UIImageView+Extensions.swift
//  DemoApp
//
//  Created by Bogdan Akopov on 02.01.2025.
//

import UIKit

extension UIImageView {
    func setImage(from url: URL, placeholder: UIImage? = nil) {
        ImageLoader.shared.loadImage(for: self, from: url, placeholder: placeholder)
    }

    func cancelImageLoad() {
        ImageLoader.shared.cancelLoad(for: self)
    }
}
