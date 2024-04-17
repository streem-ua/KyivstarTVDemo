//
//  DetailsCoordinator.swift
//
//
//  Created by Vadim Marchenko on 13.04.2024.
//

import Foundation
import UIKit
import Domain

// MARK: - DetailsCoordinator
final class DetailsCoordinator: BaseCoordinator {
    
    // MARK: - Properties
    private let diContainer: DIContainer
    
    init(diContainer: DIContainer, navigationController: UINavigationController) {
        self.diContainer = diContainer
        super.init(navigationController: navigationController)
    }
    
    override func start() {
        let templatesRepository = diContainer.resolve(type: TemplatesRepository.self)
        let viewModel = DetailsViewModel(templatesRepository: templatesRepository)
        let view = DetailsView(viewModel: viewModel)
        let viewController = DetailsViewController(detailView: view)
        viewController.coordinatorDelegate = self
        navigationController.pushViewController(viewController, animated: true)
    }
}

// MARK: - CoordinatorLifeCycle
extension DetailsCoordinator: CoordinatorLifeCycle {
    func finish() {
        parentCoordinator?.didFinish(coordinator: self)
    }
    
}
