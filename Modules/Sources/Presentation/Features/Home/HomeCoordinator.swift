//
//  HomeCoordinator.swift
//
//
//  Created by Vadim Marchenko on 09.04.2024.
//

import Foundation
import UIKit
import Domain

final class HomeCoordinator: BaseCoordinator {
    
    //MARK: - Properties
    private let window: UIWindow
    private let diContainer: DIContainer
    
    init(window: UIWindow, diContainer: DIContainer) {
        self.window = window
        self.diContainer = diContainer
    }
    
    override func start() {
        let templatesRepository = diContainer.resolve(type: TemplatesRepository.self)
        let viewModel = HomeViewModel(templatesRepository: templatesRepository)
        let viewController = HomeViewController(viewModel: viewModel)
        window.rootViewController = UINavigationController(rootViewController: viewController)
        window.makeKeyAndVisible()
    }
}
