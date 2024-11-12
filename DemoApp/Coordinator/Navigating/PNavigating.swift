//
//  PNavigating.swift
//  DemoApp
//
//  Created by Anton Ivchenko on 19.08.2024.
//

import UIKit

protocol PNavigating: PNavigatingController {
    func push(_ viewController: UIViewController)
    func push(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?)

    func popVC()
    func popVC(animated: Bool, completion: (() -> Void)?)
    // -
    func popTo(_ viewController: UIViewController.Type)
    func popTo(_ viewController: UIViewController.Type, animated: Bool, completion: (() -> Void)?)
    // -
    func popTo(_ viewController: UIViewController)
    func popTo(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?)

    func popToRoot()
    func popToRoot(animated: Bool, completion: (() -> Void)?)

    func present(_ viewController: UIViewController)
    func present(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?)

    func setViewControllers(_ viewControllers: [UIViewController], animated: Bool)
    func setRootController(_ viewController: UIViewController, animated: Bool)

    func dismiss()
    func dismiss(animated: Bool, completion: (() -> Void)?)
}
