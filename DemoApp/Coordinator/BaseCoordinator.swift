//
//  BaseCoordinator.swift
//  DemoApp
//
//  Created by Anton Ivchenko on 19.08.2024.
//

import Foundation

class BaseCoordinator: NSObject, PCoordinator {
    // MARK: - Properties
    let navigating: PNavigating
    var childCoordinators: [PCoordinator] = []
    // MARK: - Init
    init(navigating: PNavigating) {
        self.navigating = navigating
        debugPrint("🟢🟢🟢 Init \(Self.description())")
    }
    deinit {
        debugPrint("🔴🔴🔴 Deinit \(Self.description())")
    }
    // MARK: - Methods
    func start() {
        fatalError("Children should implement `start`.")
    }
}
