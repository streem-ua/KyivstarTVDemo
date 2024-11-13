//
//  HomeMovieSeriesCell.swift
//  DemoApp
//
//  Created by Vlad Tkach on 15.08.2024.
//

import Foundation
import UIKit
import SkeletonView

class HomeMovieSeriesCell: UICollectionViewCell {
    static let reuseIdentifier = "HomeMovieSeriesCell"
    
    // MARK: - Views
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 12.0
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .lightGray

        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 12.0, weight: .medium)
        label.textColor = .titleText
        return label
    }()
    
    let lockedImageView: UIImageView = {
        let lockView = UIImageView(image: UIImage(named: "home.video_locked"))
        lockView.translatesAutoresizingMaskIntoConstraints = false
        lockView.contentMode = .scaleAspectFit
        lockView.isHidden = true
        return lockView
    }()
    
    let progressView: UIProgressView = {
        let view = UIProgressView(progressViewStyle: .bar)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.trackTintColor = UIColor.lightGray
        view.progressTintColor = UIColor.blue
        return view
    }()
    
    // MARK: - Initialisation
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        imageView.image = nil
        lockedImageView.isHidden = true
        imageView.backgroundColor = .clear
    }
    
    // MARK: - Setup
    private func setupViews() {
        isSkeletonable = true
//        imageView.isSkeletonable = true
//        titleLabel.isSkeletonable = true
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(imageView)
        imageView.addSubview(lockedImageView)
        imageView.addSubview(progressView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor),
            
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 156/104),

            imageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -8.0),
            
            lockedImageView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 8.0),
            lockedImageView.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 8.0),
            lockedImageView.widthAnchor.constraint(equalToConstant: 24.0),
            lockedImageView.heightAnchor.constraint(equalToConstant: 24.0),
            
            progressView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            progressView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            progressView.heightAnchor.constraint(equalToConstant: 4.0),
        ])
    }
    
    // MARK: - Public configuration
    func configure(with model: ContentGroup.Asset) {
        guard let url = URL(string: model.image) else {
            imageView.backgroundColor = .lightGray
            return
        }
        imageView.sd_setImage(with: url, placeholderImage: UIImage(systemName: "photo"))
        titleLabel.text = model.name
        
        lockedImageView.isHidden = model.purchased
        progressView.setProgress(Float(model.progress)/100.0, animated: false)
        progressView.isHidden = model.progress == 0
    }
}
