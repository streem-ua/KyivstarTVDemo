//
//  LayoutBuilder.swift
//  DemoApp
//
//  Created by Anton Ivchenko on 22.08.2024.
//

import UIKit

final class LayoutBuilder {
    static func buildSectionLayout(size: CGSize) -> NSCollectionLayoutSection {
        return layoutSection(group: fullSizeItemGroup(size: size))
    }
    // MARK: - Private methods
    private static func fullSizeItemGroup(size: CGSize) -> NSCollectionLayoutGroup {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            )
        )
        item.contentInsets = .zero
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension: .absolute(size.width),
                heightDimension: .absolute(size.height)
            ),
            subitems: [item]
        )
        return group
    }
    private static func layoutSection(group: NSCollectionLayoutGroup) -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 8, leading: 24, bottom: 8, trailing: 24)
        section.interGroupSpacing = 8
        section.boundarySupplementaryItems = [sectionHeader()]
        return section
    }
    private static func sectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(24)
        )
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top,
            absoluteOffset: .zero
        )
        return header
    }
}
