//
//  SectionLayoutConfigurator.swift
//  DemoApp
//
//  Created by Bogdan Akopov on 02.01.2025.
//

import UIKit

protocol SectionLayoutProvider {
    func layout(for section: Section) -> NSCollectionLayoutSection?
}

final class DefaultSectionLayoutProvider: SectionLayoutProvider {
    func layout(for section: Section) -> NSCollectionLayoutSection? {
        switch section {
        case .promotions:
            return createPromotionsSection()
        case .categories:
            return createCategoriesSection()
        case .movieSeries:
            return createMovieSeriesSection()
        case .liveChannel:
            return createLiveChannelSection()
        case .epg:
            return createEPGSection()
        }
    }

    private func createPromotionsSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
        )

        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(180)
            ),
            subitems: [item]
        )

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 15, trailing: 0)

        return section
    }

    private func createCategoriesSection() -> NSCollectionLayoutSection {
        return createSection(
            itemSize: NSCollectionLayoutSize(widthDimension: .absolute(104), heightDimension: .absolute(130)),
            groupSize: NSCollectionLayoutSize(widthDimension: .estimated(104), heightDimension: .absolute(130)),
            headerHeight: 30,
            interGroupSpacing: 10
        )
    }

    private func createMovieSeriesSection() -> NSCollectionLayoutSection {
        return createSection(
            itemSize: NSCollectionLayoutSize(widthDimension: .absolute(104), heightDimension: .absolute(220)),
            groupSize: NSCollectionLayoutSize(widthDimension: .estimated(104), heightDimension: .absolute(220)),
            headerHeight: 30,
            interGroupSpacing: 10
        )
    }

    private func createLiveChannelSection() -> NSCollectionLayoutSection {
        return createSection(
            itemSize: NSCollectionLayoutSize(widthDimension: .absolute(104), heightDimension: .absolute(104)),
            groupSize: NSCollectionLayoutSize(widthDimension: .estimated(104), heightDimension: .absolute(104)),
            headerHeight: 30,
            interGroupSpacing: 8
        )
    }

    private func createEPGSection() -> NSCollectionLayoutSection {
        return createSection(
            itemSize: NSCollectionLayoutSize(widthDimension: .absolute(216), heightDimension: .absolute(168)),
            groupSize: NSCollectionLayoutSize(widthDimension: .absolute(216), heightDimension: .absolute(168)),
            headerHeight: 30,
            interGroupSpacing: 10
        )
    }

    private func createSection(itemSize: NSCollectionLayoutSize, groupSize: NSCollectionLayoutSize, headerHeight: CGFloat, interGroupSpacing: CGFloat) -> NSCollectionLayoutSection {
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(headerHeight)
            ),
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )

        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        group.interItemSpacing = .fixed(interGroupSpacing)

        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header]
        section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 24, bottom: 5, trailing: 24)
        section.orthogonalScrollingBehavior = .continuous

        return section
    }
}
