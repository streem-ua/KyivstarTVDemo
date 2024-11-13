//
//  HomeViewController.swift
//  DemoApp
//
//  Created by Vlad Tkach on 14.08.2024.
//

import Foundation
import UIKit
import Combine
import SkeletonView

enum HomeViewAction {
    case deleteSection(HomeViewController.Collection.SectionModel)
    case refreshContent
}

enum HomeViewEvent {
    case viewDidLoad
}

enum HomeViewModuleAction {
    case showAssetDetails(ContentGroup.Asset)
    case showError(Error)
}

final class HomeViewController: UIViewController {
    
    //MARK: - Views
    private var refreshControl: UIRefreshControl = UIRefreshControl()
    internal var collectionView: UICollectionView!
    
    //MARK: - Dependencies
    internal let viewModel: HomeViewModel
    internal var cancellable = Set<AnyCancellable>()

    private var snapshot = NSDiffableDataSourceSnapshot<Collection.Section, Collection.Item>()
    internal var dataSource: UICollectionViewDiffableDataSource<Collection.Section, Collection.Item>?

    // MARK: - uses for module output
    let moduleOutputSubject = PassthroughSubject<HomeViewModuleAction, Never>()
    
    // MARK: - Init
    init(_ viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground

        configureCollection()
        configureCollectionDataSource()
        bindViewModel()
        refreshControl.addTarget(self, action: #selector(refreshContentAction), for: .valueChanged)
        viewModel.viewEventsSubject.send(.viewDidLoad)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    // MARK: - Configuration
    private func configureCollection() {
        
        //setup collection
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.refreshControl = self.refreshControl
        collectionView.isSkeletonable = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        //setup collection elements
        collectionView.register(HomePromotionCell.self, forCellWithReuseIdentifier: HomePromotionCell.reuseIdentifier)
        collectionView.register(HomeCategoryCell.self, forCellWithReuseIdentifier: HomeCategoryCell.reuseIdentifier)
        collectionView.register(HomeMovieSeriesCell.self, forCellWithReuseIdentifier: HomeMovieSeriesCell.reuseIdentifier)
        collectionView.register(HomeLiveChannelCell.self, forCellWithReuseIdentifier: HomeLiveChannelCell.reuseIdentifier)
        collectionView.register(HomeEpgCell.self, forCellWithReuseIdentifier: HomeEpgCell.reuseIdentifier)

        collectionView.register(
            HomeLogoHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: HomeLogoHeaderView.reuseIdentifier)
        collectionView.register(
            HomePageControlFooterView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: HomePageControlFooterView.reuseIdentifier)
        
        collectionView.register(
            HomeSectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: HomeSectionHeaderView.reuseIdentifier)
    }
        
    private func bindViewModel() {
        viewModel.$viewStatus
            .receive(on: DispatchQueue.main)
            .sink { [weak self] status in
                guard let self = self else { return }
                switch status {
                case .idl:
                    break
                case .loading:
                    self.showSkeletonAnimation()
                case .loaded(let sections):
                    self.refreshControl.endRefreshing()
                    self.updateSnapshot(sections: sections)
                case .refresh:
                    self.refreshControl.beginRefreshing()
                case .error(let error):
                    collectionView.hideSkeleton()
                    self.moduleOutputSubject.send(.showError(error))
                }
        }.store(in: &cancellable)
    }
    
    // MARK: - Actions
    @objc func refreshContentAction() {
        self.viewModel.viewActionsSubject.send(.refreshContent)
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // Module output call
        guard let assetModel = viewModel.groupItem(for: indexPath) else { return }
        moduleOutputSubject.send(.showAssetDetails(assetModel))
    }
}

extension HomeViewController {
    private func showSkeletonAnimation() {
        let gradient = SkeletonGradient(baseColor: UIColor.silver)
        let animation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .leftRight)
        collectionView.showAnimatedGradientSkeleton(usingGradient: gradient, animation: animation)
    }
    
    private func updateSnapshot(sections: [Collection.SectionModel]) {
        var snapshot = self.snapshot
        snapshot.appendSections(sections.compactMap({ $0.section }))
        sections.forEach { sectionModel in
            snapshot.appendItems(sectionModel.items, toSection: sectionModel.section)
        }
        collectionView.hideSkeleton()
        dataSource?.apply(snapshot, animatingDifferences: true)

    }
}

import SwiftUI
struct HomeViewController_Previews: PreviewProvider {
  static var previews: some View {
    Container().edgesIgnoringSafeArea(.all)
  }
  struct Container: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        HomeViewController(HomeViewModel())
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
    typealias UIViewControllerType = UIViewController
  }
}
