//
//  UIImageView+Kingfisher.swift
//  DemoApp
//
//  Created by Nik Dub on 11.07.2024.
//

import UIKit
import Kingfisher

extension UIImageView {
    func loadAndSetImage(_ stringURL: String?) {
        guard let url = URL(string: stringURL ?? "") else {
            return
        }
        self.kf.setImage(with: url, placeholder: UIImage(systemName: "photo"))
    }
}
