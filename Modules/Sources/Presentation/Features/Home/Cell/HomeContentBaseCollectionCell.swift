//
//  HomeContentBaseCollectionCell.swift
//
//
//  Created by Vadim Marchenko on 12.04.2024.
//

import Foundation
import UIKit
import Domain
import Core

class HomeContentBaseCollectionCell: CollectionViewCell {
    
    //MARK: - UI Elements
    private let logger = AppLogger.homeFeature
    var imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = HomeConstant.Cell.cornerRadius
        view.backgroundColor = ColorAssets.placeholder
        view.layer.masksToBounds = true
        return view
    }()
    
    private var titleLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.robotoRegular(size: 12)
        view.textColor = ColorAssets.text
        view.textAlignment = .left
        view.numberOfLines = 2
        return view
    }()
    
    private var lockImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = ImageAssets.lock
        return view
    }()
 
    private var progressView: UIProgressView = {
        let view = UIProgressView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.progressTintColor = ColorAssets.action
        view.trackTintColor = ColorAssets.text
        view.layer.masksToBounds = true
        return view
    }()
    
    var subtitleLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.robotoRegular(size: 11)
        view.textColor = ColorAssets.hint
        view.textAlignment = .left
        view.isHidden = true
        return view
    }()
    
    //MARK: - Lifecycle
    override func prepareForReuse() {
        imageView.kf.cancelDownloadTask()
    }
    
    override func setupConstraints() {

        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(lockImageView)
        contentView.addSubview(subtitleLabel)
        imageView.addSubview(progressView)
        
        NSLayoutConstraint.activate([
        
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: HomeConstant.Cell.smallTextPadding),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            lockImageView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 8),
            lockImageView.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 8),
            lockImageView.heightAnchor.constraint(equalToConstant: 24),
            lockImageView.heightAnchor.constraint(equalTo: lockImageView.widthAnchor),
        
            progressView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            progressView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            progressView.heightAnchor.constraint(equalToConstant: 4),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            subtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
        
    }
    
    // MARK: - Public
    func configure(asset: Asset) {
        guard let url = asset.imageURL else {
            logger.error("Could not load image")
            return
        }
        imageView.kf.setImage(with: url)
        titleLabel.text = asset.name
        lockImageView.isHidden = asset.purchased
        if asset.progress > 0 {
            progressView.isHidden = false
            let progress = Float(asset.progress) * 0.01
            progressView.setProgress(progress, animated: false)
        } else {
            progressView.isHidden = true
        }
    }
}
