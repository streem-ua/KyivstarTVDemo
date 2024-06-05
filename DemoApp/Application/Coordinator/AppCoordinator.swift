//
//  AppCoordinator.swift
//  DemoApp
//
//  Created by Karpenko Bohdan on 31.05.2024.
//

import UIKit

final class AppCoordinator: Coordinator {

    //MARK: - Properties
    
    var didStart: EmptyClosure?
    var didFinish: EmptyClosure?
    var presenter: BaseNavigationController
    var childCoordinators = [Coordinator]()
    
    private var viewModel: AppCoordinatorViewModel
    
    //MARK: - Init
    
    init(
        viewModel: AppCoordinatorViewModel,
        navigationController: BaseNavigationController = BaseNavigationController()
    ) {
        self.viewModel = viewModel
        self.presenter = navigationController
    }
    
    //MARK: - Configure
    
    private func startWithCoordinator(_ coordinator: Coordinator) {
        viewModel.window?.rootViewController = coordinator.presenter
        coordinator.start(animate: false)
        viewModel.window?.makeKeyAndVisible()
    }
    
    //MARK: - Start
    
    func start(animate: Bool) {
        let mainCoordinator = MainCoordinator()
        childCoordinators.append(mainCoordinator)
        startWithCoordinator(mainCoordinator)
    }
}
