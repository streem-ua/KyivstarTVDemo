//
//  HomeCoordinator.swift
//
//
//  Created by Vadim Marchenko on 09.04.2024.
//

import Foundation
import UIKit

final class HomeCoordinator: BaseCoordinator {
    
    //MARK: - Properties
    private let window: UIWindow
    private let diContainer: DIContainer
    
    init(window: UIWindow, diContainer: DIContainer) {
        self.window = window
        self.diContainer = diContainer
    }
    
    override func start() {
        let viewController = HomeViewController(viewModel: HomeViewModel())
        window.rootViewController = UINavigationController(rootViewController: viewController)
        window.makeKeyAndVisible()
    }
}
