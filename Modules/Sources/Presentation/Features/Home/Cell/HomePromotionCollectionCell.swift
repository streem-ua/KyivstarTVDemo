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
        view.backgroundColor = ColorAssets.placeholder
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
    func configure(imageURL: URL?) {
        guard let url = imageURL else {
            logger.error("Could not load image")
            return
        }
        imageView.kf.setImage(with: url)
    }
}
