//
//  PromotionsCell.swift
//  DemoApp
//
//  Created by Nik Dub on 10.07.2024.
//

import UIKit

class PromotionsCell: ConfigurableCell {
    private lazy var thumbImageView: UIImageView = {
        $0.image = UIImage(named: "channel")
        $0.layer.cornerRadius = 16
        $0.clipsToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError("not implemented")
    }
    
    override func configure(with model: CellItem) {
        thumbImageView.loadAndSetImage(model.imageURL)
    }
    
    
    private func configure() {
        contentView.addSubview(thumbImageView)
        NSLayoutConstraint.activate([
            thumbImageView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor
            ),
            thumbImageView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor
            ),
            thumbImageView.topAnchor.constraint(
                equalTo: contentView.topAnchor
            ),
            thumbImageView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor
            )
        ])
    }
}
