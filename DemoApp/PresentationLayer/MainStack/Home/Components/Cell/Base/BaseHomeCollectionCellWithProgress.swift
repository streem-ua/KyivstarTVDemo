//
//  BaseContentGroupCollectionCell.swift
//  DemoApp
//
//  Created by Karpenko Bohdan on 02.06.2024.
//

import UIKit

class BaseHomeCollectionCellWithProgress: BaseCollectionCellWithLock {
    
    //MARK: - Propertie
    
    let progressView = ProgressView()
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attachProgressView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configure

    private func attachProgressView() {
        imageView.addSubview(progressView)
        progressView.snp.makeConstraints {
            $0.height.equalTo(5)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}
