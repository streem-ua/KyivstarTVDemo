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
        showHome(animate: animate)
    }
    
    //MARK: - Controllers
    
    private func showHome(animate: Bool) {
        let vc = ControllersFactory.home {[weak self] destination in
            switch destination {
            case .detail:
                self?.showDetail()
            }
        }.makeController()
        
        push(controller: vc, animated: animate)
    }
    
    private func showDetail() {
        let vc = ControllersFactory.detail(completionHandler: {[weak self] destination in
            switch destination {
            case .back:
                self?.popController(animated: true)
            }
        }).makeController()
        push(controller: vc, animated: true)
    }
}
