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
    private let diContainer = DIContainerImpl()
    
    // MARK: - Init
    public init(window: UIWindow) {
        self.window = window
    }
    
   public override func start() {
        removeChildCoorninators()
        let coordinator = HomeCoordinator(window: window, diContainer: diContainer)
        start(coordinator: coordinator)
    }
}
