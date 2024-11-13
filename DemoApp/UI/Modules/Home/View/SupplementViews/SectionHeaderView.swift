//
//  SectionHeaderView.swift
//  DemoApp
//
//  Created by Ihor on 01.08.2024.
//

import UIKit

class SectionHeaderView: UICollectionReusableView {
    static let reuseIdentifier = "SectionHeaderView"
    static let elementKind = "SectionHeaderView"
    
    var section: Home.SectionViewModel?
    private var action: ((Home.SectionViewModel) -> Void)?
    // MARK: - UI Elements
    private var titleLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: 16)
        view.textColor = UIColor.appDarkBlack()
        return view
    }()
    
    private var actionButton: UIButton = {
        let view = UIButton(type: .custom)
        view.setTitle("Del", for: .normal)
        view.setTitleColor(UIColor.appBlue(), for: .normal)
        view.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        view.titleLabel?.textColor = .blue
        view.titleLabel?.numberOfLines = 1
        view.titleLabel?.lineBreakMode = .byWordWrapping
        view.isHidden = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        actionButton.addTarget(self, action: #selector(buttonDidPressed), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        addSubview(titleLabel)
        addSubview(actionButton)
        
        NSLayoutConstraint.activate( [
            actionButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            actionButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }
    
    @objc func buttonDidPressed() {
        action?(section!)
    }
    
    func configure(_ section: Home.SectionViewModel, canBeDeleted: Bool, action: ((Home.SectionViewModel) -> Void)? = nil) {
        self.action = action
        self.section = section
        titleLabel.text = section.section.title
        actionButton.isHidden = !canBeDeleted
    }
}
