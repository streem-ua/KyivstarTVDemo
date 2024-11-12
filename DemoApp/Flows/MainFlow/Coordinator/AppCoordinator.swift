//
//  AppCoordinator.swift
//  DemoApp
//
//  Created by Anton Ivchenko on 19.08.2024.
//

import Combine
import Foundation

final class AppCoordinator: BaseCoordinator {
    // MARK: - Properties
    private let assembly: Assembly
    private var cancellable = Set<AnyCancellable>()
    // MARK: - Init
    override init(navigating: PNavigating) {
        self.assembly = .init()
        super.init(navigating: navigating)
    }
    // MARK: - Overriden methods
    override func start() {
        navigateToPreview()
    }
    // MARK: - Private methods
    private func navigateToPreview() {
        let openNext = PassthroughSubject<Void, Never>()
        let vc = assembly.previewVC(openNext: openNext)
        openNext
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.navigateToHomeScreen()
            }
            .store(in: &cancellable)
        navigating.setRootController(vc, animated: true)
    }
    private func navigateToHomeScreen() {
        let openNext = PassthroughSubject<Void, Never>()
        let vc = assembly.homeVC(openNext: openNext)
        openNext
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.navigateToAssetsDetails()
            }
            .store(in: &cancellable)
        navigating.push(vc)
    }
    private func navigateToAssetsDetails() {
        let backAction = PassthroughSubject<Void, Never>()
        let vc = assembly.assetsDetails(backAction: backAction)
        backAction
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.navigating.popVC()
            }
            .store(in: &cancellable)
        navigating.push(vc)
    }
}
