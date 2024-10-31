//
//  SeriesCell.swift
//  DemoApp
//
//  Created by Alex Oliynyk on 21.10.2024.
//

import Foundation
import UIKit

class SeriesCell: UICollectionViewCell, Reusable {

    private let imageLoader = ImageLoader.shared

    var model: Asset? {
        didSet {
            handleUI()
        }
    }

    private let imageView: UIImageView = {
        let obj = UIImageView()
        obj.contentMode = .scaleAspectFill
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.clipsToBounds = true
        return obj
    }()

    private let lockImageView: UIImageView = {
        let obj = UIImageView()
        obj.contentMode = .scaleAspectFill
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.image = UIImage(named: "lock_image")
        return obj
    }()

    private let gradientProgressBar: GradientProgressBar = {
        let obj = GradientProgressBar()
        obj.firstColor = .colors(.blue)
        obj.secondColor = .colors(.lightBlue)
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.backgroundColor = .colors(.darkGray)
        obj.clipsToBounds = true
        return obj
    }()

    private let nameLabel: UILabel = {
        let obj = UILabel()
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.textColor = .colors(.black)
        obj.font = UIFont.systemFont(ofSize: 12)
        obj.numberOfLines = 0
        obj.lineBreakMode = .byWordWrapping
        obj.textAlignment = .left
        return obj
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layoutIfNeeded()
        imageView.layer.cornerRadius = 12
    }

    private func setup() {
        contentView.backgroundColor = .clear

        contentView.addSubview(imageView)
        imageView.addSubview(lockImageView)
        imageView.addSubview(gradientProgressBar)
        contentView.addSubview(nameLabel)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 156),

            lockImageView.heightAnchor.constraint(equalToConstant: 24),
            lockImageView.widthAnchor.constraint(equalToConstant: 24),
            lockImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            lockImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),

            gradientProgressBar.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            gradientProgressBar.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            gradientProgressBar.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            gradientProgressBar.heightAnchor.constraint(equalToConstant: 4),

            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
}

extension SeriesCell {
    private func handleUI() {
        guard let model else { return }

        imageLoader.loadImage(into: imageView, from: URL(string: model.image))
        nameLabel.text = model.name

        let progressValue = CGFloat(model.progress) / 100
        gradientProgressBar.progress = progressValue

        gradientProgressBar.isHidden = progressValue == 0
        lockImageView.isHidden = model.purchased
    }
}
