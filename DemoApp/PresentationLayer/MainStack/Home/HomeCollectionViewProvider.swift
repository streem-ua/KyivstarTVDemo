//
//  HomeCollectionViewProvider.swift
//  DemoApp
//
//  Created by Karpenko Bohdan on 02.06.2024.
//

import UIKit
import Combine

final class HomeCollectionViewProvider: CollectionViewProvider<Home.Section, Home.Item, HomeViewModel> {
    
    //MARK: - Properties
    
    private let pageControll = SectionFooterView()
    private let pagingInfoSubject = PassthroughSubject<PagingInfo, Never>()
    
    //MARK: - Init
    
    override init(collectionView: UICollectionView, viewModel: HomeViewModel) {
        super.init(collectionView: collectionView, viewModel: viewModel)
        
        viewModel.$dataSource
            .receive(on: DispatchQueue.main)
            .sink {[weak self] array in
                self?.updateData(sections: array)
                print(array.count)
            }.store(in: &viewModel.cancellables)
    }
    
    //MARK: - Configure
    
    func updateData(sections: [HomeSectionModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<Home.Section, Home.Item>()
        for section in sections {
            snapshot.appendSections([section.section])
            snapshot.appendItems(section.items, toSection: section.section)
            dataSource?.apply(snapshot)
        }
    }
    
    override func setupCollectionView() {
        super.setupCollectionView()
        collectionView?.register(MovieCollectionCell.self, forCellWithReuseIdentifier: MovieCollectionCell.identifier)
        collectionView?.register(PromotionsCollectionCell.self, forCellWithReuseIdentifier: PromotionsCollectionCell.identifier)
        collectionView?.register(LiveChannelCollectionCell.self, forCellWithReuseIdentifier: LiveChannelCollectionCell.identifier)
        collectionView?.register(CategoryCollectionCell.self, forCellWithReuseIdentifier: CategoryCollectionCell.identifier)
        collectionView?.register(EpgCollectionCell.self, forCellWithReuseIdentifier: EpgCollectionCell.identifier)
        
        collectionView?.register(SectionFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: SectionFooterView.identifier)
        collectionView?.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.identifier)
        
    }
    
