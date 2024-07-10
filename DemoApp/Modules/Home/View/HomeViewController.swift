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
        return $0
    }(UICollectionView(frame: view.bounds, collectionViewLayout: createLayout()))
    
    private lazy var helloLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        
        return label
    }()
    
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
//        configureDataSource()
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
//           collectionView.delegate = self
    }
    
    private func initialSetup() {
        viewModel.subscribeOnPublished { publisher in
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
        view.addSubview(helloLabel)
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
        
        helloLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        helloLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -30).isActive = true
        
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
    
    private func configureCollectionView() {}
    
    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout {
            sectionIndex, environment in
            
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0)
                )
            )
//            item.contentInsets = NSDirectionalEdgeInsets(
//                top: .zero,
//                leading: 10,
//                bottom: .zero,
//                trailing: 10
//            )
            
            let containerGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)
                ),
                subitem: item,
                count: 1
            )
            
            var itemSize: NSCollectionLayoutSize!
            
            switch sectionIndex {
            case 0:
                itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.275),
                    heightDimension: .absolute(128)
                )
            case 1:
                itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.275),
                    heightDimension: .absolute(196)
                )
            case 2:
                itemSize = NSCollectionLayoutSize(
                    widthDimension: .absolute(104),
                    heightDimension: .absolute(104)
                )
            default:
                itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.6),
                    heightDimension: .absolute(164)
                )
            }
            
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
              heightDimension: .estimated(20)
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
                
                switch self.storedModels[indexPath.section].type {
                case .PROMOTIONS:
                    let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: PromotionsCell.identifier,
                        for: indexPath) as? PromotionsCell
                    return cell
                case .EPG:
                    let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: EPGCell.identifier,
                        for: indexPath) as? EPGCell
                    return cell
                case .LIVECHANNEL:
                    let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: ChannelCell.identifier,
                        for: indexPath) as? ChannelCell
                    return cell
                case .MOVIE, .SERIES:
                    let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: AssetCell.identifier,
                        for: indexPath) as? AssetCell
                    return cell
                case .CATEGORIES:
                    let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: SquareTitledCell.identifier,
                        for: indexPath) as? SquareTitledCell
                    return cell
                }
            })
        dataSource.supplementaryViewProvider = { (collectionView: UICollectionView, kind: String, indexPath: IndexPath) in
            guard kind == UICollectionView.elementKindSectionHeader else {
                return UICollectionReusableView()
            }
            let view = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: SectionHeaderReusableView.reuseIdentifier,
                for: indexPath) as? SectionHeaderReusableView
            view?.onDelete = {[weak self] in
                self?.viewModel.deleteGroup(at: indexPath.section)
            }
            return view ?? UICollectionReusableView()
        }
        return dataSource
    }
}

extension HomeViewController: UICollectionViewDelegate {}

typealias DataSource = UICollectionViewDiffableDataSource<Section, CellItem>
typealias Snapshot = NSDiffableDataSourceSnapshot<Section, CellItem>

