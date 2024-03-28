//
//  HomeLayout.swift
//  DemoApp
//
//  Created by Denys Zaiakin on 28.03.2024.
//

import UIKit
import Combine

class HomeLayout {
    // MARK: - Section Parameters
    static func sectionParameters(for section: Home.Section) -> HomeSectionLayoutParameters {
        switch section {
        case .promotions:           return promotionsSectionParameters()
        case .categories:           return categoriesSectionParameters()
        case .movies:               return moviesSectionParameters()
        case .liveChannel:          return liveChannelSectionParameters()
        case .epg:                  return epgSectionParameters()
        }
    }

    private static func promotionsSectionParameters() -> HomeSectionLayoutParameters {
        return HomeSectionLayoutParameters(
            itemSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)),
            groupSize: .init(widthDimension: .fractionalWidth(0.9), heightDimension: .absolute(180)),
            columnCount: 1,
            scrollBehavior: .continuousGroupLeadingBoundary,
            showSectionHeader: false
        )
    }

    private static func categoriesSectionParameters() -> HomeSectionLayoutParameters {
        return HomeSectionLayoutParameters(
            itemSize: .init(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalHeight(1)),
            groupSize: .init(widthDimension: .fractionalWidth(0.9), heightDimension: .absolute(128)),
            columnCount: 3
        )
    }

    private static func moviesSectionParameters() -> HomeSectionLayoutParameters {
        return HomeSectionLayoutParameters(
            itemSize: .init(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalHeight(1)),
            groupSize: .init(widthDimension: .fractionalWidth(0.9), heightDimension: .absolute(194)),
            columnCount: 3,
            showLock: true
        )
    }

    private static func liveChannelSectionParameters() -> HomeSectionLayoutParameters {
        return HomeSectionLayoutParameters(
            itemSize: .init(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalWidth(0.3)),
            groupSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.3)),
            columnCount: 3,
            showLock: true
        )
    }

    private static func epgSectionParameters() -> HomeSectionLayoutParameters {
        return HomeSectionLayoutParameters(
            itemSize: .init(widthDimension: .fractionalWidth(0.6), heightDimension: .fractionalHeight(1)),
            groupSize: .init(widthDimension: .fractionalWidth(0.65), heightDimension: .absolute(164)),
            columnCount: 1,
            showLock: true
        )
    }

    // MARK: - Supplementary Items
    static func createPageControlItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        let item = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: .init(
                widthDimension: .absolute(50),
                heightDimension: .absolute(16)
            ),
            elementKind: UICollectionView.elementKindSectionFooter,
            containerAnchor: .init(edges: .bottom, absoluteOffset: CGPoint(x: 0, y: -32))
        )

        return item
    }

    static func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let layoutSectionHeaderSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(40)
        )

        let layoutSectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: layoutSectionHeaderSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )

        return layoutSectionHeader
    }

    static func createLockItem(for section: Home.Section) -> NSCollectionLayoutSupplementaryItem {
        var topRightAnchor: NSCollectionLayoutAnchor {
            switch section {
            case .liveChannel:
                return .init(edges: [.top, .leading])
            default:
                return .init(edges: [.top, .leading], absoluteOffset: CGPoint(x: 6, y: 6))
            }
        }

        let badgeSize: CGFloat = (section != .liveChannel) ? 24 : 32
        let item = NSCollectionLayoutSupplementaryItem(
            layoutSize: .init(
                widthDimension: .absolute(badgeSize),
                heightDimension: .absolute(badgeSize)
            ),
            elementKind: LockView.reuseId,
            containerAnchor: topRightAnchor
        )

        return item
    }
}

