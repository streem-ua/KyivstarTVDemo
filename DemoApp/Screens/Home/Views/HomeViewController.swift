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

    // TODO: remove force unwrapping
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
        let layout = UICollectionViewLayout()
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground

        collectionView.register(PromotionCell.self, forCellWithReuseIdentifier: PromotionCell.reuseId)
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.reuseId)
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.reuseId)
        collectionView.register(LiveChannelCell.self, forCellWithReuseIdentifier: LiveChannelCell.reuseId)
        collectionView.register(EpgCell.self, forCellWithReuseIdentifier: EpgCell.reuseId)
        collectionView.register(LoadingCell.self, forCellWithReuseIdentifier: LoadingCell.reuseId)

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

    // MARK: - DataSource
    private func configureDataSource() {
        setupCellProvider()
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
