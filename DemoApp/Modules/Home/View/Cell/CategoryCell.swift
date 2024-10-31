//
//  CategoryCell.swift
//  DemoApp
//
//  Created by Alex Oliynyk on 21.10.2024.
//

import UIKit

class CategoryCell: UICollectionViewCell, Reusable {

    private let imageLoader = ImageLoader.shared

    var model: Category? {
        didSet {
            handleUI()
        }
    }

    private let imageView: UIImageView = {
        let obj = UIImageView()
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.clipsToBounds = true
        obj.contentMode = .scaleAspectFill
        return obj
    }()

    private let nameLabel: UILabel = {
        let obj = UILabel()
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.textColor = .colors(.black)
        obj.font = UIFont.systemFont(ofSize: 12)
        obj.numberOfLines = 0
        obj.lineBreakMode = .byWordWrapping
        obj.textAlignment = .center
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
        imageView.layer.cornerRadius = 16
    }

    private func setup() {
        contentView.backgroundColor = .clear

        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 104),

            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8)
        ])
    }
}

extension CategoryCell {
    private func handleUI() {
        guard let model else { return }
        
        imageLoader.loadImage(into: imageView, from: URL(string: model.image))

        nameLabel.text = model.name
    }
}

