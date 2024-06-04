//
//  CollectionViewProvider.swift
//  DemoApp
//
//  Created by Karpenko Bohdan on 01.06.2024.
//

import UIKit

class CollectionViewProvider<Section, Item, ViewModel>: NSObject, UICollectionViewDelegate where Section : Hashable, Section : Sendable, Item : Hashable, Item : Sendable {
    
    weak var collectionView: UICollectionView?
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>?
    var layout: UICollectionViewCompositionalLayout?
    var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
    let viewModel: ViewModel
    
    init(collectionView: UICollectionView, viewModel: ViewModel) {
        self.viewModel = viewModel
        self.collectionView = collectionView
        super.init()
        setupCollectionView()
    }
    
    func setupCollectionView() {
        collectionView?.delegate = self
        setupDataSource()
        collectionView?.collectionViewLayout = setupCompositionalLayout()
    }
    
    private func setupCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout {[weak self] section, env in
            self?.sectionProvider(section, env)
        }
        self.layout = layout
        return layout
    }
    
    func sectionProvider(_ sectionIndex: Int,_ environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? {
        nil
    }
    
    private func setupDataSource() {
        guard let collectionView = collectionView else {return}
        dataSource = .init(collectionView: collectionView,cellProvider: {[weak self] collectionView, indexPath, itemIdentifier in
            return self?.configureCell(collectionView: collectionView, indexPath: indexPath, item:itemIdentifier)
        })
        
        dataSource?.supplementaryViewProvider = {[weak self] (collectionView, kind, indexPath) in
            guard let self = self else {return nil}
            return configureSupplementaryView(collectionView, kind, indexPath)
        }
    }
    
    func configureSupplementaryView(_ collectionView: UICollectionView, _ elementKind: String, _ indexPath: IndexPath) -> UICollectionReusableView? {
        nil
    }
    
    func configureCell(collectionView: UICollectionView, indexPath: IndexPath, item: Item) -> UICollectionViewCell {
        fatalError("")
    }
    
    //MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {}
}
