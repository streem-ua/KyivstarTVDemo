//
//  BaseAssetCVC.swift
//  DemoApp
//
//  Created by Vladyslav Lysenko on 29.08.2024.
//

import UIKit
import Nuke

class BaseAssetCVC: UICollectionViewCell {
    // MARK: - Constants
    private enum C {
        static let cornerRadius: CGFloat = 12
        static let progressHeight: CGFloat = 4
    }
    
    // MARK: - Views
    lazy var progressView: UIProgressView = {
        var progressView = UIProgressView()
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.trackTintColor = .black
        progressView.progressTintColor = R.color.navy()!
        return progressView
    }()
    
    lazy var lockImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = R.image.icLock()!
        imageView.isHidden = true
        return imageView
    }()
    
    // MARK: - Views
    lazy var assetImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = C.cornerRadius
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        var label = UILabel()
        label.font = Constants.nameFont
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
    }()
    
    // MARK: - Life cycles
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAssetImageView()
        setupLockImageView()
        setupNameLabel()
        setupProgressView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Configure
    func configure(asset: Asset) {
        nameLabel.text = asset.name
        lockImageView.isHidden = asset.purchased
        progressView.progress = Float(asset.progress) / 100
        progressView.isHidden = asset.progress <= 0
        loadImage(url: asset.image)
    }
    
    // MARK: - Setup
    func setupAssetImageView() {
        addSubview(assetImageView)
    }
    
    func setupNameLabel() {
        addSubview(nameLabel)
    }
    
    private func setupProgressView() {
        assetImageView.addSubview(progressView)
        
        NSLayoutConstraint.activate([
            progressView.widthAnchor.constraint(equalToConstant: C.progressHeight),
            progressView.leadingAnchor.constraint(equalTo: assetImageView.leadingAnchor, constant: .zero),
            progressView.trailingAnchor.constraint(equalTo: assetImageView.trailingAnchor, constant: .zero),
            progressView.bottomAnchor.constraint(equalTo: assetImageView.bottomAnchor, constant: .zero)
        ])
    }
    
    private func setupLockImageView() {
        assetImageView.addSubview(lockImageView)
        
        NSLayoutConstraint.activate([
            lockImageView.widthAnchor.constraint(equalToConstant: Constants.lockImageSide),
            lockImageView.heightAnchor.constraint(equalToConstant: Constants.lockImageSide),
            lockImageView.leadingAnchor.constraint(equalTo: assetImageView.leadingAnchor, constant: Constants.lockImageSpacing),
            lockImageView.topAnchor.constraint(equalTo: assetImageView.topAnchor, constant: Constants.lockImageSpacing)
        ])
    }
    
    // MARK: - Private Methods
    private func loadImage(url: URL) {
        ImagePipeline.shared.loadImage(with: url) { [weak self] in
            guard let self, case .success(let response) = $0 else { return }
            self.assetImageView.image = response.image
        }
    }
}
