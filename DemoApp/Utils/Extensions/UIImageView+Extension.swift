//
//  UIImageView+Extension.swift
//  DemoApp
//
//  Created by Karpenko Bohdan on 02.06.2024.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    convenience init(
        image: UIImage? = nil,
        contentMode: UIView.ContentMode = .scaleAspectFit,
        cornerRadius: Double = 0,
        clipsToBounds: Bool = true,
        isHidden: Bool = false
    ){
        self.init()
        self.contentMode = contentMode
        self.image = image
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = clipsToBounds
        self.isHidden = isHidden
    }
    
    func setImage(urlSting: String) {
        guard let url = URL(string: urlSting) else {
            image = .image(.placeholder)
            return
        }
        
        kf.indicatorType = .activity
        kf.setImage(with: url) {[weak self] result in
            switch result {
                
            case .success(_):
                break
            case .failure(let error):
                if !error.isTaskCancelled {
                    self?.image = .image(.placeholder)
                }
            }
        }
    }
}
