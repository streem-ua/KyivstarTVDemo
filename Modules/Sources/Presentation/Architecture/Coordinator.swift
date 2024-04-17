//
//  Coordinator.swift
//
//
//  Created by Vadim Marchenko on 09.04.2024.
//

import Foundation
import UIKit

// MARK: - Coordinator
protocol Coordinator: AnyObject {
    
    var parentCoordinator: Coordinator? { get set }
    var navigationController: UINavigationController { get }
    
    var delegate: CoordinatorLifeCycle? { get }
    
    func start()
    func start(coordinator: Coordinator)
    
    func didFinish(coordinator: Coordinator)
    func removeChildCoorninators()
}

// MARK: - CoordinatorLifeCycle
protocol CoordinatorLifeCycle: AnyObject {
    func finish()
}

// MARK: - Navigator
protocol Navigator<Destination>: AnyObject {
    associatedtype Destination
    func navigate(to scene: Destination)
}
