//
//  CategoryCell.swift
//  DemoApp
//
//  Created by Anton Ivchenko on 22.08.2024.
//

import UIKit

final class CategoryCell: UICollectionViewCell {
    // MARK: - UI
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 16.0
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .lightGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(titleLabel)
        contentView.addSubview(imageView)
        setupConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Overriden methods
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.attributedText = nil
        imageView.image = nil
        imageView.backgroundColor = .clear
    }
    // MARK: - Private methods
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1.0),
            imageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -8.0),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
            titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    // MARK: - Configuration
    func configure(with model: Category) {
        imageView.loadImage(url: model.image, placeholder: .res.home.placeHolder)
        titleLabel.attributedText = model.name?.toAttributed([
            .font(.systemFont(ofSize: 12, weight: .medium)),
            .color(.init(hex: "2B3037")),
            .lineHeightMultiple(1.12)
        ])
    }
}
