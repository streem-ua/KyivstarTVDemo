//
//  HomeViewAdapter.swift
//  DemoApp
//
//  Created by Anton Ivchenko on 21.08.2024.
//

import UIKit
import Combine

final class HomeViewAdapter: NSObject {
    // MARK: - Public Properties
    var cancellable = Set<AnyCancellable>()
    var didSelectItem: AnyPublisher<Void, Never> {
        didSelectItemSubject.eraseToAnyPublisher()
    }
    var didDeleteSection: AnyPublisher<SectionType, Never> {
        didDeleteSectionSubject.eraseToAnyPublisher()
    }
    // MARK: - Private Properties
    private var sectionData: [SectionData] = []
    private var dataSource: UICollectionViewDiffableDataSource<SectionType, SectionItem>!
    private let collectionView: UICollectionView
    // MARK: - Publishers
    private let currentPageSubject = PassthroughSubject<Int, Never>()
    private let didSelectItemSubject = PassthroughSubject<Void, Never>()
    private let didDeleteSectionSubject = PassthroughSubject<SectionType, Never>()
    // MARK: - Init
    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
        super.init()
        setupCollectionView()
        setupDataSource()
    }
    // MARK: - Private methods
    private func setupCollectionView() {
        collectionView.collectionViewLayout = createCompositionalLayout()
        collectionView.delegate = self
        collectionView.register(PromotionCell.self, forCellWithReuseIdentifier: PromotionCell.identifier)
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.identifier)
        collectionView.register(MovieSeriesCell.self, forCellWithReuseIdentifier: MovieSeriesCell.identifier)
        collectionView.register(LiveChannelCell.self, forCellWithReuseIdentifier: LiveChannelCell.identifier)
        collectionView.register(EpgCell.self, forCellWithReuseIdentifier: EpgCell.identifier)
        collectionView.register(
            PromotionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: PromotionHeaderView.identifier
        )
        collectionView.register(
            PromotionFooterView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: PromotionFooterView.identifier
        )
        collectionView.register(
            CommonSectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: CommonSectionHeaderView.identifier)
    }
    private func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource<SectionType, SectionItem>(collectionView: collectionView) { collectionView,
            indexPath,
            item in
            switch item {
            case .promotions(let promotion):
                let cell = collectionView.reusableCell(type: PromotionCell.self, indexPath: indexPath)
                cell.configure(with: promotion)
                return cell
            case .categories(let category):
                let cell = collectionView.reusableCell(type: CategoryCell.self, indexPath: indexPath)
                cell.configure(with: category)
                return cell
            case .movieSeries(let movieSeries):
                let cell = collectionView.reusableCell(type: MovieSeriesCell.self, indexPath: indexPath)
                cell.configure(with: movieSeries)
                return cell
            case .liveChannels(let liveChanel):
                let cell = collectionView.reusableCell(type: LiveChannelCell.self, indexPath: indexPath)
                cell.configure(with: liveChanel)
                return cell
            case .epg(let epg):
                let cell = collectionView.reusableCell(type: EpgCell.self, indexPath: indexPath)
                cell.configure(with: epg)
                return cell
            }
        }
        dataSource.supplementaryViewProvider = {
            [weak self]
            collectionView,
            kind,
            indexPath in
            guard let self, let sectionType = SectionType(rawValue: indexPath.section) else { return nil }
            let sectionData = self.sectionData[indexPath.section]
            let canBeDeleted = sectionData.canBeDeleted
            switch sectionType {
            case .promotions:
                if kind == UICollectionView.elementKindSectionHeader {
                    let headerView = collectionView.reusableSupplementaryView(
                        ofKind: kind,
                        type: PromotionHeaderView.self,
                        indexPath: indexPath
                    )
                    return headerView
                } else if kind == UICollectionView.elementKindSectionFooter {
                    let numberOfItemsInPromotions = collectionView.numberOfItems(inSection: indexPath.section)
                    let footerView = collectionView.reusableSupplementaryView(
                        ofKind: kind,
                        type: PromotionFooterView.self,
                        indexPath: indexPath
                    )
                    footerView.configure(
                        with: numberOfItemsInPromotions,
                        currentPageSubject: currentPageSubject
                    )
                    return footerView
                }
            default:
                if kind == UICollectionView.elementKindSectionHeader {
                    let headerView = collectionView.reusableSupplementaryView(
                        ofKind: kind,
                        type: CommonSectionHeaderView.self,
                        indexPath: indexPath
                    )
                    headerView.configure(sectionType, canBeDeleted: canBeDeleted)
                    headerView.deleteSectionSubject
                        .sink {
                            self.didDeleteSectionSubject.send($0)
                        }
                        .store(in: &cancellable)
                    return headerView
                }
            }
            return nil
        }
    }
    // MARK: - Layout
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let sectionProvider: UICollectionViewCompositionalLayoutSectionProvider = { [weak self] sectionIndex, _ in
            guard let self else { return nil }
            let sectionType = sectionData[sectionIndex].section
            let layoutFactory = getFactory(sectionType)
            return layoutFactory.buildSectionLayout()
        }
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 16.0
        return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider, configuration: config)
    }
    private func getFactory(_ type: SectionType) -> PLayoutFactory {
        switch type {
        case .promotions:
            return PromotionLayoutFactory(currentPageSubject: currentPageSubject)
        case .categories:
            return CategoriesLayoutFactory()
        case .movieSeries:
            return MovieSeriesLayoutFactory()
        case .liveChannels:
            return LiveChannelsLayoutFactory()
        case .epg:
            return EpgLayoutFactory()
        }
    }
    // MARK: - Interface
    func updateSection(_ items: [SectionData]) {
        sectionData = items
        var snapshot = NSDiffableDataSourceSnapshot<SectionType, SectionItem>()
        items.forEach { sectionData in
            if !snapshot.sectionIdentifiers.contains(sectionData.section) {
                snapshot.appendSections([sectionData.section])
            }
            snapshot.appendItems(sectionData.items, toSection: sectionData.section)
        }
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    func deleteSection(_ type: SectionType) {
        var snapshot = dataSource.snapshot()
        sectionData.removeAll(where: { $0.section == type })
        snapshot.deleteSections([type])
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

// MARK: - UICollectionViewDelegate
extension HomeViewAdapter: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
        switch item {
        case .movieSeries, .liveChannels, .epg:
            didSelectItemSubject.send()
        default:
            break
        }
    }
}
