//
//  SectionHeaderView.swift
//  DemoApp
//
//  Created by Alex Oliynyk on 23.10.2024.
//

import UIKit

protocol SectionHeaderDelegate: AnyObject {
    func deleteButtonAction(section: Section)
}

class SectionHeaderView: UICollectionReusableView, Reusable {

    weak var delegate: SectionHeaderDelegate?

    var section: Section? {
        didSet {
            handleUI()
        }
    }

    private let titleLabel: UILabel = {
        let obj = UILabel()
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.font = .roboto(.regular, size: 16)
        obj.textColor = .colors(.black)
        return obj
    }()

    private let deleteButton: UIButton = {
        let obj = UIButton()
        obj.setTitle("Del", for: .normal)
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.setTitleColor(.colors(.blue), for: .normal)
        obj.titleLabel?.font = .roboto(.regular, size: 16)
        return obj
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        backgroundColor = .clear

        addSubview(titleLabel)
        addSubview(deleteButton)

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),

            deleteButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            deleteButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])

        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    }

    @objc private func deleteButtonTapped() {
        guard let section else { return }
        delegate?.deleteButtonAction(section: section)
    }
}

extension SectionHeaderView {
    private func handleUI() {
        guard let section else { return }

        titleLabel.text = section.title
    }
}
