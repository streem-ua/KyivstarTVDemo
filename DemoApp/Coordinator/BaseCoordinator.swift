//
//  BaseCoordinator.swift
//  DemoApp
//
//  Created by Alex Oliynyk on 24.10.2024.
//

import UIKit

class BaseCoordinator: Coordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        navigationController.isNavigationBarHidden = true
        self.navigationController = navigationController
    }

    func start() {
        fatalError("Start method should be implemented.")
    }
}
