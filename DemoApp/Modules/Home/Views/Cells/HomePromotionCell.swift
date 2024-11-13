//
//  HomePromotionCell.swift
//  DemoApp
//
//  Created by Vlad Tkach on 15.08.2024.
//

import Foundation
import UIKit
import SDWebImage
import SkeletonView

final class HomePromotionCell: UICollectionViewCell {
    static let reuseIdentifier = "HomePromotionCell"
    // MARK: - Views
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 16.0
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private var gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [
            UIColor.clear.cgColor,
            UIColor.black.withAlphaComponent(0.5).cgColor
        ]
        layer.locations = [0.0, 1.0]
        layer.isHidden = true
        return layer
    }()
    
    // MARK: - Initialisation
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
        setupGradientLayerSize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        imageView.backgroundColor = .clear
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupGradientLayerSize()
    }
    
    // MARK: - Setup
    
    private func setupGradientLayerSize() {
        let gradientLayerHeight = 18.0 //same as section footer
        
        gradientLayer.frame = CGRect(
            origin: CGPoint(x: 0, y: bounds.height - gradientLayerHeight),
            size: CGSize(width: bounds.width, height: gradientLayerHeight)
        )
    }
    
    private func setupViews() {
        isSkeletonable = true
        
        imageView.layer.addSublayer(gradientLayer)
        contentView.addSubview(imageView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    // MARK: - Public configuration
    func configure(with model: PromotionsResponse.Promotion) {
        guard let url = URL(string: model.image) else {
            imageView.backgroundColor = .lightGray
            return
        }
        imageView.sd_setImage(with: url, placeholderImage: UIImage(systemName: "photo"))
        gradientLayer.isHidden = false
    }

}
