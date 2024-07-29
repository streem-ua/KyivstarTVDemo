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

    init(
        presenter: BaseNavigationController = BaseNavigationController()
    ) {
        self.presenter = presenter
    }
    
    //MARK: - Start
    
    func start(animate: Bool) {
        showHome(animate: animate)
    }
    
    //MARK: - Controllers
    
    /// Currently, the Destination enum has only one case, but it is designed for future expansion.
    /// This ensures flexibility for the future when more calls from the controller might be added.
    
    private func showHome(animate: Bool) {
        let vc = ControllersFactory.home { [weak self] destination in
            switch destination {
            case .detail(let model):
                self?.showDetail(model: model)
            }
        }.makeController()
        
        push(controller: vc, animated: animate)
    }
    
    private func showDetail(model: DetailModel) {
        let vc = ControllersFactory.detail(model: model, completionHandler: {[weak self] destination in
            switch destination {
            case .back:
                self?.popController(animated: true)
            }
        }).makeController()
        
        push(controller: vc, animated: true)
    }
}
