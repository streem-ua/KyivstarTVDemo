//
//  HomeViewController.swift
//  DemoApp
//
//  Created by Nik Dub on 06.07.2024.
//

import UIKit
import Combine

class HomeViewController: UIViewController, HomeView {
    
    // MARK: - Private properties -
    
    private lazy var dataSource = makeDataSource()
    private var cancellables = Set<AnyCancellable>()
    private var storedModels: [Section] = []
    
    private lazy var myDataSource = makeDataSource()
    private lazy var collectionView: UICollectionView = {
        $0.register(
            SectionHeaderReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: SectionHeaderReusableView.reuseIdentifier
        )
        $0.register(
            EmptyHeaderReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: EmptyHeaderReusableView.reuseIdentifier
        )
        return $0
    }(UICollectionView(frame: view.bounds, collectionViewLayout: createLayout()))
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView()
        loader.isHidden = true
        loader.style = .large
        loader.startAnimating()
        loader.translatesAutoresizingMaskIntoConstraints = false
        return loader
    }()
    
    private lazy var headerView: UIView = {
        $0.backgroundColor = .white
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    
    private lazy var logoImageView: UIImageView = {
        $0.backgroundColor = .clear
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    // MARK: - Internal properties -
    
    var viewModel: HomeViewModel!
    
    // MARK: - Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        initialSetup()
        configureHierarchy()
        applySnapshot(with: [], animatingDifferences: false)
    }
    
    // MARK: - Private methods -
    
    func applySnapshot(
        with sections: [Section],
        animatingDifferences: Bool = true
    ) {
        storedModels = sections
        DispatchQueue.main.async { [unowned self] in
            var snapshot = Snapshot()
            snapshot.appendSections(sections)
            sections.forEach { section in
                snapshot.appendItems(section.cellItems, toSection: section)
            }
            dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
        }
    }
    
    func configureHierarchy() {
           collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
           view.addSubview(collectionView)
    }
    
    private func initialSetup() {
        viewModel.subscribeOnPublisher { publisher in
            publisher.sink { value in
                switch value {
                case .loading:
                    self.showLoader(true)
                case .updated(let array):
                    self.storedModels = array
                    self.applySnapshot(with: array)
                    self.showLoader(false)
                case .error(let error):
                    self.showErrorAlert(error)
                    self.showLoader(false)
                default: break
                }
            }.store(in: &cancellables)
        }
        viewModel.start()
    }
    
    private func setupViews() {
        logoImageView.image = UIImage(named: "logo_blue")
        headerView.addSubview(logoImageView)
        view.addSubview(headerView)
        collectionView.addSubview(activityIndicator)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            logoImageView.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            logoImageView.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 5),
            logoImageView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -5),
            
            activityIndicator.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor)
        ])
    }
    
    private func showLoader(_ isShowing: Bool) {
        DispatchQueue.main.async { [unowned self] in
            activityIndicator.isHidden = !isShowing
            isShowing
            ? activityIndicator.startAnimating()
            : activityIndicator.stopAnimating()
        }
    }
    
    private func showErrorAlert(_ error: Error) {
        DispatchQueue.main.async {
            let controller = UIAlertController(
                title: "Error",
                message: error.localizedDescription,
                preferredStyle: .alert
            )
            let action = UIAlertAction(title: "Ok", style: .default) { _ in }
            controller.addAction(action)
            self.present(controller, animated: true)
        }
    }
    
    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout {
            sectionIndex, environment in
            
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0)
                )
            )
            
            let containerGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)
                ),
                subitem: item,
                count: 1
            )
            
            let itemSize = self.getLayoutSizeForItem(of: self.storedModels[sectionIndex].type)
            
            let superContainerGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: itemSize,
                subitems: [containerGroup]
            )
            let section = NSCollectionLayoutSection(group: superContainerGroup)
            section.interGroupSpacing = 8
            section.orthogonalScrollingBehavior = .continuous
            section.contentInsets = .init(
                top: 10,
                leading: 24,
                bottom: 10,
                trailing: 10
            )
            
            let headerFooterSize = NSCollectionLayoutSize(
              widthDimension: .fractionalWidth(1.0),
              heightDimension: .absolute(30)
            )
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
              layoutSize: headerFooterSize,
              elementKind: UICollectionView.elementKindSectionHeader,
              alignment: .top
            )
            section.boundarySupplementaryItems = [sectionHeader]
            
            return section
            
        }
        return layout
    }
    
    func makeDataSource() -> DataSource {
        collectionView.register(
            SquareTitledCell.self,
            forCellWithReuseIdentifier: SquareTitledCell.identifier
        )
        collectionView.register(
            PromotionsCell.self,
            forCellWithReuseIdentifier: PromotionsCell.identifier
        )
        collectionView.register(
            AssetCell.self,
            forCellWithReuseIdentifier: AssetCell.identifier
        )
        collectionView.register(
            ChannelCell.self,
            forCellWithReuseIdentifier: ChannelCell.identifier
        )
        collectionView.register(
            EPGCell.self,
            forCellWithReuseIdentifier: EPGCell.identifier
        )
        let dataSource = DataSource(
            collectionView: collectionView,
            cellProvider: { (collectionView: UICollectionView, indexPath: IndexPath, element: CellItem) ->
                UICollectionViewCell? in
                
                guard let cell = self.dequeueCell(
                    of: self.storedModels[indexPath.section].type,
                    collectionView: collectionView,
                    indexPath: indexPath
                ) else {
                    return UICollectionViewCell()
                }
                cell.configure(
                    with: self.storedModels[indexPath.section].cellItems[indexPath.row]
                )
                return cell
            })
        dataSource.supplementaryViewProvider = { [unowned self] (collectionView: UICollectionView, kind: String, indexPath: IndexPath) in
            guard kind == UICollectionView.elementKindSectionHeader else {
                return UICollectionReusableView(frame: .zero)
            }
            guard let titleText = storedModels[indexPath.section].name else {
                let view = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: EmptyHeaderReusableView.reuseIdentifier,
                    for: indexPath) as? EmptyHeaderReusableView
                return view!
            }
            let view = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: SectionHeaderReusableView.reuseIdentifier,
                for: indexPath) as? SectionHeaderReusableView
            view?.onDelete = {[weak self] in
                guard let section = self?.storedModels[indexPath.section] else {
                    return
                }
                self?.viewModel.deleteGroup(with: section.id)
            }
            view?.setTitle(text: titleText)
            return view
        }
        return dataSource
    }
    
    func dequeueCell(
        of type: SectionType,
        collectionView: UICollectionView,
        indexPath: IndexPath
    ) -> ConfigurableCell? {
        var reuseIdentifier = ""
        switch type {
        case .PROMOTIONS:
            reuseIdentifier = PromotionsCell.identifier
        case .EPG:
            reuseIdentifier = EPGCell.identifier
        case .LIVECHANNEL:
            reuseIdentifier = ChannelCell.identifier
        case .MOVIE, .SERIES:
            reuseIdentifier = AssetCell.identifier
        case .CATEGORIES:
            reuseIdentifier = SquareTitledCell.identifier
        }
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: reuseIdentifier,
            for: indexPath) as? ConfigurableCell
        return cell
    }
    
    private func getLayoutSizeForItem(of type: SectionType) -> NSCollectionLayoutSize {
        switch type {
        case .PROMOTIONS:
            return NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.9),
                heightDimension: .estimated(180)
            )
        case .EPG:
            return NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.6),
                heightDimension: .absolute(164)
            )
        case .LIVECHANNEL:
            return NSCollectionLayoutSize(
                widthDimension: .absolute(104),
                heightDimension: .estimated(104)
            )
        case .MOVIE, .SERIES:
            return NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.275),
                heightDimension: .estimated(196)
            )
        case .CATEGORIES:
            return NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.275),
                heightDimension: .estimated(128)
            )
        }
    }
}

extension HomeViewController: UICollectionViewDelegate {}

typealias DataSource = UICollectionViewDiffableDataSource<Section, CellItem>
typealias Snapshot = NSDiffableDataSourceSnapshot<Section, CellItem>

