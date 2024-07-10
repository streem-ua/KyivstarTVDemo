//
//  BadgeView.swift
//  DemoApp
//
//  Created by Nik Dub on 10.07.2024.
//

import UIKit

class BadgeViewReusableView: UICollectionReusableView {
    
    static var reuseIdentifier = "badge-test"
    private var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.preferredFont(forTextStyle: .footnote)
        label.text = String(Int.random(in: 1...9))
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemRed

        addSubview(label)

        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height/2
    }
}
