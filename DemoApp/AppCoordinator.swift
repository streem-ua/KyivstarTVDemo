//
//  AppCoordinator.swift
//  DemoApp
//
//  Created by Vladyslav Lysenko on 26.08.2024.
//

import UIKit

final class AppCoordinator {
    // MARK: - Public Properties
    let window: UIWindow = UIWindow(frame: UIScreen.main.bounds)
    
    // MARK: - Private Properties
    private let useCases: UseCasesProvider
    
    // MARK: - Initialize
    init(useCases: UseCasesProvider) {
        self.useCases = useCases
        start()
    }
    
    private func start() {
        let presenter = UINavigationController()
        window.rootViewController = presenter
        HomeCoordinator(presenter: presenter, useCases: useCases).start()
        window.makeKeyAndVisible()
    }
}
