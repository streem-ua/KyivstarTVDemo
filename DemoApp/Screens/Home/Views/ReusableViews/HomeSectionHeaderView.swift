//
//  HomeSectionHeaderView.swift
//  DemoApp
//
//  Created by Denys Zaiakin on 28.03.2024.
//

import UIKit
import Combine

final class HomeSectionHeaderView: UICollectionReusableView, Reusable {
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = AssetColor.text.uiColor
        label.font = FontFamily.RobotoCondensed.regular.font(size: 16)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()

    private let deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Del", for: .normal)
        button.titleLabel?.font = FontFamily.RobotoCondensed.regular.font(size: 16)
        button.setTitleColor(AssetColor.textBlue.uiColor, for: .normal)
        button.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return button
    }()

    var deleteButtonPublisher: AnyPublisher<UIControl, Never> {
        deleteButton.publisher(for: .touchUpInside)
            .eraseToAnyPublisher()
    }

    var section: Home.Section?
    var cancellables = Set<AnyCancellable>()

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(stackView)

        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(deleteButton)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
        ])
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
    }

    func update(with section: Home.Section) {
        titleLabel.text = section.title
        self.section = section
    }
}

