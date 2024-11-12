//
//  HomeViewController.swift
//  DemoApp
//
//  Created by Denys Zaiakin on 28.03.2024.
//

import UIKit
import Combine

fileprivate enum Constants {
    static let imageViewHeight: CGFloat = 18
    static let imageViewPadding: CGFloat = 16
    static let sectionContentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 32, trailing: 16)
    static let itemLeadingInset: CGFloat = 8
}

fileprivate typealias DataSource = UICollectionViewDiffableDataSource<Home.Section, Home.Item>
fileprivate typealias Snapshot = NSDiffableDataSourceSnapshot<Home.Section, Home.Item>

class HomeViewController: UIViewController {
    private var cancellables = Set<AnyCancellable>()
    private let pagingInfoSubject = PassthroughSubject<PagingInfo, Never>()

    private var dataSource: DataSource!
    private var collectionView: UICollectionView!

    private var currentIndexPath: IndexPath?

    var viewModel: HomeViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AssetColor.background.uiColor
        setupCollectionView()
        configureDataSource()

        viewModel.$dataSource
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] dataSource in
                var snapshot = Snapshot()
                for sectionModel in dataSource {
                    snapshot.appendSections([sectionModel.section])
                    snapshot.appendItems(sectionModel.items, toSection: sectionModel.section)
                }

                self?.dataSource.apply(snapshot)
            }
            .store(in: &cancellables)

        viewModel.fetchItems()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.isHidden = true
    }
}

extension HomeViewController {
    //MARK: - CollectionView Setup
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground

