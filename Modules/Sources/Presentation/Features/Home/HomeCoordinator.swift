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
    
    //MARK: - Properties
    private var window: UIWindow
    private let diContainer: DIContainer
    
   public init(window: UIWindow, diContainer: DIContainer) {
        self.window = window
        self.diContainer = diContainer
        super.init(navigationController: UINavigationController())
    }
    
    public override func start() {
        let templatesRepository = diContainer.resolve(type: TemplatesRepository.self)
        let viewModel = HomeViewModel(templatesRepository: templatesRepository)
        let viewController = HomeViewController(viewModel: viewModel)
        navigationController.setViewControllers([viewController], animated: false)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        viewController.openDetalScreenDidTap = { [weak self] in
            self?.startDetailCoordinator()
        }
    }
    
    private func startDetailCoordinator() {
        let coordinator = DetailsCoordinator(diContainer: diContainer, navigationController: navigationController)
        start(coordinator: coordinator)
    }
}

