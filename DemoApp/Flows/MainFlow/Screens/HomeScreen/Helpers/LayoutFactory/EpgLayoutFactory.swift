//
//  EpgLayoutFactory.swift
//  DemoApp
//
//  Created by Anton Ivchenko on 22.08.2024.
//

import UIKit

final class EpgLayoutFactory: PLayoutFactory {
    func buildSectionLayout() -> NSCollectionLayoutSection {
        LayoutBuilder.buildSectionLayout(size: .init(width: 216, height: 168))
    }
}

