//
//  Coordinator.swift
//  DemoApp
//
//  Created by Karpenko Bohdan on 31.05.2024.
//

import UIKit

typealias CoordinatorHandler = () -> ()

protocol Coordinator: AnyObject, Router {
    var childCoordinators: [Coordinator] {get set}
    var didStart: EmptyClosure? {get set}
    var didFinish: EmptyClosure? {get set}
    
    func start(animate: Bool)
}

extension Coordinator {
    func removeDependency(_ coordinator: Coordinator?) {
      guard
        childCoordinators.isEmpty == false,
        let coordinator = coordinator
        else { return }
      
      if !coordinator.childCoordinators.isEmpty {
          coordinator.childCoordinators
              .filter({ $0 !== coordinator })
              .forEach({ coordinator.removeDependency($0) })
      }
      for (index, element) in childCoordinators.enumerated() where element === coordinator {
          childCoordinators.remove(at: index)
          break
      }
    }
}
