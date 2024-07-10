//
//  HomeViewController.swift
//  DemoApp
//
//  Created by Nik Dub on 06.07.2024.
//

import UIKit
import Combine

class HomeViewController: UIViewController, HomeView {
    
    // MARK: - Outlets -
    
    private lazy var dataSource = makeDataSource()
    var sections: [Section] = [
        Section(title: "Aboba", imageURLs: ["1", "23", "35", "46", "5"]),
        Section(title: "Aboba1", imageURLs: ["a", "b", "c", "d"]),
        Section(title: "Aboba2", imageURLs: ["a1", "b1", "c1", "d1"]),
        Section(title: "Aboba3", imageURLs: ["a2", "b2", "c2", "d2"]),
    ]
    
    private lazy var myDataSource = makeDataSource()
    
//    let emojies = ["Онлайн ТБ", "1234", "Мульты", "54321", "Сериалы, asdas, jkkjkjk", "212?","23322?", "123?", "41w?"]
        
    lazy var collectionView: UICollectionView = {
        $0.register(
            SectionHeaderReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: SectionHeaderReusableView.reuseIdentifier
        )
        return $0
    }(UICollectionView(frame: view.bounds, collectionViewLayout: createLayout()))
    
    let helloLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        
        return label
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
    
    // MARK: - Private properties -
    
    // MARK: - Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        initialSetup()
        configureHierarchy()
//        configureDataSource()
        applySnapshot(animatingDifferences: false)
    }
    
    // MARK: - Private methods -
    
    func applySnapshot(animatingDifferences: Bool = true) {
      // 2
      var snapshot = Snapshot()
      // 3
        snapshot.appendSections(sections)
        sections.forEach { section in
            print(section.imageURLs.count)
            snapshot.appendItems(section.imageURLs, toSection: section)
        }
      // 4
//      snapshot.appendItems(emojies)
      // 5
      dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
    
    func configureHierarchy() {
//           collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
           collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
           view.addSubview(collectionView)
//           collectionView.delegate = self
    }
    
    private func initialSetup() {
        viewModel.start()
    }
    
    private func deleteSection(at index: Int) {
        sections.remove(at: index)
        applySnapshot(animatingDifferences: true)
    }
    
    private func setupViews() {
        helloLabel.text = "Welcome to KyivstarTV test app!"
        logoImageView.image = UIImage(named: "logo_blue")
        headerView.addSubview(logoImageView)
        view.addSubview(headerView)
        view.addSubview(helloLabel)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            logoImageView.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            logoImageView.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 5),
            logoImageView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -5)
        ])
        
        helloLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        helloLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -30).isActive = true
        
    }
    
    func bindToPublisher(_ publisher: AnyPublisher<String, Never>) {
        applySnapshot()
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
        // 1
        collectionView.register(
            SquareTitledCell.self,
            forCellWithReuseIdentifier: SquareTitledCell.identifier
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
            cellProvider: { (collectionView, indexPath, video) ->
                UICollectionViewCell? in
                switch indexPath.section {
                case 0:
                    let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: SquareTitledCell.identifier,
                        for: indexPath) as? SquareTitledCell
                    return cell
                case 1:
                    let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: AssetCell.identifier,
                        for: indexPath) as? AssetCell
                    return cell
                case 2:
                    let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: ChannelCell.identifier,
                        for: indexPath) as? ChannelCell
                    return cell
                default:
                    let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: EPGCell.identifier,
                        for: indexPath) as? EPGCell
                    return cell
                }
            })
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            // 2
            guard kind == UICollectionView.elementKindSectionHeader,
                  self.sections[indexPath.section].isVisible else {
                return UICollectionReusableView()
            }
            // 3
            let view = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: SectionHeaderReusableView.reuseIdentifier,
                for: indexPath) as? SectionHeaderReusableView
            // 4
            view?.onDelete = {
                self.deleteSection(at: indexPath.section)
            }
            return view
        }
        return dataSource
    }
}

extension HomeViewController: UICollectionViewDelegate {}

typealias DataSource = UICollectionViewDiffableDataSource<Section, String>
typealias Snapshot = NSDiffableDataSourceSnapshot<Section, String>

