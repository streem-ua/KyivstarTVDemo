//
//  LayoutHelper.swift
//  DemoApp
//
//  Created by Ihor on 03.08.2024.
//

import UIKit

final class LayoutHelper {
    static func sectionWithHeaderAndCell(_ size: CGSize) -> NSCollectionLayoutSection {
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(50)
        )
        let header = NSCollectionLayoutBoundarySupplementaryItem(
          layoutSize: headerSize,
          elementKind: SectionHeaderView.elementKind,
          alignment: .top,
          absoluteOffset: CGPoint(x: 0, y: 0)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(size.width), heightDimension: .absolute(size.height)), subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
        section.interGroupSpacing = 8
        section.boundarySupplementaryItems = [header]
        return section
    }
}
