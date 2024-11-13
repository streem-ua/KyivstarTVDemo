//
//  HomeCoordinator.swift
//  DemoApp
//
//  Created by Vladyslav Lysenko on 28.08.2024.
//

import UIKit

final class HomeCoordinator: Coordinator {
    // MARK: - Public Properties
    let useCases: UseCasesProvider
    
    // MARK: - Private properties
    private lazy var factory: HomeFactoryProtocol = HomeFactory(coordinator: self)
    private unowned var presenter: UINavigationController
    
    // MARK: - Lifecycle
    init(presenter: UINavigationController, useCases: UseCasesProvider) {
        self.useCases = useCases
        self.presenter = presenter
    }
    
    deinit {
        print(#function, " \(self)")
    }
    
    func start(animated: Bool) {
        let homwVC = factory.makeHomeVC(delegate: self)
        presenter.pushViewController(homwVC, animated: animated)
    }
}

// MARK: - HomeVMDelegate
extension HomeCoordinator: HomeVMDelegate {
    func homeVMDidOpenAssetDetails(_ viewModel: HomeVM, assetDetail: AssetDetail) {
        let assetDetailsVC = factory.makeAssetDetails(assetDetail: assetDetail, delegate: self)
        presenter.pushViewController(assetDetailsVC, animated: true)
    }
}

// MARK: - AssetDetailsVMDelegate
extension HomeCoordinator: AssetDetailsVMDelegate {
    func assetDetailsVMDidBack(_ viewModel: AssetDetailsVM) {
        presenter.popViewController(animated: true)
    }
}
