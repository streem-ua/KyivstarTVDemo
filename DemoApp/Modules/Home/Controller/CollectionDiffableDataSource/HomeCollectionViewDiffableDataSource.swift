//
//  HomeCollectionViewDiffableDataSource.swift
//  DemoApp
//
//  Created by Vlad Tkach on 16.08.2024.
//

import Foundation
import UIKit
import SkeletonView

typealias Collection = HomeViewController.Collection

final class HomeCollectionViewDiffableDataSource: UICollectionViewDiffableDataSource<Collection.Section, Collection.Item> {

    override init(collectionView: UICollectionView, cellProvider: @escaping UICollectionViewDiffableDataSource<Collection.Section, Collection.Item>.CellProvider) {
        super.init(collectionView: collectionView, cellProvider: cellProvider)
    }
}

extension HomeCollectionViewDiffableDataSource: SkeletonCollectionViewDataSource {
    func numSections(in collectionSkeletonView: UICollectionView) -> Int {
        return Collection.Section.allCases.count
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> SkeletonView.ReusableCellIdentifier {
        
        let sectionType = Collection.Section(rawValue: indexPath.section)
        switch sectionType {
        case .promotions:
            return HomePromotionCell.reuseIdentifier
        case .categories:
            return HomeCategoryCell.reuseIdentifier

        case .movieSeriesGroup:
            return HomeMovieSeriesCell.reuseIdentifier

        case .liveChannesGroup:
            return HomeLiveChannelCell.reuseIdentifier

        case .epgGroup:
            return HomeEpgCell.reuseIdentifier

        default:
            return ""
        }
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, supplementaryViewIdentifierOfKind: String, at indexPath: IndexPath) -> ReusableCellIdentifier? {
        let sectionType = Collection.Section(rawValue: indexPath.section)

        switch (sectionType, supplementaryViewIdentifierOfKind) {
        case (.promotions, UICollectionView.elementKindSectionHeader):
            return HomeLogoHeaderView.reuseIdentifier
        case (.promotions, UICollectionView.elementKindSectionFooter):
            return HomePageControlFooterView.reuseIdentifier
        case (_, UICollectionView.elementKindSectionHeader):
            return HomeSectionHeaderView.reuseIdentifier
        default:
            return nil
        }
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
}
