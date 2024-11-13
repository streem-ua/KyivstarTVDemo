//
//  HomeCoordinator.swift
//  DemoApp
//
//  Created by Nik Dub on 06.07.2024.
//

import UIKit

protocol HomeCoordinator: Coordinator {
    func routeTo(_ flow: HomeNavigation)
}

class HomeCoordinatorImpl: HomeCoordinator {
    var navigationController: UINavigationController
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() -> HomeViewController {
        let view = HomeViewController()
        let viewModel = HomeViewModelImpl(coordinator: self)
        view.viewModel = viewModel
        return view
    }
    
    func routeTo(_ flow: HomeNavigation) {
        switch flow {
        case .detail:
            print() // Open detail flow
        }
    }
}

enum HomeNavigation {
    case detail
}
