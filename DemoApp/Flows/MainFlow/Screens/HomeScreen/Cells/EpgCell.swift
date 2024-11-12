//
//  EpgCell.swift
//  DemoApp
//
//  Created by Anton Ivchenko on 22.08.2024.
//

import UIKit

final class EpgCell: UICollectionViewCell {
    // MARK: - UI
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 12
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .lightGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let lockedImageView: UIImageView = {
        let imageView = UIImageView(image: .res.home.lockedAsset)
        imageView.contentMode = .scaleAspectFit
        imageView.isHidden = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private let progressView: UIProgressView = {
        let view = UIProgressView(progressViewStyle: .bar)
        view.trackTintColor = .init(hex: "2B3037")
        view.progressTintColor = .blue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        titleLabel.text = nil
        subtitleLabel.text = nil
        lockedImageView.isHidden = true
        imageView.backgroundColor = .clear
    }
    // MARK: - Private methods
    private func setupViews() {
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
            imageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -8),
            imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 120/168),
            lockedImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            lockedImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            lockedImageView.widthAnchor.constraint(equalToConstant: 24),
            lockedImageView.heightAnchor.constraint(equalToConstant: 24),
            progressView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            progressView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            progressView.heightAnchor.constraint(equalToConstant: 4),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: subtitleLabel.topAnchor, constant: -2),
            subtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            subtitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    // MARK: - Configuration
    func configure(with model: ContentGroup.Asset) {
        let progress = Float(model.progress ?? 0)/100
        imageView.loadImage(url: model.image, placeholder: .res.home.placeHolder)
        lockedImageView.isHidden = model.purchased ?? false
        progressView.isHidden = model.progress == 0
        progressView.setProgress(progress, animated: false)
        titleLabel.attributedText = model.name?.toAttributed([
            .color(.init(hex: "2B3037")),
            .font(.systemFont(ofSize: 12, weight: .medium)),
            .lineHeightMultiple(1.12)
        ])
        subtitleLabel.attributedText = model.epgSubtitle.toAttributed([
            .color(.init(hex: "808890")),
            .font(.systemFont(ofSize: 11, weight: .regular)),
            .lineHeightMultiple(1.22)
        ])
    }
}
