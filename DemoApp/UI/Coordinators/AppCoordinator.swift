//
//  AppCoordinator.swift
//  DemoApp
//
//  Created by Ihor on 06.08.2024.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController! { get set }
    func start()
}

class AppCoordinator: Coordinator {
    private var children: [Coordinator] = []
    weak var navigationController: UINavigationController!

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let mainCoordinator = HomeCoordinator(navigationController)
        children.append(mainCoordinator)
        mainCoordinator.start()
    }
}

class HomeCoordinator: Coordinator {
    weak var navigationController: UINavigationController!

    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        showHome()
    }

    private func showHome() {
        let homeVC = ModuleFactory.homeModule {[weak self] navigationAction in
            switch navigationAction {
            case .itemSelected(let item):
                self?.showDetails(for: item)
            }
        }
        navigationController.pushViewController(homeVC, animated: false)
    }

    private func showDetails(for item: Home.Item) {
        let detailsVC = ModuleFactory.assetDetailsModule()
        navigationController.pushViewController(detailsVC, animated: true)
    }
}
