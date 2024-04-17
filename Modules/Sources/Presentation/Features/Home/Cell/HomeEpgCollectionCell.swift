//
//  EpgCollectionCell.swift
//
//
//  Created by Vadim Marchenko on 11.04.2024.
//

import Foundation
import Domain

final class HomeEpgCollectionCell: HomeContentBaseCollectionCell {
    
    
    override func setupConstraints() {
        super.setupConstraints()
    
        imageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 120/216).isActive = true
        subtitleLabel.isHidden = false
    }
    
    override func configure(asset: Asset) {
        super.configure(asset: asset)
        subtitleLabel.text = "У записі • \(asset.company)"
    }
}
