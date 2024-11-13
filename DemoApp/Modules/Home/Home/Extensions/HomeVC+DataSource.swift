//
//  HomeVC+DataSource.swift
//  DemoApp
//
//  Created by Vladyslav Lysenko on 28.08.2024.
//

import UIKit

extension HomeVC {
    // MARK: - Typealias
    typealias Content = (section: Section, items: [Item])
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Item>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Item>
    typealias Delegate = SectionHeaderViewDelegate
    
    // MARK: - Enums
    enum Section: Int {
        case promotions
        case categories
        case novas
        case livechannels
        case epgs
        
        var name: String? {
            switch self {
            case .categories: "Категорії:"
            case .novas: "Новинки Київстар ТБ"
            case .livechannels: "Дитячі телеканали"
            case .epgs: "Пізнавальні"
            default: nil
            }
        }
        
        var hasAsset: Bool {
            self == .novas || self == .livechannels || self == .epgs
        }
    }

    enum Item: Equatable, Hashable {
        case promotions(group: PromotionGroup)
        case categories(category: Category)
        case novas(asset: Asset)
        case livecahnnels(asset: Asset)
        case epgs(asset: Asset)
    }
    
    // MARK: - Public Methods
    func makeDataSource(collectionView: UICollectionView, delegate: Delegate) -> DataSource {
        let dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, config in
            switch config {
            case .promotions(let group):
                collectionView.makeCell(PromotionsCVC.self, for: indexPath) {
                    $0.configure(group: group)
                }
            case .categories(let category):
                collectionView.makeCell(CategoryCVC.self, for: indexPath) {
                    $0.configure(category: category)
                }
            case .novas(let asset):
                collectionView.makeCell(NovaCVC.self, for: indexPath) {
                    $0.configure(asset: asset)
                }
            case .livecahnnels(let asset):
                collectionView.makeCell(LivechannelCVC.self, for: indexPath) {
                    $0.configure(asset: asset)
                }
            case .epgs(let asset):
                collectionView.makeCell(EpgCVC.self, for: indexPath) {
                    $0.configure(asset: asset)
                }
            }
        }
        
        dataSource.supplementaryViewProvider = makeSupplementaryViewProvider(delegate: delegate)
        
        return dataSource
    }
    
    func makeSnapshot(content: [Content]) -> Snapshot {
        with(Snapshot()) { snapshot in
            content.forEach {
                snapshot.appendSections([$0.section])
                snapshot.appendItems($0.items, toSection: $0.section)
            }
        }
    }
    
    // MARK: - Private Methods
    private func makeSupplementaryViewProvider(delegate: Delegate) -> DataSource.SupplementaryViewProvider {
        { [weak delegate] collectionView, kind, indexPath in
            guard kind == UICollectionView.elementKindSectionHeader, let section = Section(rawValue: indexPath.section) else { return nil }

            return collectionView.makeHeader(SectionHeaderView.self, for: indexPath) {
                $0.delegate = delegate
                $0.configure(section: section)
            }
        }
    }
}
