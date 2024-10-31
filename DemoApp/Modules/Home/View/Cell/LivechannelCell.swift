//
//  LivechannelCell.swift
//  DemoApp
//
//  Created by Alex Oliynyk on 21.10.2024.
//

import Foundation
import UIKit

class LivechannelCell: UICollectionViewCell, Reusable {

    private let imageLoader = ImageLoader.shared

    var model: Asset? {
        didSet {
            handleUI()
        }
    }

    private let containerView: UIView = {
        let obj = UIView()
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.backgroundColor = .colors(.darkGray)
        return obj
    }()

    private let lockImageView: UIImageView = {
        let obj = UIImageView()
        obj.contentMode = .scaleAspectFill
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.image = UIImage(named: "lock_image")
        return obj
    }()

    private let imageView: UIImageView = {
        let obj = UIImageView()
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.contentMode = .scaleAspectFill
        obj.clipsToBounds = true
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

        containerView.layer.cornerRadius = containerView.bounds.height/2
    }

    private func setup() {
        contentView.backgroundColor = .clear

        contentView.addSubview(containerView)
        contentView.addSubview(lockImageView)
        containerView.addSubview(imageView)

        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            lockImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            lockImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            lockImageView.heightAnchor.constraint(equalToConstant: 32),
            lockImageView.widthAnchor.constraint(equalToConstant: 32),

            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 60),
            imageView.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
}

extension LivechannelCell {
    private func handleUI() {
        guard let model else { return }

        imageLoader.loadImage(into: imageView, from: URL(string: model.image))
    }
}

