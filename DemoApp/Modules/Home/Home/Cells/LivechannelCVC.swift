//
//  LivechannelCVC.swift
//  DemoApp
//
//  Created by Vladyslav Lysenko on 29.08.2024.
//

import UIKit
import Nuke

final class LivechannelCVC: UICollectionViewCell {
    // MARK: - Constants
    private enum C {
        static let cornerRadius: CGFloat = Constants.imageSide / 2
        static let lockImageSide: CGFloat = 32
    }
    
    // MARK: - Views
    private lazy var assetImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = C.cornerRadius
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private lazy var lockImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = R.image.icLock()!
        imageView.isHidden = true
        return imageView
    }()
    
    // MARK: - Life cycles
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAssetImageView()
        setupLockImageView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Configure
    func configure(asset: Asset) {
        lockImageView.isHidden = asset.purchased
        loadImage(url: asset.image)
    }
    
    // MARK: - Setup
    private func setupAssetImageView() {
        addSubview(assetImageView)
        
        NSLayoutConstraint.activate([
            assetImageView.widthAnchor.constraint(equalToConstant: Constants.imageSide),
            assetImageView.heightAnchor.constraint(equalToConstant: Constants.imageSide),
            assetImageView.topAnchor.constraint(equalTo: topAnchor, constant: .zero),
            assetImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .zero),
            assetImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: .zero)
        ])
    }
    
    private func setupLockImageView() {
        addSubview(lockImageView)
        
        NSLayoutConstraint.activate([
            lockImageView.widthAnchor.constraint(equalToConstant: C.lockImageSide),
            lockImageView.heightAnchor.constraint(equalToConstant: C.lockImageSide),
            lockImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .zero),
            lockImageView.topAnchor.constraint(equalTo: topAnchor, constant: .zero)
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
