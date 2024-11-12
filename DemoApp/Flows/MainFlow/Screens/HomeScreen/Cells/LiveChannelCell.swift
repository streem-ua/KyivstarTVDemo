//
//  LiveChannelCell.swift
//  DemoApp
//
//  Created by Anton Ivchenko on 22.08.2024.
//

import UIKit

final class LiveChannelCell: UICollectionViewCell {
    // MARK: - UI
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .lightGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private let lockedImageView: UIImageView = {
        let imageView = UIImageView(image: .res.home.lockedAsset)
        imageView.contentMode = .scaleAspectFit
        imageView.isHidden = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Overriden methods
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.layer.cornerRadius = contentView.bounds.height / 2
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        lockedImageView.isHidden = true
        imageView.backgroundColor = .clear
    }
    // MARK: - Private methods
    private func setupViews() {
        contentView.addSubview(imageView)
        contentView.addSubview(lockedImageView)
    }
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor),
            lockedImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            lockedImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            lockedImageView.widthAnchor.constraint(equalToConstant: 32),
            lockedImageView.heightAnchor.constraint(equalToConstant: 32),
        ])
    }
    // MARK: - Configuration
    func configure(with model: ContentGroup.Asset) {
        imageView.loadImage(url: model.image, placeholder: .res.home.placeHolder)
        lockedImageView.isHidden = model.purchased ?? false
    }
}
