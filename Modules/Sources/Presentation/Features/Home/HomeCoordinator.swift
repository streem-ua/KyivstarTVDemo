//
//  HomeCoordinator.swift
//
//
//  Created by Vadim Marchenko on 09.04.2024.
//

import Foundation
import UIKit
import Domain

public final class HomeCoordinator: BaseCoordinator {
    
    // MARK: - Properties
    private var window: UIWindow
    private let diContainer: DIContainer
    
    // MARK: - Init
    public init(window: UIWindow, diContainer: DIContainer) {
        self.window = window
        self.diContainer = diContainer
        super.init(navigationController: UINavigationController())
    }
    
    public override func start() {
        let templatesRepository = diContainer.resolve(type: TemplatesRepository.self)
        let viewModel = HomeViewModel(templatesRepository: templatesRepository)
        let viewController = HomeViewController(viewModel: viewModel)
        viewController.navigator = self
        navigationController.setViewControllers([viewController], animated: false)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}

// MARK: - Navigator
enum HomeDestination {
    case details
}

// MARK: - Navigator
extension HomeCoordinator: Navigator {
    typealias Destination = HomeDestination
    
    func navigate(to scene: HomeDestination) {
        switch scene {
        case .details:
            startDetailsCoordinator()
        }
    }
    
    // MARK: - Details
    private func startDetailsCoordinator() {
        let coordinator = DetailsCoordinator(diContainer: diContainer, navigationController: navigationController)
        start(coordinator: coordinator)
    }
}
