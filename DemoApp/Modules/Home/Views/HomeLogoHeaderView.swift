//
//  HomeLogoHeaderView.swift
//  DemoApp
//
//  Created by Vlad Tkach on 15.08.2024.
//

import Foundation
import UIKit
import SkeletonView

class HomeLogoHeaderView: UICollectionReusableView {
    static let reuseIdentifier = "HomeLogoHeaderView"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        setupViews()
        setupConstraint()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
    }
    
    // MARK: - Setup
    private func setupViews() {
        imageView.isSkeletonable = true
    }
    
    private func setupConstraint() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    // MARK: - Configuration
    func configure(image: UIImage) {
        imageView.image = image
    }
}
