//
//  AssetDetailsVC.swift
//  DemoApp
//
//  Created by Vladyslav Lysenko on 30.08.2024.
//

import UIKit

extension AssetDetailsVC: Makeable {
    static func make() -> AssetDetailsVC { AssetDetailsVC() }
}

final class AssetDetailsVC: BaseVC, ViewModelContainer {
    // MARK: - Public Properties
    var viewModel: AssetDetailsVM?
    
    // MARK: - Lifecycles
    override func setupVC() {
        super.setupVC()
        setupNavigationBar()
        setupAssetDetailsView()
    }
    
    // MARK: - Setup
    private func setupNavigationBar() {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func setupAssetDetailsView() {
        guard let viewModel, let assetDetail = viewModel.assetDetail else { return }
        let rootView = AssetDetailsView(
            image: assetDetail.image,
            title: assetDetail.name,
            backAction: viewModel.didTapBack
        )
        let adaterView = AdapterView(rootView: rootView, frame: view.bounds)
        
        view.addSubview(adaterView)
        adaterView.addChildController(self)
        
        NSLayoutConstraint.activate([
            adaterView.topAnchor.constraint(equalTo: view.topAnchor, constant: .zero),
            adaterView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .zero),
            adaterView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: .zero),
            adaterView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: .zero)
        ])
    }
}
