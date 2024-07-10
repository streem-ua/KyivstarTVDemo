//
//  ChannelCell.swift
//  DemoApp
//
//  Created by Nik Dub on 10.07.2024.
//

import UIKit

class ChannelCell: UICollectionViewCell {
    private lazy var thumbImageView: UIImageView = {
        $0.image = UIImage(named: "channel")
        $0.layer.cornerRadius = 16
        $0.clipsToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    private lazy var lockImageView: UIImageView = {
        $0.image = UIImage(named: "lock")
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError("not implemented")
    }
    
    private func configure() {
        contentView.addSubview(thumbImageView)
        contentView.addSubview(lockImageView)
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
            thumbImageView.heightAnchor.constraint(
                equalTo: thumbImageView.widthAnchor
            ),
            thumbImageView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor
            ),
            
            lockImageView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor
            ),
            lockImageView.topAnchor.constraint(
                equalTo: contentView.topAnchor
            ),
            lockImageView.heightAnchor.constraint(
                equalTo: lockImageView.widthAnchor
            ),
            lockImageView.widthAnchor.constraint(equalToConstant: 32),
        ])
    }
}

