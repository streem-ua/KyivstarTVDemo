//
//  PromotionLayoutFactory.swift
//  DemoApp
//
//  Created by Anton Ivchenko on 22.08.2024.
//

import Combine
import UIKit

final class PromotionLayoutFactory: PLayoutFactory {
    // MARK: - Properties
    private unowned let currentPageSubject: PassthroughSubject<Int, Never>
    // MARK: - Init
    init(currentPageSubject: PassthroughSubject<Int, Never>) {
        self.currentPageSubject = currentPageSubject
    }
    // MARK: - Interface
    func buildSectionLayout() -> NSCollectionLayoutSection {
        let promotionHeight = 180.0
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(promotionHeight)),
            subitems: [item()]
        )
        group.contentInsets = .zero
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets.zero
        section.orthogonalScrollingBehavior = .paging
        section.boundarySupplementaryItems = [header(), footer()]
        section.visibleItemsInvalidationHandler = { items, _, _ in
            guard let rowIndex = items.last?.indexPath.row else { return }
            self.currentPageSubject.send(rowIndex)
        }
        return section
    }
    // MARK: - Private methods
    private func header() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerHeight = 18.0
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(headerHeight)
        )
        return NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top,
            absoluteOffset: CGPoint.zero
        )
    }
    private func footer() -> NSCollectionLayoutBoundarySupplementaryItem {
        let footerHeight = 24.0
        let footerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.5),
            heightDimension: .absolute(footerHeight)
        )
        let footer = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: footerSize,
            elementKind: UICollectionView.elementKindSectionFooter,
            alignment: .bottom,
            absoluteOffset: CGPoint(x: 0, y: -footerHeight)
        )
        footer.pinToVisibleBounds = true
        footer.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 24,
            bottom: 0,
            trailing: 24
        )
        return footer
    }
    private func item() -> NSCollectionLayoutItem {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 16,
            leading: 24,
            bottom: 0,
            trailing: 24
        )
        return item
    }
}
