//
//  Coordinator.swift
//  DemoApp
//
//  Created by Bogdan Akopov on 02.01.2025.
//

import UIKit
import SwiftUI

final class Coordinator {
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewController = HomeViewController()
        navigationController.pushViewController(viewController, animated: false)
    }

    func showAssetDetails(for asset: Asset) {
        let assetDetailsView = AssetDetailsView(asset: asset)
        let hostingController = UIHostingController(rootView: assetDetailsView)
        navigationController.pushViewController(hostingController, animated: true)
    }
}
