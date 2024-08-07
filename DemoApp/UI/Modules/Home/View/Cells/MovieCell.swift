//
//  MovieCell.swift
//  DemoApp
//
//  Created by Ihor on 03.08.2024.
//

import UIKit

class MovieCell: AssetBaseCell {
    static let reuseIdentifier = "MovieCell"
    
    func configure(with model: Asset) {
        guard let url = URL(string: model.image) else {
            imageView.image = UIImage(resource: .lockIcon)
            return
        }
        setImage(for: url)
        titleLabel.text = model.name
        
        lockImageView.alpha = model.purchased ? 0.0 : 1.0
        progressView.setProgress(Float(model.progress)/100.0, animated: false)
        progressView.alpha = model.progress > 0 ? 1.0 : 0.0
    }
    
    override func setupViews() {
        super.setupViews()
        contentView.addSubview(titleLabel)
        imageView.addSubview(lockImageView)
        imageView.addSubview(progressView)
    }
    
    override func setupConstraints() {
        NSLayoutConstraint.activate([
            lockImageView.leadingAnchor.constraint(equalTo: imageView.safeAreaLayoutGuide.leadingAnchor, constant: 5.0),
            lockImageView.topAnchor.constraint(equalTo: imageView.safeAreaLayoutGuide.topAnchor, constant: 5.0),
            
            progressView.leadingAnchor.constraint(equalTo: imageView.safeAreaLayoutGuide.leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: imageView.safeAreaLayoutGuide.trailingAnchor),
            progressView.bottomAnchor.constraint(equalTo: imageView.safeAreaLayoutGuide.bottomAnchor),
            progressView.heightAnchor.constraint(equalToConstant: 4.0),
            
            imageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),

            imageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
