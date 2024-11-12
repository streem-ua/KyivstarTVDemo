//
//  Navigation.swift
//  DemoApp
//
//  Created by Anton Ivchenko on 20.08.2024.
//

import UIKit

final class Navigation: PNavigating {
    // MARK: - Properties
    let navController: UINavigationController
    // MARK: - Init
    init(_ navController: UINavigationController) {
        self.navController = navController
    }
    // MARK: - Push
    func push(_ viewController: UIViewController) {
        push(viewController, animated: true, completion: nil)
    }
    func push(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        navController.pushViewController(viewController, animated: animated)
        CATransaction.commit()
    }
    // MARK: - Pop
    func popVC() {
        popVC(animated: true, completion: nil)
    }
    func popVC(animated: Bool, completion: (() -> Void)?) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        navController.popViewController(animated: animated)
        CATransaction.commit()
    }
    // MARK: - PopTo
    func popTo(_ viewController: UIViewController.Type) {
        popTo(viewController, animated: true, completion: nil)
    }
    func popTo(_ viewController: UIViewController.Type, animated: Bool, completion: (() -> Void)?) {
        let controllers = navController.viewControllers
        if let vc = controllers.last(where: { $0.isKind(of: viewController.self) }) {
            popTo(vc)
        }
    }
    // -
    func popTo(_ viewController: UIViewController) {
        popTo(viewController, animated: true, completion: nil)
    }
    func popTo(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        if navController.viewControllers.contains(viewController) {
            navController.popToViewController(viewController, animated: animated)
        }
        CATransaction.commit()
    }
    // MARK: - PopToRoot
    func popToRoot() {
        popToRoot(animated: true, completion: nil)
    }
    func popToRoot(animated: Bool, completion: (() -> Void)?) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        navController.popToRootViewController(animated: animated)
        CATransaction.commit()
    }
    // MARK: - Present
    func present(_ viewController: UIViewController) {
        present(viewController, animated: true, completion: nil)
    }
    func present(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        let controller = navController.presentedViewController ?? navController
        controller.present(viewController, animated: animated, completion: completion)
    }
    // MARK: - Set
    func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        navController.setViewControllers(viewControllers, animated: animated)
    }
    func setRootController(_ viewController: UIViewController, animated: Bool) {
        setViewControllers([viewController], animated: animated)
    }
    // MARK: - Dismiss
    func dismiss() {
        dismiss(animated: true, completion: nil)
    }
    func dismiss(animated: Bool, completion: (() -> Void)?) {
        let controller = navController.presentedViewController ?? navController
        controller.dismiss(animated: animated, completion: completion)
    }
}