        collectionView.register(PromotionCell.self, forCellWithReuseIdentifier: PromotionCell.reuseId)
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.reuseId)
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.reuseId)
        collectionView.register(LiveChannelCell.self, forCellWithReuseIdentifier: LiveChannelCell.reuseId)
        collectionView.register(EpgCell.self, forCellWithReuseIdentifier: EpgCell.reuseId)
        collectionView.register(LoadingCell.self, forCellWithReuseIdentifier: LoadingCell.reuseId)

        collectionView.register(
            HomeSectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: HomeSectionHeaderView.reuseId
        )

        collectionView.register(
            LockView.self,
            forSupplementaryViewOfKind: LockView.reuseId,
            withReuseIdentifier: LockView.reuseId
        )

        collectionView.register(
            PagingSectionFooterView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: PagingSectionFooterView.reuseId
        )

        setupCollectionViewHeader()
        setupCollectionViewConstraints()
    }

    private func setupCollectionViewHeader() {
        let topInset = Constants.imageViewHeight + Constants.imageViewPadding
        let imageView = UIImageView(image: ImageAssets.kyivstarLogo.image)
        imageView.contentMode = .center
        imageView.frame = CGRectMake(0, -topInset, self.collectionView.frame.size.width, 18)
        collectionView.addSubview(imageView)
        collectionView.contentInset = UIEdgeInsets(top: topInset, left: 0, bottom: 0, right: 0)
    }

    private func setupCollectionViewConstraints() {
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    // MARK: - Layout
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { [unowned self] (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            let section = dataSource.snapshot().sectionIdentifiers[sectionIndex]
            return createSectionLayout(for: section)
        }

        return layout
    }

    private func createSectionLayout(for sectionType: Home.Section) -> NSCollectionLayoutSection {
        let sectionParameters = HomeLayout.sectionParameters(for: sectionType)

        var itemSupplementaries: [NSCollectionLayoutSupplementaryItem] {
            guard sectionParameters.showLock else { return [] }
            return [HomeLayout.createLockItem(for: sectionType)]
        }

        let item = NSCollectionLayoutItem(
            layoutSize: sectionParameters.itemSize,
            supplementaryItems: itemSupplementaries
        )

        item.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: Constants.itemLeadingInset,
            bottom: 0,
            trailing: 0
        )

        let group: NSCollectionLayoutGroup = .horizontal(
            layoutSize: sectionParameters.groupSize,
            subitem: item,
            count: sectionParameters.columnCount
        )

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = Constants.sectionContentInsets
        section.orthogonalScrollingBehavior = sectionParameters.scrollBehavior

        if sectionParameters.showSectionHeader {
            let layoutSectionHeader = HomeLayout.createSectionHeader()
            section.boundarySupplementaryItems += [layoutSectionHeader]
        }

        if sectionType == .promotions {
            let footer = HomeLayout.createPageControlItem()
            section.boundarySupplementaryItems += [footer]

            section.interGroupSpacing = Constants.sectionContentInsets.leading + Constants.itemLeadingInset
        }

        section.visibleItemsInvalidationHandler = { [weak self] (items, offset, env) -> Void in
            guard let self = self else { return }
            let page = round(offset.x / (self.collectionView.bounds.width * 0.9))
            let totalPages = dataSource.snapshot().numberOfItems(inSection: .promotions)
            pagingInfoSubject.send(
                PagingInfo(
                    sectionIndex: sectionType.rawValue,
                    currentPage: Int(page),
                    totalPages: totalPages
                )
            )
        }

        return section
    }

    // MARK: - DataSource
    private func configureDataSource() {
        setupCellProvider()
        setupSupplementaryViewProvider()
    }

    // MARK: Cell
    private func setupCellProvider() {
        dataSource = DataSource(collectionView: collectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
            switch item {
            case .promotion(let promotion):
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: PromotionCell.reuseId,
                    for: indexPath) as! PromotionCell
                cell.update(with: promotion)
                return cell

            case .category(let category):
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: CategoryCell.reuseId,
                    for: indexPath) as! CategoryCell
                cell.update(with: category)
                return cell

            case .movie(let movie):
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: MovieCell.reuseId,
                    for: indexPath) as! MovieCell
                cell.update(with: movie)
                return cell

            case .liveChannel(let liveChannel):
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: LiveChannelCell.reuseId,
                    for: indexPath) as! LiveChannelCell
                cell.update(with: liveChannel)
                return cell

            case .epg(let epg):
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: EpgCell.reuseId,
                    for: indexPath) as! EpgCell
                cell.update(with: epg)
                return cell
            case .loading:
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: LoadingCell.reuseId,
                    for: indexPath) as! LoadingCell
                cell.animateGradientColors()
                return cell
            }
        })
    }

    // MARK: Supplementary
    private func setupSupplementaryViewProvider() {
        dataSource.supplementaryViewProvider = { [weak self] (collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? in
            guard let self = self else { return nil }

            switch kind {
            case LockView.reuseId:
                return self.createLockView(collectionView: collectionView, indexPath: indexPath)

            case UICollectionView.elementKindSectionHeader:
                return self.createSectionHeaderView(collectionView: collectionView, kind: kind, indexPath: indexPath)

            default:
                return self.createPagingFooterView(collectionView: collectionView, indexPath: indexPath)
            }
        }
    }

    private func createLockView(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionReusableView {
        let item = viewModel.dataSource[indexPath.section].items[indexPath.row]
        var isPurchased: Bool {
            switch item {
            case .movie(let asset), .liveChannel(let asset), .epg(let asset):
                return asset.purchased
            case .loading:
                return true
            default:
                return false
            }
        }

        let lockView = collectionView.dequeueReusableSupplementaryView(ofKind: LockView.reuseId, withReuseIdentifier: LockView.reuseId, for: indexPath) as! LockView
        lockView.isHidden = isPurchased

        return lockView
    }

    private func createSectionHeaderView(collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView {
        guard let supplementaryView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: HomeSectionHeaderView.reuseId,
                for: indexPath) as? HomeSectionHeaderView else {
            fatalError("Cannot create header view")
        }

        let section = dataSource.snapshot().sectionIdentifiers[indexPath.section]
        supplementaryView.update(with: section)
        supplementaryView.deleteButtonPublisher
            .sink { [weak self] output in
                self?.viewModel.deleteSection(section)
            }
            .store(in: &supplementaryView.cancellables)
        return supplementaryView
    }

    private func createPagingFooterView(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionReusableView {
        let pagingFooter = collectionView.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: PagingSectionFooterView.reuseId,
            for: indexPath) as! PagingSectionFooterView

        let itemCount = dataSource.snapshot().numberOfItems(inSection: .promotions)
        pagingFooter.configure(with: itemCount)
        pagingFooter.subscribeTo(subject: pagingInfoSubject, for: indexPath.section)

        return pagingFooter
    }
}

//MARK: - UICollectionView Delegate
extension HomeViewController: UICollectionViewDelegate  {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
        print(item)
        viewModel.didSelectItem(item)
        viewModel.vibrate()
    }
}

// MARK: - UILongPressGestureRecognizer
extension HomeViewController: UIGestureRecognizerDelegate  {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
