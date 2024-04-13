//
//  CategoryCollectionCell.swift
//
//
//  Created by Vadim Marchenko on 11.04.2024.
//

import Foundation
import UIKit
import Kingfisher
import Core

final class HomeCategoryCollectionCell: CollectionViewCell {
    
    //MARK: - UI Elements
    private let logger = AppLogger.homeFeature
    private var imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = HomeConstant.Cell.cornerRadius
        view.backgroundColor = ColorAssets.action?.withAlphaComponent(0.2)
        view.layer.masksToBounds = true
        return view
    }()
    
    private var titleLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.robotoRegular(size: 12)
        view.textColor = ColorAssets.text
        view.textAlignment = .center
        return view
    }()
    
    //MARK: - Lifecycle
    override func prepareForReuse() {
        imageView.kf.cancelDownloadTask()
    }
    override func setupConstraints() {
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: HomeConstant.Cell.smallTextPadding),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
        ])
    }
    
    // MARK: - Public
    func configure(imageString: String, title: String) {
        guard let url = URL(string: imageString) else {
            logger.error("Could not load image \(imageString)")
            return
        }
        imageView.kf.setImage(with: url)
        titleLabel.text = title
    }
}
