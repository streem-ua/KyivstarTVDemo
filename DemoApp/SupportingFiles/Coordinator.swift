//
//  Coordinator.swift
//  DemoApp
//
//  Created by Denys Zaiakin on 28.03.2024.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }

    func start()
}

class AppCoordinator: Coordinator {
    private var children: [Coordinator] = []
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let mainCoordinator = MainCoordinator(navigationController: navigationController)
        children.append(mainCoordinator)
        mainCoordinator.start()
    }
}

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        showHome()
    }

    private func showHome() {
        let viewModel = HomeViewModel()
        viewModel.onTransition = { [weak self] transition in
            switch transition {
            case .showDetails(let item):            self?.showDetails(for: item)
            }
        }

        let homeViewController = HomeViewController()
        homeViewController.viewModel = viewModel
        navigationController.pushViewController(homeViewController, animated: false)
    }

    private func showDetails(for item: Home.Item) {
        let viewModel = DetailViewModel()
        let detailViewController = DetailViewController()
        detailViewController.viewModel = viewModel
        navigationController.pushViewController(detailViewController, animated: true)
    }
}

