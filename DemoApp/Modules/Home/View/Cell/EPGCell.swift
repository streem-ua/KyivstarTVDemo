//
//  EPGCell.swift
//  DemoApp
//
//  Created by Nik Dub on 10.07.2024.
//

import UIKit

class EPGCell: ConfigurableCell {
    private lazy var thumbImageView: UIImageView = {
        $0.image = UIImage(named: "panorama")
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
    private lazy var descriptionLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError("not implemented")
    }
    
    private func configure() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(thumbImageView)
        contentView.addSubview(lockImageView)
        thumbImageView.addSubview(progressBar)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.numberOfLines = 2
        thumbImageView.layer.cornerRadius = 16
        thumbImageView.clipsToBounds = true
        titleLabel.text = "Таємниці космосу"
        descriptionLabel.text = "У записі • Телеканал Discovery"
        descriptionLabel.textColor = .lightGray
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
            
            titleLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor
            ),
            titleLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor
            ),
            titleLabel.topAnchor.constraint(
                equalTo: thumbImageView.bottomAnchor,
                constant: 8
            ),
//            titleLabel.bottomAnchor.constraint(
//                equalTo: bottomAnchor,
//                constant: -8
//            ),
            descriptionLabel.leadingAnchor.constraint(
                equalTo: titleLabel.leadingAnchor
            ),
            descriptionLabel.trailingAnchor.constraint(
                equalTo: titleLabel.trailingAnchor
            ),
            descriptionLabel.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: 2
            ),
            descriptionLabel.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -2
            ),
        ])
    }
}
