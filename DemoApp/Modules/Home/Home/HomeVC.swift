//
//  ViewController.swift
//  DemoApp
//
//  Created by Pete Shpagin on 31.03.2021.
//

import UIKit

extension HomeVC: Makeable {
    static func make() -> HomeVC { HomeVC() }
}

final class HomeVC: BaseVC, ViewModelContainer {
    // MARK: - Views
    private lazy var navigationImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.image = R.image.icHomeTitle()!
        return imageView
    }()
    
    private lazy var collectionView: UICollectionView = {
        var collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: .init())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(PromotionsCVC.self, CategoryCVC.self, NovaCVC.self, LivechannelCVC.self, EpgCVC.self)
        collectionView.registerHeader(SectionHeaderView.self)
        collectionView.delegate = self
        return collectionView
    }()
    
    // MARK: - Public Properties
    var viewModel: HomeVM?
    
    // MARK: - Private Properties
    private lazy var dataSource = makeDataSource(collectionView: collectionView, delegate: self)
    
    // MARK: - Life cycles
    override func bind() {
        super.bind()
        guard let viewModel else { return }
        setupViewModel()
        
        viewModel.$promotionGroup
            .combineLatest(
                viewModel.$categoryGroup,
                viewModel.$assetGroups
            )
            .sink { [weak self] tuple in
                let (promotionGroup, categoryGroup, assetGroups) = tuple
                guard let self, let promotionGroup, let categoryGroup, let assetGroups else { return }
                let snapshot = self.makeSnapshot(
                    content: [
                        (Section.promotions, [Item.promotions(group: promotionGroup)]),
                        (Section.categories, categoryGroup.categories.map(Item.categories)),
                        (Section.novas, assetGroups.moviesOrSeries.map(Item.novas)),
                        (Section.livechannels, assetGroups.livechannels.map(Item.livecahnnels)),
                        (Section.epgs, assetGroups.epgs.map(Item.epgs))
                    ])
                self.dataSource.apply(snapshot)
            }
            .store(in: &subscriptions)
    }
    
    override func setupVC() {
        super.setupVC()
        setupNavigationBarTitle()
        setupCollectionView()
    }
    
    // MARK: - Setup
    private func setupNavigationBarTitle() {
        navigationItem.titleView = navigationImageView
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: .zero),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .zero),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: .zero),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: .zero)
        ])
        
        collectionView.collectionViewLayout = makeLayout(dataSource: dataSource)
    }
}

// MARK: - SectionHeaderViewDelegate
extension HomeVC: SectionHeaderViewDelegate {
    func sectionHeaderViewDidDelete(_ view: SectionHeaderView, section: Section) {
        var snapshot = dataSource.snapshot()
        snapshot.deleteSections([section])
        dataSource.apply(snapshot)
    }
}

// MARK: - UICollectionViewDelegate
extension HomeVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard dataSource.snapshot().sectionIdentifiers[indexPath.section].hasAsset else {
            return
        }
        viewModel?.openAssetDetails()
    }
}
