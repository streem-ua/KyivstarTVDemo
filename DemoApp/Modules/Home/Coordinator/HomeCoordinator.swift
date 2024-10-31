//
//  HomeCoordinator.swift
//  DemoApp
//
//  Created by Alex Oliynyk on 24.10.2024.
//

import Foundation

class HomeCoordinator: BaseCoordinator {
    var childCoordinators = [Coordinator]()

    override func start() {
        let homeViewController = HomeViewController()
        homeViewController.coordinator = self
        navigationController.pushViewController(homeViewController, animated: true)
    }

    func showAssetDetail() {
        let assetDetailCoordinator = AssetDetailCoordinator(navigationController: navigationController)
        assetDetailCoordinator.parentCoordinator = self
        childCoordinators.append(assetDetailCoordinator)
        assetDetailCoordinator.start()
    }

    func childDidFinish(_ child: Coordinator) {
        if let index = childCoordinators.firstIndex(where: { $0 === child }) {
            childCoordinators.remove(at: index)
        }
    }
}
