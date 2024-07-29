//
//  Category.swift
//  DemoApp
//
//  Created by Karpenko Bohdan on 03.06.2024.
//

import UIKit

final class CategoryCollectionCell: BaseHomeCollectionCell {
    
    //MARK: - Properties
    
    static let identifier = "CategoryCollectionCell"
    
    private let titleLabel = UILabel(
        font: Font.regular.font(size: 12),
        textAlignment: .center,
        numberOfLines: 1)
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attachTitleLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configure
    
    func configure(model: Category) {
        imageView.setImage(urlSting: model.image)
        titleLabel.text = model.name
    }
    
    override func attachImageView() {
        addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(imageView.snp.width)
        }
    }
    
    func attachTitleLabel() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.centerY).multipliedBy(2.1)
            $0.centerX.width.equalToSuperview()
        }
    }
}
