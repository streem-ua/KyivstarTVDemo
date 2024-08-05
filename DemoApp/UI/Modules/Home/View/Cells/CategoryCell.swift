//
//  CategoryCell.swift
//  DemoApp
//
//  Created by Ihor on 03.08.2024.
//

import UIKit

class CategoryCell: AssetBaseCell {
    
    static let reuseIdentifier = "CategoryCell"
    
    func configure(with model: Category) {
        guard let url = URL(string: model.image) else {
            imageView.image = UIImage(resource: .lockIcon)
            return
        }
        setImage(for: url)
        titleLabel.text = model.name
    }
    
    override func setupViews() {
        super.setupViews()
        contentView.addSubview(titleLabel)
    }
    
    override func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),

            imageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
