//
//  LiveChannelsLayoutFactory.swift
//  DemoApp
//
//  Created by Anton Ivchenko on 22.08.2024.
//

import UIKit

final class LiveChannelsLayoutFactory: PLayoutFactory {
    func buildSectionLayout() -> NSCollectionLayoutSection {
        LayoutBuilder.buildSectionLayout(size: .init(width: 104, height: 104))
    }
}
