//
//  UICollectionViewCell.swift
//
//
//  Created by Vadim Marchenko on 11.04.2024.
//

import Foundation
import UIKit

open class CollectionViewCell: UICollectionViewCell {

    // MARK: - Initializers
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupConstraints() {

    }
}

