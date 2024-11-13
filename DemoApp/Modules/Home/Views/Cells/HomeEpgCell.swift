//
//  HomeEpgCell.swift
//  DemoApp
//
//  Created by Vlad Tkach on 15.08.2024.
//

import Foundation
import UIKit
import SkeletonView

class HomeEpgCell: UICollectionViewCell {
    static let reuseIdentifier = "HomeEpgCell"
    
    // MARK: - Views
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 12.0
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .lightGray
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12.0, weight: .medium)
        label.textColor = .titleText
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 11)
        label.textColor = .subtitleText
        return label
    }()
    
    let lockedImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(resource: ImageResource.homeVideoLocked))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.isHidden = true
        return imageView
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
        subtitleLabel.text = nil
        imageView.image = nil
        lockedImageView.isHidden = true
    }
    
    // MARK: - Setup
    private func setupViews() {
        isSkeletonable = true
//        imageView.isSkeletonable = true
//        titleLabel.isSkeletonable = true
//        subtitleLabel.isSkeletonable = true
        
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(lockedImageView)
        imageView.addSubview(progressView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            imageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -8.0),
            imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 120/168),
            
            lockedImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8.0),
            lockedImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8.0),
            lockedImageView.widthAnchor.constraint(equalToConstant: 24.0),
            lockedImageView.heightAnchor.constraint(equalToConstant: 24.0),
            
            progressView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            progressView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            progressView.heightAnchor.constraint(equalToConstant: 4.0),
                        
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            titleLabel.bottomAnchor.constraint(equalTo: subtitleLabel.topAnchor, constant: -2.0),
            
            subtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            subtitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
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
        subtitleLabel.attributedText = NSMutableAttributedString(string: "У записі • Телеканал \(model.company)",
                                                              attributes: [NSAttributedString.Key.kern: 0.07])
        lockedImageView.isHidden = model.purchased
        progressView.isHidden = model.progress == 0
        progressView.setProgress(Float(model.progress)/100.0, animated: false)
    }
}
