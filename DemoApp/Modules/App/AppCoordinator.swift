//
//  AppCoordinator.swift
//  DemoApp
//
//  Created by Nik Dub on 07.07.2024.
//

import UIKit

class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() -> UIViewController {
        navigationController.setNavigationBarHidden(true, animated: false)
        navigationController.pushViewController(createHome(), animated: true)
        return navigationController
    }
    
    func createHome() -> UIViewController {
        return HomeCoordinatorImpl(navigationController).start()
    }
}
