//
//  CommonSectionHeaderView.swift
//  DemoApp
//
//  Created by Anton Ivchenko on 22.08.2024.
//

import Combine
import UIKit

final class CommonSectionHeaderView: UICollectionReusableView {
    // MARK: - Properties
    let deleteSectionSubject = PassthroughSubject<HomeViewAdapter.SectionType, Never>()
    private var sectionType: HomeViewAdapter.SectionType = .categories
    // MARK: - UI
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var actionButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(deleteButtonAction), for: .touchUpInside)
        button.setTitleColor(.init(hex: "0063C6"), for: .normal)
        button.setTitle("Del", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        addSubview(actionButton)
        setupConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Overriden methods
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.attributedText = nil
        actionButton.isHidden = true
    }
    // MARK: - Private methods
    private func setupConstraints() {
        NSLayoutConstraint.activate( [
            actionButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            actionButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }
    // MARK: - Actions
    @objc func deleteButtonAction() {
        deleteSectionSubject.send(sectionType)
    }
    // MARK: - Configuration
    func configure(_ section: HomeViewAdapter.SectionType, canBeDeleted: Bool) {
        guard let title = section.title else { return }
        titleLabel.attributedText = title.toAttributed([
            .kern(-0.24),
            .font(.systemFont(ofSize: 16, weight: .regular)),
            .color(.init(hex: "1E2228"))
        ])
        actionButton.isHidden = !canBeDeleted
        sectionType = section
    }
}
