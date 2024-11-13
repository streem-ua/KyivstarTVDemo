//
//  CategoryCVC.swift
//  DemoApp
//
//  Created by Vladyslav Lysenko on 29.08.2024.
//

import UIKit
import Nuke

final class CategoryCVC: UICollectionViewCell {
    // MARK: - Views
    private lazy var imageView: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = Constants.cornerRadius
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        var label = UILabel()
        label.font = Constants.nameFont
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    // MARK: - Life cycles
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageView()
        setupNameLabel()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Configure
    func configure(category: Category) {
        nameLabel.text = category.name
        loadImage(url: category.image)
    }
    
    // MARK: - Setup
    private func setupImageView() {
        addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: Constants.imageSide),
            imageView.heightAnchor.constraint(equalToConstant: Constants.imageSide),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: .zero),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .zero),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: .zero)
        ])
    }
    
    private func setupNameLabel() {
        addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Constants.labelImageSpacing),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .zero),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: .zero),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: .zero)
        ])
    }
    
    // MARK: - Private Methods
    private func loadImage(url: URL) {
        ImagePipeline.shared.loadImage(with: url) { [weak self] in
            guard let self, case .success(let response) = $0 else { return }
            self.imageView.image = response.image
        }
    }
}
