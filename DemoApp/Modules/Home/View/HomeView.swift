//
//  HomeView.swift
//  DemoApp
//
//  Created by Alex Oliynyk on 21.10.2024.
//

import UIKit

protocol HomeViewPromotionsScrollDelegate: AnyObject {
    func didScrollPromotions(point: CGPoint)
}

class HomeView: UIView {

    weak var scrollDelegate: HomeViewPromotionsScrollDelegate?

    private let headerImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "logo_image"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            return self?.createSectionLayout(for: sectionIndex)
        }
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()

    let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = .white
        pageControl.isUserInteractionEnabled = false
        pageControl.alpha = 0
        return pageControl
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        backgroundColor = .colors(.background)

        addSubview(headerImageView)
        addSubview(collectionView)
        collectionView.addSubview(pageControl)

        NSLayoutConstraint.activate([
            headerImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            headerImageView.centerXAnchor.constraint(equalTo: centerXAnchor),

            collectionView.topAnchor.constraint(equalTo: headerImageView.bottomAnchor, constant: 16),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),

            pageControl.centerXAnchor.constraint(equalTo: centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: 180)
        ])
    }

    func createSectionLayout(for section: Int) -> NSCollectionLayoutSection? {
        guard let snapshot = (collectionView.dataSource as? UICollectionViewDiffableDataSource<Section, Item>)?.snapshot() else {
            return createDefaultLayout()
        }

        switch snapshot.sectionIdentifiers[section] {
        case .promotions:
            return makePromotionLayoutSection()
        case .categories:
            return makeCategoryLayoutSection()
        case .series:
            return makeSeriesLayoutSection()
        case .livechannels:
            return makeLivechannelsLayoutSection()
        case .epgs:
            return makeEpgsLayoutSection()
        }
    }

    private enum Constants {
        static let promotionSectionSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.85), heightDimension: .absolute(180))
        static let categorySectionSize = NSCollectionLayoutSize(widthDimension: .absolute(104), heightDimension: .absolute(128))
        static let seriesSectionSize = NSCollectionLayoutSize(widthDimension: .absolute(104), heightDimension: .estimated(189))
        static let livechannelsSectionSize = NSCollectionLayoutSize(widthDimension: .absolute(104), heightDimension: .absolute(104))
        static let epgsSectionSize = NSCollectionLayoutSize(widthDimension: .absolute(216), heightDimension: .absolute(168))
        static let promotionSectionInsets = UIEdgeInsets(top: 0, left: 24, bottom: 14, right: 24)
        static let sectionInsets = NSDirectionalEdgeInsets(top: 8, leading: 20, bottom: 20, trailing: 20)
        static let groupSpacing: CGFloat = 8
        static let headerHeight: CGFloat = 24
    }

    private func makePromotionLayoutSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: Constants.promotionSectionSize)
        let section = NSCollectionLayoutSection(group: .horizontal(
            layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(180)),
            subitems: [item]
        ))
        section.interGroupSpacing = Constants.groupSpacing
        section.orthogonalScrollingBehavior = .groupPaging

        let leadingTrailingInset = UIScreen.main.bounds.width * 0.15 / 2
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: leadingTrailingInset, bottom: 24, trailing: leadingTrailingInset)

        section.visibleItemsInvalidationHandler = { [weak self] (visibleItems, point, _) in
            if let firstVisibleItem = visibleItems.first {
                self?.scrollDelegate?.didScrollPromotions(point: point)
            }
        }

        return section
    }

    private func makeCategoryLayoutSection() -> NSCollectionLayoutSection {
        return makeSection(withSize: Constants.categorySectionSize)
    }

    private func makeSeriesLayoutSection() -> NSCollectionLayoutSection {
        return makeSection(withSize: Constants.seriesSectionSize)
    }

    private func makeLivechannelsLayoutSection() -> NSCollectionLayoutSection {
        return makeSection(withSize: Constants.livechannelsSectionSize)
    }

    private func makeEpgsLayoutSection() -> NSCollectionLayoutSection {
        return makeSection(withSize: Constants.epgsSectionSize)
    }

    private func makeSection(withSize size: NSCollectionLayoutSize) -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: size)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = Constants.groupSpacing
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = Constants.sectionInsets
        section.boundarySupplementaryItems = [makeHeader()]
        return section
    }

    private func makeHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(Constants.headerHeight))
        let item = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        return item
    }

    private func createDefaultLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        return NSCollectionLayoutSection(group: group)
    }
}
