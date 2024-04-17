//
//  HomeSectionHeaderReusableView.swift
//
//
//  Created by Vadim Marchenko on 12.04.2024.
//

import Foundation
import UIKit

final class HomeSectionHeaderReusableView: UICollectionReusableView {
    
    private var action: (() -> Void)?
    // MARK: - UI Elements
    private var titleLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.robotoRegular(size: 16)
        view.textColor = ColorAssets.text
        return view
    }()
    
    private var actionButton: UIButton = {
        let view = UIButton()
        view.setTitle("Del", for: .normal)
        view.setTitleColor(ColorAssets.action, for: .normal)
        view.titleLabel?.font = UIFont.robotoRegular(size: 16)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
        
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        actionButton.addTarget(self, action: #selector(buttonDidTap), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        addSubview(titleLabel)
        addSubview(actionButton)
        
        NSLayoutConstraint.activate( [
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            actionButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            actionButton.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    @objc func buttonDidTap() {
        action?()
    }
    
    // MARK: - Public
    func configure(title: String, isCanDelete: Bool, action: (() -> Void)? = nil) {
        self.action = action
        titleLabel.text = title
        actionButton.isHidden = !isCanDelete
    }
}
