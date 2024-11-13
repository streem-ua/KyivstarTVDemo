//
//  AppCoordinator.swift
//  DemoApp
//
//  Created by Vlad Tkach on 14.08.2024.
//

import Foundation
import UIKit

final class AppCoordinator: Coordinator {
    
    private let serviceProvider: AppServiceProvider = AppServiceProviderImpl()
    
    let window: UIWindow!
    var rootViewController: UINavigationController?

    var submodules: [Coordinator] = []
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let rootCoordinator = HomeCoordinator()
        rootCoordinator.start()
        
        let controller = rootCoordinator.rootViewController
        self.rootViewController = controller
        submodules.append(rootCoordinator)
        
        window.rootViewController = controller
        window.makeKeyAndVisible()
    }
}
