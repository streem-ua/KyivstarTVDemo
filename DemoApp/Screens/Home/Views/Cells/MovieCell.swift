//
//  MovieCell.swift
//  DemoApp
//
//  Created by Denys Zaiakin on 28.03.2024.
//

import UIKit
import Kingfisher

class MovieCell: UICollectionViewCell, Reusable {
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()

    private let titleLabel: TopAlignedLabel = {
        let label = TopAlignedLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = AssetColor.text.uiColor
        label.font = FontFamily.SFProDisplay.regular.font(size: 12)
        label.numberOfLines = 2
        label.contentMode = .top
        label.textAlignment = .left
        return label
    }()

    private let assetContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 12
        return view
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.kf.indicatorType = .activity
        return imageView
    }()

    private lazy var progressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.progressTintColor = AssetColor.progressBlue.uiColor
        progressView.trackTintColor = AssetColor.progressBlack.uiColor
        progressView.isHidden = true
        return progressView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        titleLabel.text = nil
        titleLabel.isHidden = false
        imageView.image = nil
        progressView.setProgress(0, animated: false)
        progressView.isHidden = true
    }

    func update(with movie: Asset) {
        titleLabel.text = movie.name

        if movie.progress > 0 {
            progressView.setProgress(Float(movie.progress) / 100, animated: false)
            progressView.isHidden = false
        }

        guard let imageUrl = URL(string: movie.image) else { return }
        imageView.kf.setImage(with: imageUrl)
    }

    private func setupCell() {
        setupConstraints()
    }

    // MARK: - Constraints
    private func setupConstraints() {
        setupImageContainerView()
        setupStackView()
    }

    private func setupImageContainerView() {
        assetContainerView.addSubview(imageView)
        assetContainerView.addSubview(progressView)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: assetContainerView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: assetContainerView.leadingAnchor),
            imageView.bottomAnchor.constraint(equalTo: assetContainerView.bottomAnchor),
            imageView.trailingAnchor.constraint(equalTo: assetContainerView.trailingAnchor),

            progressView.leadingAnchor.constraint(equalTo: assetContainerView.leadingAnchor),
            progressView.bottomAnchor.constraint(equalTo: assetContainerView.bottomAnchor),
            progressView.trailingAnchor.constraint(equalTo: assetContainerView.trailingAnchor),
            progressView.heightAnchor.constraint(equalToConstant: 4)
        ])
    }

    private func setupStackView() {
        addSubview(stackView)

        stackView.addArrangedSubview(assetContainerView)
        stackView.addArrangedSubview(titleLabel)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.16),
        ])
    }
}

