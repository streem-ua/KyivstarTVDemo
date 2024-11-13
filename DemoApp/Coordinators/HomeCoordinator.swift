//
//  HomeCoordinator.swift
//  DemoApp
//
//  Created by Vlad Tkach on 14.08.2024.
//

import Foundation
import UIKit
import SwiftUI
import Combine

final class HomeCoordinator: Coordinator {

    let viewModel = HomeViewModel()
    
    private var cancellable = Set<AnyCancellable>()

    // MARK: - Protocol
    var rootViewController: UINavigationController?
    
    func start() {
        let controller = HomeViewController(viewModel)
        let navigation = UINavigationController(rootViewController: controller)
        
        controller.moduleOutputSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] action in
                switch action {
                case .showAssetDetails(let asset):
                    self?.showAssetDetails(model: asset)
                case .showError(let error):
                    self?.showErrorAlert(error: error)
                }
            }.store(in: &cancellable)
        self.rootViewController = navigation
    }
    
    private func showAssetDetails(model: ContentGroup.Asset) {
        
        let view = AssetDetailsView(asset: model)
        let controller = AssetDetailsViewController(detailView: view)
//        let controller = UIHostingController(rootView: view)
          
        rootViewController?.pushViewController(controller, animated: true)
    }
    
    private func showErrorAlert(error: Error) {
        
        let alert = UIAlertController(title: "Some problem",
                                      message: error.localizedDescription,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { [weak alert] action in
            alert?.dismiss(animated: true)
        }))
        
        rootViewController?.viewControllers.last?.present(alert, animated: true)
    }
}
