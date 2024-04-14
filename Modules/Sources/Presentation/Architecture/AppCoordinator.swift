//
//  AppCoordinator.swift
//
//
//  Created by Vadim Marchenko on 09.04.2024.
//

import Foundation
import UIKit

public final class AppCoordinator: BaseCoordinator {
    
    // MARK: - Properties
    private let window: UIWindow
    private let diContainer: DIContainer = DIContainerImpl()
    
    // MARK: - Init
    public init(window: UIWindow) {
        self.window = window
        super.init()
    }
    
   public override func start() {
        removeChildCoorninators()
        let coordinator = HomeCoordinator(window: window, diContainer: diContainer)
        start(coordinator: coordinator)
    }
}
