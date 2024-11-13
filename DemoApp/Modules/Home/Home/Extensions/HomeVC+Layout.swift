//
//  HomeVC+Layout.swift
//  DemoApp
//
//  Created by Vladyslav Lysenko on 28.08.2024.
//

import UIKit

extension HomeVC {
    // MARK: - Constants
    private enum C {
        static let promotionSectionSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(180))
        static let categorySectionSize = NSCollectionLayoutSize(widthDimension: .absolute(104), heightDimension: .absolute(128))
        static let novasSectionSize = NSCollectionLayoutSize(widthDimension: .absolute(104), heightDimension: .estimated(189))
        static let livechannelsSectionSize = NSCollectionLayoutSize(widthDimension: .absolute(104), heightDimension: .absolute(104))
        static let epgsSectionSize = NSCollectionLayoutSize(widthDimension: .absolute(216), heightDimension: .absolute(168))
        static let promotionSectionInsets = UIEdgeInsets(top: 0, left: 24, bottom: 14, right: 24)
        static let sectionInsets = UIEdgeInsets(top: 8, left: 24, bottom: 32, right: 24)
        static let groupSpacing: CGFloat = 8
        static let headerheight: CGFloat = 24
    }
    
    // MARK: - Public Methods
    func makeLayout(dataSource: DataSource) -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout(sectionProvider: { [weak self, weak dataSource] index, _ in
            switch dataSource?.snapshot().sectionIdentifiers[index] {
            case .promotions: self?.makePromotionLayoutSection()
            case .categories: self?.makeCategoryLayoutSection()
            case .novas: self?.makeNovasLayoutSection()
            case .livechannels: self?.makeLivechannelsLayoutSection()
            case .epgs: self?.makeEpgsLayoutSection()
            default: nil
            }
        })
    }
    
    // MARK: - Private Methods
    private func makePromotionLayoutSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: C.promotionSectionSize)
        let section = NSCollectionLayoutSection(group: .vertical(layoutSize: C.promotionSectionSize, subitems: [item]))
        section.contentInsets = NSDirectionalEdgeInsets(insets: C.promotionSectionInsets)
        return section
    }
    
    private func makeCategoryLayoutSection() -> NSCollectionLayoutSection {
        makeSection(withSize: C.categorySectionSize)
    }
    
    private func makeNovasLayoutSection() -> NSCollectionLayoutSection {
        makeSection(withSize: C.novasSectionSize)
    }
    
    private func makeLivechannelsLayoutSection() -> NSCollectionLayoutSection {
        makeSection(withSize: C.livechannelsSectionSize)
    }
    
    private func makeEpgsLayoutSection() -> NSCollectionLayoutSection {
        makeSection(withSize: C.epgsSectionSize)
    }
    
    private func makeSection(withSize size: NSCollectionLayoutSize) -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: size)
        let section = NSCollectionLayoutSection(group: .vertical(layoutSize: size, subitems: [item]))
        section.interGroupSpacing = C.groupSpacing
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = NSDirectionalEdgeInsets(insets: C.sectionInsets)
        section.boundarySupplementaryItems = [makeHeader()]
        return section
    }
    
    private func makeHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(C.headerheight))
        
        let item = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        return item
    }
}
