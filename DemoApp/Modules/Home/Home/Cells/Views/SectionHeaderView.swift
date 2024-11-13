//
//  SectionHeader.swift
//  DemoApp
//
//  Created by Vladyslav Lysenko on 29.08.2024.
//

import UIKit

protocol SectionHeaderViewDelegate: AnyObject {
    func sectionHeaderViewDidDelete(_ view: SectionHeaderView, section: HomeVC.Section)
}

final class SectionHeaderView: UICollectionReusableView {
    // MARK: - Constants
    private enum C {
        static let titleLeadingPadding: CGFloat = 24
        static let deleteTitle = "Del"
    }
    
    // MARK: - Views
    private lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.font = Constants.headerTitleFont
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = .zero
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    private lazy var deleteButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(C.deleteTitle, for: .normal)
        button.setTitleColor(R.color.navy()!, for: .normal)
        button.titleLabel?.font = Constants.headerButtonFont
        button.setContentHuggingPriority(.defaultLow, for: .horizontal)
        button.addTarget(self, action: #selector(didTapDelete), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Private Properties
    private var section: HomeVC.Section?
    
    // MARK: - Public Properties
    weak var delegate: SectionHeaderViewDelegate?
    
    // MARK: - Initialize
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupNameLabel()
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Setup
    private func setupNameLabel() {
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: .zero),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .zero),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: .zero)
        ])
    }
    
    private func setupButton() {
        addSubview(deleteButton)
        
        NSLayoutConstraint.activate([
            deleteButton.heightAnchor.constraint(equalToConstant: 28),
            deleteButton.widthAnchor.constraint(equalToConstant: 24),
            deleteButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            deleteButton.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: C.titleLeadingPadding),
            deleteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: .zero)
        ])
    }
    
    // MARK: - Configure
    func configure(section: HomeVC.Section) {
        self.section = section
        titleLabel.text = section.name
    }
    
    // MARK: - Actions
    @objc private func didTapDelete(_ sender: Any) {
        guard let section else { return }
        delegate?.sectionHeaderViewDidDelete(self, section: section)
    }
}
