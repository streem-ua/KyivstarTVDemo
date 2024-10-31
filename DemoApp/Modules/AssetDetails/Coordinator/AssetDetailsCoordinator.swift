//
//  AssetDetailsCoordinator.swift
//  DemoApp
//
//  Created by Alex Oliynyk on 24.10.2024.
//

import Foundation
import SwiftUI

class AssetDetailCoordinatorWrapper: ObservableObject {
    weak var coordinator: AssetDetailCoordinator?

    init(coordinator: AssetDetailCoordinator) {
        self.coordinator = coordinator
    }
}

class AssetDetailCoordinator: BaseCoordinator {
    weak var parentCoordinator: HomeCoordinator?

    override func start() {
        let coordinatorWrapper = AssetDetailCoordinatorWrapper(coordinator: self)
        let assetDetailView = AssetDetailsView(coordinatorWrapper: coordinatorWrapper)
        let hostingController = UIHostingController(rootView: assetDetailView)
        navigationController.pushViewController(hostingController, animated: true)
    }

    func didFinishAssetDetail() {
        parentCoordinator?.navigationController.popViewController(animated: true)
        parentCoordinator?.childDidFinish(self)
    }
}
