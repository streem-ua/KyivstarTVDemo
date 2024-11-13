//
//  HomeViewController+CollectionLayout.swift
//  DemoApp
//
//  Created by Vlad Tkach on 15.08.2024.
//

import Foundation
import UIKit

extension HomeViewController {
    
    internal func createLayout() -> UICollectionViewLayout {
        let sectionProvider: UICollectionViewCompositionalLayoutSectionProvider = { [weak self] (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            guard let self = self else { return nil }
            
            //FIXME: - addition logic for empty state, uses for skeleton loading
            let section = self.viewModel.sectionModels[safe: sectionIndex]?.section
                ?? Collection.Section(rawValue: sectionIndex)
            
            switch section {
            case .promotions:
                return self.promotionsCollectionLayout(environment: layoutEnvironment)
                
            case .categories:
                return self.categoriesCollectionLayout(environment: layoutEnvironment)
                
            case .movieSeriesGroup:
                return self.movieSeriesCollectionLayout(environment: layoutEnvironment)

            case .liveChannesGroup:
                return self.liveChannelsCollectionLayout(environment: layoutEnvironment)
                
            case .epgGroup:
                return self.epgCollectionLayout(environment: layoutEnvironment)
            default:
                return nil
            }
        }
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 16.0
        let layout = UICollectionViewCompositionalLayout(sectionProvider: sectionProvider, configuration: config)
        return layout
    }
    
    private func epgCollectionLayout(environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        
        let size = CGSize(width: 216, height: 168)
        
        let group = defaultFullSizeItemGroup(size: size)

        return defaultLayoutSection(group: group, environment: environment)
    }
    
    private func liveChannelsCollectionLayout(environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        
        let size = CGSize(width: 104, height: 104)
        
        let group = defaultFullSizeItemGroup(size: size)

        return defaultLayoutSection(group: group, environment: environment)
    }
    
    private func movieSeriesCollectionLayout(environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        
        let size = CGSize(width: 104, height: 200)
    
        let group = defaultFullSizeItemGroup(size: size)

        return defaultLayoutSection(group: group, environment: environment)
    }
    
    private func categoriesCollectionLayout(environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        
        let size = CGSize(width: 104.0, height: 128.0)
        
        let group = defaultFullSizeItemGroup(size: size)
        return defaultLayoutSection(group: group, environment: environment)
    }
    
    private func promotionsCollectionLayout(environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {

        let headerHeight = 18.0
        let promotionHeight = 180.0
        let footerHeight = 18.0

        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(headerHeight)
        )
        let header = NSCollectionLayoutBoundarySupplementaryItem(
          layoutSize: headerSize,
          elementKind: UICollectionView.elementKindSectionHeader,
          alignment: .top,
          absoluteOffset: CGPoint.zero
        )

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
        footer.zIndex = 2
        footer.contentInsets = NSDirectionalEdgeInsets(top: 0.0, leading: 24.0, bottom: 0.0, trailing: 24.0)
        
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 16.0, leading: 24.0, bottom: 0, trailing: 24.0)

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(promotionHeight)), subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets.zero

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets.zero
        section.orthogonalScrollingBehavior = .paging
        
        section.boundarySupplementaryItems = [header, footer]
        
        section.visibleItemsInvalidationHandler = { [weak self] (items, offset, env) -> Void in
            guard let rowIndex = items.last?.indexPath.row else { return }
            
            self?.viewModel.promotionsViewModel.currentPageSubject.send(rowIndex)
        }
        return section
    }
}

// MARK: - Default universal logic
extension HomeViewController {
    private func defaultFullSizeItemGroup(size: CGSize) -> NSCollectionLayoutGroup {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        item.contentInsets = NSDirectionalEdgeInsets.zero
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(size.width), 
                                                                         heightDimension: .absolute(size.height)),
                                                       subitems: [item])
        return group
    }
    
    private func defaultLayoutSection(group: NSCollectionLayoutGroup,
                                             environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 8.0, leading: 24.0, bottom: 8.0, trailing: 24.0)
        section.interGroupSpacing = 8
        section.boundarySupplementaryItems = [defaultSectionHeader(environment: environment)]
        return section
    }
    
    private func defaultSectionHeader(environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(24)
        )
        let header = NSCollectionLayoutBoundarySupplementaryItem(
          layoutSize: headerSize,
          elementKind: UICollectionView.elementKindSectionHeader,
          alignment: .top,
          absoluteOffset: CGPoint.zero
        )
        return header
    }
}
