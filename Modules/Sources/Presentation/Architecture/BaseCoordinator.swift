//
//  BaseCoordinator.swift
//
//
//  Created by Vadim Marchenko on 09.04.2024.
//

import Foundation
import UIKit
import Core

public class BaseCoordinator: Coordinator {
    
    // MARK: - Properties
    private let logger = AppLogger.coordinator
    var parentCoordinator: Coordinator?
    let navigationController = UINavigationController()
    
    weak var delegate:CoordinatorLifeCycle?
    
    var childCoordinators = [Coordinator]();
    
    func start() {
        fatalError("\(#function) should be implemented")
    }
    
    final func start(coordinator: Coordinator) {
        childCoordinators += [coordinator];
        coordinator.parentCoordinator = self;
        coordinator.start();
    }
    
    
    final func didFinish(coordinator: Coordinator) {
        if let first = childCoordinators.firstIndex(where: { $0 === coordinator }) {
            self.childCoordinators.remove(at: first);
        }
    }
    
    final func removeChildCoorninators() {
        if childCoordinators.isEmpty {
            return
        }
        childCoordinators.forEach { $0.removeChildCoorninators() }
        childCoordinators.removeAll()
    }
    
    deinit {
        logger.info("deinit \(String(describing: self))")
    }
}
