//
//  LiveCell.swift
//  DemoApp
//
//  Created by Ihor on 03.08.2024.
//

import UIKit

class LiveCell: AssetBaseCell {
    static let reuseIdentifier = "LiveCell"
    
    func configure(with model: Asset) {
        guard let url = URL(string: model.image) else {
            imageView.image = UIImage(resource: .lockIcon)
            return
        }
        setImage(for: url)
        
        lockImageView.alpha = model.purchased ? 0.0 : 1.0
    }
    
    override func setupViews() {
        super.setupViews()
        roundImageView()
        contentView.addSubview(lockImageView)
    }
    
    override func setupConstraints() {
        NSLayoutConstraint.activate([
            lockImageView.leadingAnchor.constraint(equalTo: imageView.safeAreaLayoutGuide.leadingAnchor, constant: 5.0),
            lockImageView.topAnchor.constraint(equalTo: imageView.safeAreaLayoutGuide.topAnchor, constant: 5.0),
            
            imageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func roundImageView() {
        imageView.layer.cornerRadius = bounds.height / 2.0
        imageView.layer.masksToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        roundImageView()
    }
}

