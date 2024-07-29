//
//  SectionHeaderReusableView.swift
//  DemoApp
//
//  Created by Nik Dub on 10.07.2024.
//

import UIKit

class SectionHeaderReusableView: UICollectionReusableView {
    
    static var reuseIdentifier = "section_header"
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()
    
    private var deleteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitle("Del", for: .normal)
        return button
    }()
    
    var onDelete: () -> () = {}

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        addSubview(titleLabel)
        addSubview(deleteButton)

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            deleteButton.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -10
            ),
            deleteButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor)
        ])
    }
    
    func setTitle(text: String) {
        titleLabel.text = text
    }
    
    func configure(title: String, isDeletable: Bool) {
        titleLabel.text = title
        deleteButton.isHidden = !isDeletable
    }
    
    private func setupViews() {
        deleteButton.addTarget(
            self,
            action: #selector(deleteTapped),
            for: .touchUpInside
        )
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func deleteTapped() {
        onDelete()
    }
}
