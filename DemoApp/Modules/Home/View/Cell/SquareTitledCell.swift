//
//  SquareTitledCell.swift
//  DemoApp
//
//  Created by Nik Dub on 09.07.2024.
//

import UIKit

class SquareTitledCell: ConfigurableCell {
    private lazy var thumbImageView: UIImageView = {
        $0.image = UIImage(named: "square")
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    let titleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError("not implemented")
    }
    
    override func configure(with model: CellItem) {
        thumbImageView.loadAndSetImage(model.imageURL)
        titleLabel.text = model.title
    }
    
    private func configure() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(thumbImageView)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.numberOfLines = 1
        thumbImageView.layer.cornerRadius = 16
        thumbImageView.clipsToBounds = true
        NSLayoutConstraint.activate([
            thumbImageView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor
            ),
            thumbImageView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor
            ),
            thumbImageView.topAnchor.constraint(
                equalTo: contentView.topAnchor
            ),
            thumbImageView.heightAnchor.constraint(
                equalTo: thumbImageView.widthAnchor
            ),
            titleLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor
            ),
            titleLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor
            ),
            titleLabel.topAnchor.constraint(
                equalTo: thumbImageView.bottomAnchor,
                constant: 4
            ),
            titleLabel.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -4
            )
        ])
    }
}
