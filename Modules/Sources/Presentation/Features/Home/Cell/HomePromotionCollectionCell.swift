//
//  PromotionCollectionCell.swift
//
//
//  Created by Vadim Marchenko on 11.04.2024.
//

import Foundation
import UIKit
import Kingfisher
import Core

final class HomePromotionCollectionCell: CollectionViewCell {
    
    // MARK: - UI Elements
    private let logger = AppLogger.homeFeature
    private var imageView: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = HomeConstant.Cell.cornerRadius
        view.backgroundColor = ColorAssets.action?.withAlphaComponent(0.2)
        return view
    }()
    
    // MARK: - Lifecycle
    override func prepareForReuse() {
        imageView.kf.cancelDownloadTask()
    }
    
    override func setupConstraints() {
        contentView.addSubview(imageView)
       
        NSLayoutConstraint.activate( [
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
        ])
    }
    
    // MARK: - Public
    func configure(imageString: String) {
        guard let url = URL(string: imageString) else {
            logger.error("Could not load image \(imageString)")
            return
        }
        imageView.kf.setImage(with: url)
    }
}
