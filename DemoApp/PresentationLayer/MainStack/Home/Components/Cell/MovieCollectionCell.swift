//
//  MovieCollectionCell.swift
//  DemoApp
//
//  Created by Karpenko Bohdan on 02.06.2024.
//

import UIKit

final class MovieCollectionCell: BaseHomeCollectionCellWithProgress {
    
    //MARK: - Properties
    
    static let identifier = "MovieCollectionCell"
    private let titleLabel = UILabel(
        font: Font.regular.font(size: 12),
        textAlignment: .left,
        numberOfLines: 2)
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attachTitleLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configure
    
    func configure(model: ContentGroupCellModel) {
        imageView.setImage(urlSting: model.asset.image)
        titleLabel.text = model.asset.name
        lockImageView.isHidden = model.asset.purchased
        progressView.progress = model.asset.floatProgress
    }
    
    override func attachImageView() {
        addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(imageView.snp.width).multipliedBy(1.5)
        }
    }
    
    private func attachTitleLabel() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.equalTo(imageView)
            $0.top.equalTo(imageView.snp.centerY).multipliedBy(2.1)
        }
    }
}
