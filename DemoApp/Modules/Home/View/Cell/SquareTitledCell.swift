//
//  SquareTitledCell.swift
//  DemoApp
//
//  Created by Nik Dub on 09.07.2024.
//

import UIKit

class SquareTitledCell: UICollectionViewCell {
    private lazy var thumbImageView: UIImageView = {
        $0.image = UIImage(named: "square")
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError("not implemented")
    }
    
    private func configure() {
        contentView.addSubview(label)
        contentView.addSubview(thumbImageView)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 2
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
            label.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor
            ),
            label.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor
            ),
            label.topAnchor.constraint(
                equalTo: thumbImageView.bottomAnchor,
                constant: 10
            ),
        ])
    }
}