    override func reloadSnapshot() {
//        var snapshot = NSDiffableDataSourceSnapshot<Home.HomeSection, TestModel>()
//        
//        snapshot.appendSections([.movie, .livechannel, .epg])
//        snapshot.appendItems([TestModel(), TestModel(), TestModel(), TestModel()], toSection: .movie)
//        snapshot.appendItems([TestModel(), TestModel(), TestModel(), TestModel()], toSection: .livechannel)
//        snapshot.appendItems([TestModel(), TestModel(), TestModel(), TestModel()], toSection: .epg)
//        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    override func configureCell(collectionView: UICollectionView, indexPath: IndexPath, item: Home.Item) -> UICollectionViewCell {
        switch item {
        case .movie(let model):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionCell.identifier, for: indexPath) as! MovieCollectionCell
            cell.configure(model: model)
            return cell
        case .livechannel(let model):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LiveChannelCollectionCell.identifier, for: indexPath) as! LiveChannelCollectionCell
            cell.configure(model: model)
            return cell
        case .epg(let model):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EpgCollectionCell.identifier, for: indexPath) as! EpgCollectionCell
            cell.configure(model: model)
            return cell
        case .categories(let model):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionCell.identifier, for: indexPath) as! CategoryCollectionCell
            cell.configure(model: model)
            return cell
        case .promotions(let model):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PromotionsCollectionCell.identifier, for: indexPath) as! PromotionsCollectionCell
            cell.configure(model: model)
            return cell
        }
    }
    
    override func configureSupplementaryView(_ collectionView: UICollectionView, _ elementKind: String, _ indexPath: IndexPath) -> UICollectionReusableView? {
        let section = viewModel.sectionType(section: indexPath.section)
        
        switch section {
        case .promotions:
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: SectionFooterView.identifier, for: indexPath) as! SectionFooterView
            footer.subscribeTo(subject: pagingInfoSubject, for: indexPath.section)
            footer.configure(with: viewModel.promotionsCount())
            return footer
        default:
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: SectionHeader.identifier, for: indexPath) as! SectionHeader
            sectionHeader.configure(type: section)
            sectionHeader.didTapDel = {[weak self] in
                self?.viewModel.didTapDell(sectionIndex: indexPath.section)
            }
            return sectionHeader
        }
    }
    
    deinit {
        print("sdfsdds")
    }
    
    override func sectionProvider(_ sectionIndex: Int,_ environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? {
        let section: NSCollectionLayoutSection
        switch viewModel.sectionType(section: sectionIndex) {
        case .movie:
            section =  configureMovieSection()
        case .livechannel:
            section = configureLivechannelSection()
        case .epg:
            section = configureEpgSection()
        case .categories:
            section = configureCategoriesSection()
        case .promotions:
            section = configurePromotionsSection()
        }
        return section
    }
    
    //MARK: - Configure Sections
    
    private func configureMovieSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 4, leading: 4, bottom: 4, trailing: 4)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalWidth(0.55))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        group.contentInsets = .init(top: 4, leading: 4, bottom: 4, trailing: 4)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        
        let header = configureSectionHeader()
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    private func configureLivechannelSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 4, leading: 4, bottom: 4, trailing: 4)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalWidth(0.3))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = .init(top: 4, leading: 4, bottom: 4, trailing: 4)
        let section = NSCollectionLayoutSection(group: group)
        
        section.orthogonalScrollingBehavior = .continuous
        
        let header = configureSectionHeader()
        
        section.boundarySupplementaryItems = [header]
        return section
    }
    
    private func configureEpgSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 4, leading: 4, bottom: 4, trailing: 4)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.6), heightDimension: .fractionalWidth(0.45))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = .init(top: 4, leading: 4, bottom: 4, trailing: 4)
        let section = NSCollectionLayoutSection(group: group)
        
        section.orthogonalScrollingBehavior = .continuous
        
        let header = configureSectionHeader()
        section.boundarySupplementaryItems = [header]
        return section
    }
    
    private func configureCategoriesSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 4, leading: 4, bottom: 4, trailing: 4)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalWidth(0.4))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = .init(top: 4, leading: 4, bottom: 4, trailing: 4)
        let section = NSCollectionLayoutSection(group: group)
        
        section.orthogonalScrollingBehavior = .continuous
        
        let header = configureSectionHeader()
        section.boundarySupplementaryItems = [header]

        return section
    }
    
    private func configurePromotionsSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.54))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 4, leading: 4, bottom: 4, trailing: 4)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.58))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = .init(top: 4, leading: 4, bottom: 4, trailing: 4)
        let section = NSCollectionLayoutSection(group: group)
        
        section.orthogonalScrollingBehavior = .groupPagingCentered
        let footer = configurePageControll()
        section.boundarySupplementaryItems = [footer]
        
        section.visibleItemsInvalidationHandler = {[weak self] (items, offset, env) -> Void in
            guard let self = self else { return }
            let page = items.last?.indexPath.row ?? 0
            self.pagingInfoSubject.send(PagingInfo( currentPage: page))
        }
        return section
    }
    
    private func configurePageControll() -> NSCollectionLayoutBoundarySupplementaryItem {
        let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(30))
        let footer = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: size, elementKind: UICollectionView.elementKindSectionFooter,alignment: .bottom, absoluteOffset: CGPoint(x: 0, y: -50))
        footer.contentInsets = .init(top: 0, leading: 8, bottom: 0, trailing: 8)
        return footer
    }
    
    private func configureSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(30))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader,alignment: .top)
        header.contentInsets = .init(top: 0, leading: 8, bottom: 0, trailing: 8)
        return header
    }
}
