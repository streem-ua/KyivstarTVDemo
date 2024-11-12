//
//  PromotionCell.swift
//  DemoApp
//
//  Created by Anton Ivchenko on 21.08.2024.
//

import UIKit

final class PromotionCell: UICollectionViewCell {
    // MARK: - UI
    private let promotionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.backgroundColor = .lightGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(promotionImageView)
        setupConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Overriden methods
    override func prepareForReuse() {
        super.prepareForReuse()
        promotionImageView.image = nil
        promotionImageView.backgroundColor = .clear
    }
    // MARK: - Private methods
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            promotionImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            promotionImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            promotionImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            promotionImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    // MARK: - Configuration
    func configure(with promotion: Promotion) {
        promotionImageView.loadImage(url: promotion.image, placeholder: .res.home.placeHolder)
    }
}
