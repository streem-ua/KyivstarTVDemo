//
//  LiveChannelCollectionCell.swift
//  DemoApp
//
//  Created by Karpenko Bohdan on 02.06.2024.
//

import UIKit

final class LiveChannelCollectionCell: BaseCollectionCellWithLock {
    
    //MARK: - Properties
    
    static let identifier = "LiveChannelCollectionCell"
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configure
    
    func configure(model: ContentGroupAsset) {
        imageView.setImage(urlSting: model.image)
        lockImageView.isHidden = model.purchased
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.layer.cornerRadius = width/2
    }
}
