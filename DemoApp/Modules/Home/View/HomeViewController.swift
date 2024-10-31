//
//  HomeViewController.swift
//  DemoApp
//
//  Created by Pete Shpagin on 31.03.2021.
//

import UIKit
import Combine
import SwiftUI

class HomeViewController: UIViewController {

    weak var coordinator: HomeCoordinator?
    
    private var homeView: HomeView!
    
    private var viewModel: HomeViewModel!

    private var cancellables = Set<AnyCancellable>()
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>!

    override func loadView() {
        homeView = HomeView()
        view = homeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = HomeViewModel()
        setup()
        setupDataSource()
        setupBindings()
    }

    private func setup() {
        homeView.scrollDelegate = self
        homeView.collectionView.delegate = self

        homeView.collectionView.registerReusableCell(PromotionCell.self)
        homeView.collectionView.registerReusableCell(CategoryCell.self)
        homeView.collectionView.registerReusableCell(SeriesCell.self)
        homeView.collectionView.registerReusableCell(LivechannelCell.self)
        homeView.collectionView.registerReusableCell(EpgCell.self)
        homeView.collectionView.registerReusableSupplementaryView(elementKind: UICollectionView.elementKindSectionHeader, SectionHeaderView.self)
    }

    private func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: homeView.collectionView) { collectionView, indexPath, item in
            switch item {
            case .promotion(let promotion):
                let cell: PromotionCell = collectionView.dequeueReusableCell(for: indexPath)
                cell.model = promotion
                return cell

            case .category(let category):
                let cell: CategoryCell = collectionView.dequeueReusableCell(for: indexPath)
                cell.model = category
                return cell

            case .series(let series):
                let cell: SeriesCell = collectionView.dequeueReusableCell(for: indexPath)
                cell.model = series
                return cell

            case .livechannel(let livechannel):
                let cell: LivechannelCell = collectionView.dequeueReusableCell(for: indexPath)
                cell.model = livechannel
                return cell

            case .epg(let epg):
                let cell: EpgCell = collectionView.dequeueReusableCell(for: indexPath)
                cell.model = epg
                return cell
            }
        }

        dataSource.supplementaryViewProvider = { (collectionView, kind, indexPath) in
            guard kind == UICollectionView.elementKindSectionHeader else { return (UIView() as? UICollectionReusableView)! }

            let headerView: SectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, for: indexPath)

            guard let snapshot = (collectionView.dataSource as? UICollectionViewDiffableDataSource<Section, Item>)?.snapshot() else {
                return (UIView() as? UICollectionReusableView)!
            }

            headerView.section = snapshot.sectionIdentifiers[indexPath.section]
            headerView.delegate = self

            return headerView
        }
    }

    private func setupBindings() {
        viewModel.$snapshotItems
            .receive(on: DispatchQueue.main)
            .sink { [weak self] snapshotItems in
                self?.applySnapshot(snapshotItems: snapshotItems)
                self?.homeView.pageControl.numberOfPages = self?.viewModel.categories.count ?? 0
                self?.homeView.pageControl.alpha = 1
            }
            .store(in: &cancellables)
    }

    private func applySnapshot(snapshotItems: [Section: [Item]]) {
        DispatchQueue.main.async {
            var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
            let orderedSections: [Section] = [.promotions, .categories, .series, .livechannels, .epgs]

            orderedSections.forEach { section in
                if let items = snapshotItems[section], !items.isEmpty {
                    snapshot.appendSections([section])
                    snapshot.appendItems(items, toSection: section)
                }
            }
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
}

extension HomeViewController: SectionHeaderDelegate {
    func deleteButtonAction(section: Section) {
        if viewModel.canDeleteSection(section) {
            viewModel.removeSection(section)

            var currentSnapshot = dataSource.snapshot()
            currentSnapshot.deleteSections([section])
            dataSource.apply(currentSnapshot, animatingDifferences: true)
        }
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard dataSource.snapshot().sectionIdentifiers[indexPath.section].isAssetSection else {
            return
        }
        coordinator?.showAssetDetail()
    }
}

extension HomeViewController: HomeViewPromotionsScrollDelegate {
    func didScrollPromotions(point: CGPoint) {
        let pageIndex = Int((point.x + UIScreen.main.bounds.width / 2) / UIScreen.main.bounds.width)
        homeView.pageControl.currentPage = pageIndex
    }
}
