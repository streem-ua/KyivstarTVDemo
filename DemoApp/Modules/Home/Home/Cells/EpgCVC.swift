//
//  EpgCVC.swift
//  DemoApp
//
//  Created by Vladyslav Lysenko on 29.08.2024.
//

import UIKit
import Nuke

final class EpgCVC: BaseAssetCVC {
    // MARK: - Constants
    private enum C {
        static let imageHeight: CGFloat = 120
        static let imageWidth: CGFloat = 216
        static let subtitleFont: UIFont = .systemFont(ofSize: 11, weight: .regular)
    }
    
    // MARK: - Views
    private lazy var subtitleLabel: UILabel = {
        var label = UILabel()
        label.font = C.subtitleFont
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    // MARK: - Lifecycles
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubtitleLabel()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Configure
    override func configure(asset: Asset) {
        super.configure(asset: asset)
        subtitleLabel.text = "У записі • Телеканал \(asset.company)"
    }
    
    // MARK: - Setup
    override func setupAssetImageView() {
        super.setupAssetImageView()
        
        NSLayoutConstraint.activate([
            assetImageView.widthAnchor.constraint(equalToConstant: C.imageWidth),
            assetImageView.heightAnchor.constraint(equalToConstant: C.imageHeight),
            assetImageView.topAnchor.constraint(equalTo: topAnchor, constant: .zero),
            assetImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .zero),
            assetImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: .zero)
        ])
    }
    
    override func setupNameLabel() {
        super.setupNameLabel()
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: assetImageView.bottomAnchor, constant: Constants.labelImageSpacing),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .zero),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: .zero),
        ])
        
        nameLabel.numberOfLines = 1
    }
    
    private func setupSubtitleLabel() {
        addSubview(subtitleLabel)
        
        NSLayoutConstraint.activate([
            subtitleLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: .zero),
            subtitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .zero),
            subtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: .zero),
            subtitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: .zero)
        ])
    }
}
