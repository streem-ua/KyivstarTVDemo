//
//  LiveChannelCollectionCell.swift
//  
//
//  Created by Vadim Marchenko on 11.04.2024.
//

import Foundation
import UIKit
import Domain
import Core

final class HomeLiveChannelCollectionCell: CollectionViewCell {
    
    //MARK: - UI Elements
    private let logger = AppLogger.homeFeature
    private var imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.backgroundColor = ColorAssets.placeholder
        view.layer.masksToBounds = true
        return view
    }()
    
    private var lockImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = ImageAssets.lock
        return view
    }()
    
    //MARK: - Lifecycle
    override func prepareForReuse() {
        imageView.kf.cancelDownloadTask()
    }
    override func setupConstraints() {
        contentView.addSubview(imageView)
        contentView.addSubview(lockImageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
            
            lockImageView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 0),
            lockImageView.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 0),
            lockImageView.heightAnchor.constraint(equalToConstant: 32),
            lockImageView.heightAnchor.constraint(equalTo: lockImageView.widthAnchor)
        ])
        
        imageView.layer.cornerRadius = contentView.bounds.width / 2
    }
    
    // MARK: - Public
    func configure(asset: Asset) {
        guard let url = asset.imageURL else {
            logger.error("Could not load image")
            return
        }
        imageView.kf.setImage(with: url)
        lockImageView.isHidden = asset.purchased
    }
}
