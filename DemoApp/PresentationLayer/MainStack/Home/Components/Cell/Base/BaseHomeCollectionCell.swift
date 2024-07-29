//
//  BaceHomeCollectionCell.swift
//  DemoApp
//
//  Created by Karpenko Bohdan on 02.06.2024.
//

import UIKit

class BaseHomeCollectionCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    let imageView = UIImageView(
        contentMode: .scaleAspectFill,
        cornerRadius: 10,
        clipsToBounds: true)
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attachImageView()
        configureImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configure
    
    func configureImageView() {}
    
    func attachImageView() {
        addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    override func prepareForReuse() {
        imageView.kf.cancelDownloadTask()
    }
    
}
