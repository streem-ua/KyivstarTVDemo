//
//  AssetCell.swift
//  DemoApp
//
//  Created by Nik Dub on 10.07.2024.
//

import UIKit

class AssetCell: UICollectionViewCell {
    private lazy var thumbImageView: UIImageView = {
        $0.image = UIImage(named: "rectangle")
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    private lazy var lockImageView: UIImageView = {
        $0.image = UIImage(named: "lock")
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    private lazy var progressBar: UIProgressView = {
        $0.progress = 0.5
        $0.trackTintColor = UIColor(named: "text_body")
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIProgressView())
    
    let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError("not implemented")
    }
    
    private func configure() {
        contentView.addSubview(label)
        contentView.addSubview(thumbImageView)
        contentView.addSubview(lockImageView)
        thumbImageView.addSubview(progressBar)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 2
        thumbImageView.layer.cornerRadius = 16
        thumbImageView.clipsToBounds = true
        label.text = "not implemented"
        NSLayoutConstraint.activate([
            thumbImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            thumbImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            thumbImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            
            progressBar.leadingAnchor.constraint(equalTo: thumbImageView.leadingAnchor),
            progressBar.trailingAnchor.constraint(equalTo: thumbImageView.trailingAnchor),
            progressBar.bottomAnchor.constraint(equalTo: thumbImageView.bottomAnchor),
            
            lockImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            lockImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            lockImageView.heightAnchor.constraint(equalTo: lockImageView.widthAnchor),
            lockImageView.widthAnchor.constraint(equalToConstant: 24),
            
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            label.topAnchor.constraint(
                equalTo: thumbImageView.bottomAnchor,
                constant: 8
            ),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
        ])
    }
}
