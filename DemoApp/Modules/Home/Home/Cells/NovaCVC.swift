//
//  MoviesAndSeriesCVC.swift
//  DemoApp
//
//  Created by Vladyslav Lysenko on 29.08.2024.
//

import UIKit
import Nuke

final class NovaCVC: BaseAssetCVC {
    // MARK: - Constants
    private enum C {
        static let imageHeight: CGFloat = 156
        static let imageWidth: CGFloat = 104
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
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: .zero)
        ])
    }
}
