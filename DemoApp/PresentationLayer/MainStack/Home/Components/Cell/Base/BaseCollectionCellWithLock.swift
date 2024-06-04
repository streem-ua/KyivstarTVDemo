//
//  BaseCollectionCellWithLock.swift
//  DemoApp
//
//  Created by Karpenko Bohdan on 02.06.2024.
//

import UIKit

class BaseCollectionCellWithLock: BaseHomeCollectionCell {
    //MARK: - Properties
    
    let lockImageView = UIImageView(image: .image(.lock), contentMode: .scaleAspectFit)
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attachLockImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configure
    
    func attachLockImageView() {
        addSubview(lockImageView)
        lockImageView.snp.makeConstraints {
            $0.width.height.equalTo(imageView.snp.width).multipliedBy(0.23)
            $0.top.equalTo(imageView.snp.centerY).multipliedBy(0.09)
            $0.leading.equalTo(imageView.snp.centerX).multipliedBy(0.09)
        }
    }
    
}
