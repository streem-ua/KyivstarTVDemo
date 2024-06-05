//
//  TableHeaderView.swift
//  DemoApp
//
//  Created by Karpenko Bohdan on 04.06.2024.
//

import UIKit

final class CollectionHeaderView: UICollectionReusableView {
    
    //MARK: - Properties
    
    static let identifier = "CollectionHeaderView"
    
    private let imageView = UIImageView(image: .image(.logo), contentMode: .scaleAspectFit)
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attachImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configure
    
    private func attachImageView() {
        addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(114)
            $0.height.equalTo(20)
        }
    }
}
