//
//  PromotionsCVC.swift
//  DemoApp
//
//  Created by Vladyslav Lysenko on 28.08.2024.
//

import UIKit
import Nuke

final class PromotionsCVC: UICollectionViewCell {
    // MARK: - Views
    private lazy var promotionView: PromotionView = {
        var view = PromotionView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = Constants.cornerRadius
        view.layer.masksToBounds = true
        return view
    }()
    
    // MARK: - Life cycles
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupPromotionView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Setup
    private func setupPromotionView() {
        contentView.addSubview(promotionView)
        
        NSLayoutConstraint.activate([
            promotionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: .zero),
            promotionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .zero),
            promotionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: .zero),
            promotionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: .zero)
        ])
    }
    
    // MARK: - Configure
    func configure(group: PromotionGroup) {
        guard !group.promotions.isEmpty else { return }
        promotionView.configure(promotions: group.promotions)
    }
}
