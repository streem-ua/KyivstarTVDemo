//
//  PromotionsCollectionCell.swift
//  DemoApp
//
//  Created by Karpenko Bohdan on 04.06.2024.
//

import UIKit

final class PromotionsCollectionCell: BaseHomeCollectionCell {
    
    //MARK: - Properties
    
    static let identifier = "PromotionsCollectionCell"
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configure
 
    func configure(model: Promotion) {
        imageView.setImage(urlSting: model.image)
    }
}
