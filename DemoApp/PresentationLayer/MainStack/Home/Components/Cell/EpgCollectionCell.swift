//
//  EpgCollectionCell.swift
//  DemoApp
//
//  Created by Karpenko Bohdan on 02.06.2024.
//

import UIKit

final class EpgCollectionCell: BaseHomeCollectionCellWithProgress {
    
    //MARK: - Properties
    
    static let identifier = "EpgCollectionCell"
    private let titleLabel = UILabel(
        font: Font.regular.font(size: 12),
        textAlignment: .left,
        numberOfLines: 1)
    private let descriptionLabel = UILabel(
        font: Font.light.font(size: 11),
        textColor: .gray,
        textAlignment: .left)
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attachTitleLabel()
        attachDescriptionLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configure
    
    func configure(model: ContentGroupCellModel) {
        imageView.setImage(urlSting: model.asset.image)
        titleLabel.text = model.asset.name
        lockImageView.isHidden = model.asset.purchased
        descriptionLabel.text = model.asset.company
        progressView.progress = model.asset.floatProgress
    }
    
    override func attachLockImageView() {
        addSubview(lockImageView)
        lockImageView.snp.makeConstraints {
            $0.width.height.equalTo(imageView.snp.height).multipliedBy(0.2)
            $0.leading.equalTo(imageView.snp.centerX).multipliedBy(0.1)
            $0.top.equalTo(imageView.snp.centerY).multipliedBy(0.15)
        }
    }
    
    override func attachImageView() {
        addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
            $0.height.equalTo(imageView.snp.width).multipliedBy(0.55)
        }
    }
    
    private func attachTitleLabel() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.equalTo(imageView)
            $0.top.equalTo(imageView.snp.centerY).multipliedBy(2.1)
        }
    }
    
    private func attachDescriptionLabel() {
        addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom)
        }
    }
}
