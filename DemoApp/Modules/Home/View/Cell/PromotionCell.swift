//
//  PromotionCell.swift
//  DemoApp
//
//  Created by Alex Oliynyk on 21.10.2024.
//

import UIKit

class PromotionCell: UICollectionViewCell, Reusable {

    var model: Promotion? {
        didSet {
            handleUI()
        }
    }

    let imageLoader = ImageLoader.shared

    private let imageView: UIImageView = {
        let obj = UIImageView()
        obj.contentMode = .scaleAspectFill
        obj.clipsToBounds = true
        obj.translatesAutoresizingMaskIntoConstraints = false
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
        contentView.layoutSubviews()
        imageView.layer.cornerRadius = 16
    }

    private func setup() {
        contentView.backgroundColor = .clear

        contentView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}

extension PromotionCell {
    private func handleUI() {
        guard let model else { return }
        
        imageLoader.loadImage(into: imageView, from: URL(string: model.image))
    }
}
