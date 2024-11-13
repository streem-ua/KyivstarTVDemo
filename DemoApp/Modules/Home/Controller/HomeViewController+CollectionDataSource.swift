//
//  HomeViewController+CollectionDataSource.swift
//  DemoApp
//
//  Created by Vlad Tkach on 17.08.2024.
//

import Foundation
import UIKit

extension HomeViewController {
    internal func configureCollectionDataSource() {
        let dataSource = HomeCollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: {(collectionView, indexPath, model) -> UICollectionViewCell? in

            switch model {
            case .promotion(let model):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomePromotionCell.reuseIdentifier,
                                                              for: indexPath) as! HomePromotionCell
                cell.configure(with: model)
                return cell
            case .category(let model):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCategoryCell.reuseIdentifier,
                                                              for: indexPath) as! HomeCategoryCell
                cell.configure(with: model)
                return cell
            case .movieSeries(let model):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeMovieSeriesCell.reuseIdentifier,
                                                              for: indexPath) as! HomeMovieSeriesCell
                cell.configure(with: model)
                return cell
            case .liveChannel(let model):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeLiveChannelCell.reuseIdentifier,
                                                              for: indexPath) as! HomeLiveChannelCell
                cell.configure(with: model)
                return cell
            case .epg(let model):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeEpgCell.reuseIdentifier,
                                                              for: indexPath) as! HomeEpgCell
                cell.configure(with: model)
                return cell
            }
        })
        dataSource.supplementaryViewProvider = supplementaryView
        
        self.dataSource = dataSource
    }
    
    private func supplementaryView(_ collectionView: UICollectionView, _ elementKind: String, _ indexPath: IndexPath) -> UICollectionReusableView? {
        
        guard let section = Collection.Section(rawValue: indexPath.section) else { return UICollectionReusableView() }
        
        switch (section, elementKind) {
        case (Collection.Section.promotions, UICollectionView.elementKindSectionHeader):
            let headerView = self.collectionView.dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: HomeLogoHeaderView.reuseIdentifier,
                for: indexPath) as! HomeLogoHeaderView
            
            headerView.configure(image: UIImage(resource: ImageResource.homeHeaderLogo))
            return headerView
            
        case (Collection.Section.promotions, UICollectionView.elementKindSectionFooter):
            let headerView = self.collectionView.dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionFooter,
                withReuseIdentifier: HomePageControlFooterView.reuseIdentifier,
                for: indexPath) as! HomePageControlFooterView

            headerView.configure(currentPage: self.viewModel.promotionsViewModel.currentPage,
                                 pageCount: self.viewModel.promotionsViewModel.pageCount,
                                 pageProvider: self.viewModel.promotionsViewModel.currentPageSubject)
            return headerView
            
        case (_, UICollectionView.elementKindSectionHeader):
            
            let headerView = self.collectionView.dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: HomeSectionHeaderView.reuseIdentifier,
                for: indexPath) as! HomeSectionHeaderView
            
            let section = self.viewModel.sectionModels[indexPath.section]
            headerView.configure(section, canBeDeleted: true)
            headerView.viewOutputSubject.sink { [weak self] action in
                switch action {
                case .delete(let sectionModel):
                    self?.viewModel.viewActionsSubject.send(.deleteSection(sectionModel))
                }
            }.store(in: &cancellable)
            return headerView

        default:
            return UICollectionReusableView()
        }
    }
}
