//
//  AssetCell.swift
//  DemoApp
//
//  Created by Nik Dub on 10.07.2024.
//

import UIKit

class AssetCell: ConfigurableCell {
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
    
    private lazy var titleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError("not implemented")
    }
    
    override func configure(with model: CellItem) {
        titleLabel.text = model.title
        progressBar.progress = model.progress ?? 0
        lockImageView.isHidden = !(model.purchased ?? false)
    }
    
    private func configure() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(thumbImageView)
        contentView.addSubview(lockImageView)
        thumbImageView.addSubview(progressBar)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.numberOfLines = 2
        thumbImageView.layer.cornerRadius = 16
        thumbImageView.clipsToBounds = true
        titleLabel.text = "not implemented"
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
            
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.topAnchor.constraint(
                equalTo: thumbImageView.bottomAnchor,
                constant: 8
            ),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
        ])
    }
}
