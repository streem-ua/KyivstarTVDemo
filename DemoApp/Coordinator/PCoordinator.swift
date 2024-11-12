//
//  PCoordinator.swift
//  DemoApp
//
//  Created by Anton Ivchenko on 19.08.2024.
//

import Foundation

protocol PCoordinator: AnyObject {
    var childCoordinators: [PCoordinator] { get set }
    func start()
}

extension PCoordinator {
    func store(coordinator: PCoordinator) {
        childCoordinators.append(coordinator)
    }
    func storeAndStart(coordinator: PCoordinator) {
        store(coordinator: coordinator)
        coordinator.start()
    }
    func free(coordinator: PCoordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }
}
