//
//  HomeLayoutSectionFactory.swift
//
//
//  Created by Vadim Marchenko on 12.04.2024.
//

import Foundation
import UIKit

final class HomeLayoutSectionFactory {
    
    private typealias Constant = HomeConstant.Layout
    
    func build(for type: Home.Section) -> NSCollectionLayoutSection {
        switch type {
        case .promotion:
            return buildPromoSection()
        case .category:
            return buildCategorySection()
        case .movie:
            return buildMoveSection()
        case .liveChannel:
            return buildLiveChannelSection()
        case .epg:
            return buildMoveEPG()
        }
    }
    
    // MARK: - Promo
    private func buildPromoSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0,
                                                     leading: Constant.itemHorizontalPadding,
                                                     bottom: 0,
                                                     trailing: Constant.itemHorizontalPadding)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(Constant.promotionSection))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = NSDirectionalEdgeInsets(top: Constant.sectionVerticalPadding,
                                                        leading: 0,
                                                        bottom: Constant.promotionBottomPadding,
                                                        trailing: 0)
        return section
    }
    
    // MARK: - Cateogry
    private func buildCategorySection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(Constant.categorySectionWidth),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0,
                                                     leading: 0,
                                                     bottom: 0,
                                                     trailing: Constant.smallTextPadding)
        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(Constant.estimationWidth),
                                               heightDimension:.estimated(Constant.categorySectionHeight))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: Constant.smallTextPadding,
                                                        leading: Constant.itemHorizontalPadding,
                                                        bottom: Constant.hugePadding,
                                                        trailing: Constant.itemHorizontalPadding)
        section.orthogonalScrollingBehavior = .continuous
        let header = buildHeader()
        section.boundarySupplementaryItems = [header]
        return section
    }
    
    // MARK: - Move
    private func buildMoveSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(Constant.movieSectionWidth),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0,
                                                     leading: 0,
                                                     bottom: 0,
                                                     trailing: Constant.smallTextPadding)
        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(Constant.estimationWidth),
                                               heightDimension: .estimated(Constant.movieSectionHeight))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: Constant.smallTextPadding,
                                                        leading: Constant.itemHorizontalPadding,
                                                        bottom: Constant.hugePadding,
                                                        trailing: Constant.itemHorizontalPadding)
        section.orthogonalScrollingBehavior = .continuous
        let header = buildHeader()
        section.boundarySupplementaryItems = [header]
        return section
    }
    
    // MARK: - Live
    private func buildLiveChannelSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(Constant.liveChannelSection),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0,
                                                     leading: 0,
                                                     bottom: 0,
                                                     trailing: Constant.smallTextPadding)
        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(Constant.estimationWidth),
                                               heightDimension: .estimated(Constant.liveChannelHeight))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: Constant.smallTextPadding,
                                                        leading: Constant.itemHorizontalPadding,
                                                        bottom: Constant.hugePadding,
                                                        trailing: Constant.itemHorizontalPadding)
        section.orthogonalScrollingBehavior = .continuous
        let header = buildHeader()
        section.boundarySupplementaryItems = [header]
        return section
    }
    
    // MARK: - EPG
    private func buildMoveEPG() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(Constant.epgSectionWidth),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0,
                                                     leading: 0,
                                                     bottom: 0,
                                                     trailing: Constant.smallTextPadding)
        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(Constant.estimationWidth),
                                               heightDimension: .estimated(Constant.epgSectionHeight))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: Constant.smallTextPadding,
                                                        leading: Constant.itemHorizontalPadding,
                                                        bottom: 0,
                                                        trailing: Constant.itemHorizontalPadding)
        section.orthogonalScrollingBehavior = .continuous
        let header = buildHeader()
        section.boundarySupplementaryItems = [header]
        return section
    }
    
    
    // MARK: - Header
    private func buildHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                heightDimension: .absolute(Constant.headerHeight))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .topLeading)
        return header
    }
}
