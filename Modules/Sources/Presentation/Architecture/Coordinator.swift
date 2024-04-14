//
//  Coordinator.swift
//
//
//  Created by Vadim Marchenko on 09.04.2024.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    
    var parentCoordinator: Coordinator? { get set }
    var navigationController: UINavigationController { get }
    
    var delegate: CoordinatorLifeCycle? { get }
    
    func start()
    func start(coordinator: Coordinator)
    
    func didFinish(coordinator: Coordinator)
    func removeChildCoorninators()
}

protocol CoordinatorLifeCycle: AnyObject {
    func finish()
}

protocol Navigator {
    associatedtype Destination
    func navigate(to scene: Destination)
}
