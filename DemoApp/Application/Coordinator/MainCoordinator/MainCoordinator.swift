//
//  MainCoordinator.swift
//  DemoApp
//
//  Created by Karpenko Bohdan on 31.05.2024.
//

import UIKit

final class MainCoordinator: Coordinator {
    
    //MARK: - Properties
    
    var didStart: EmptyClosure?
    var didFinish: EmptyClosure?
    var presenter: BaseNavigationController
    var childCoordinators: [Coordinator] = []
    
    //MARK: - Init

    init(presenter: BaseNavigationController = BaseNavigationController()) {
        self.presenter = presenter
    }
    
    //MARK: - Start
    
    func start(animate: Bool) {
        let vc = HomeViewController()
        presenter.pushViewController(vc, animated: animate)
    }
}
