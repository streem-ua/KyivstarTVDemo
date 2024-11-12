//
//  LockView.swift
//  DemoApp
//
//  Created by Denys Zaiakin on 28.03.2024.
//

import UIKit

class LockView: UICollectionReusableView, Reusable {
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.image = ImageAssets.lock.image
        imageView.tintColor = AssetColor.whiteIndicator.uiColor
        return imageView
    }()

    private let imageContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = AssetColor.darkerGray.uiColor
        view.layer.borderColor = AssetColor.textSecondary.uiColor.cgColor
        view.layer.borderWidth = 1.5
        view.layer.addRoundedShadow(color: AssetColor.darkerGray.uiColor)
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageContainerView()
        setupImage()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        imageContainerView.layer.cornerRadius = bounds.height / 2
    }

    private func setupImageContainerView() {
        addSubview(imageContainerView)
        NSLayoutConstraint.activate([
            imageContainerView.topAnchor.constraint(equalTo: topAnchor),
            imageContainerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageContainerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageContainerView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    private func setupImage() {
        imageContainerView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1),
            imageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5)
        ])
    }
}

