//
//  PromotionCell.swift
//  DemoApp
//
//  Created by Ihor on 03.08.2024.
//

import UIKit

final class PromotionCell: ImageCollectionViewCell {
    static let reuseIdentifier = "PromotionCell"
    
    private var gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [
            UIColor.clear.cgColor,
            UIColor.black.withAlphaComponent(0.5).cgColor
        ]
        layer.locations = [0.0, 1.0]
        layer.cornerRadius = 8
        layer.masksToBounds = true
        return layer
    }()
    
    override func setupViews() {
        super.setupViews()
        contentView.layer.addSublayer(gradientLayer)
        setGradientSize()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setGradientSize()
    }
    
    private func setGradientSize() {
        gradientLayer.frame = CGRect(
            origin: CGPoint(x: 0, y: 0.5*bounds.height),
            size: CGSize(width: bounds.width, height: 0.5*bounds.height)
        )
    }
    
    override func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func configure(with model: Promotion) {
        guard let url = URL(string: model.image) else {
            imageView.image = UIImage(resource: .lockIcon)
            return
        }
        setImage(for: url)
    }
}
