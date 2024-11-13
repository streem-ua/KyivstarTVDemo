//
//  ConfigurableCell.swift
//  DemoApp
//
//  Created by Nik Dub on 11.07.2024.
//

import UIKit

protocol Configurable {
    associatedtype Model
    func configure(with model: Model)
}

class ConfigurableCell: UICollectionViewCell, Configurable {
    func configure(with model: CellItem) {}
}
