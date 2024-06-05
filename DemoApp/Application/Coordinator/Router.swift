//
//  Router.swift
//  DemoApp
//
//  Created by Karpenko Bohdan on 31.05.2024.
//

import UIKit

protocol Router {
    var presenter: BaseNavigationController { get }
    func present(controller: UINavigationController, animated: Bool)
    func push(controller: UIViewController, animated: Bool)
    func popController(animated: Bool)
    func dismissController(animated: Bool)
}

extension Router {
    
    func present(controller: UINavigationController, animated: Bool) {
        presenter.present(controller, animated: animated)
    }
    
    func present(controller: UIViewController, animated: Bool) {
        presenter.present(controller, animated: animated)
    }
    
    func push(controller: UIViewController, animated: Bool) {
        presenter.pushViewController(controller, animated: animated)
    }
    
    func popController(animated: Bool) {
        presenter.popViewController(animated: animated)
    }
    
    func dismissController(animated: Bool) {
        presenter.dismiss(animated: animated)
    }
    
    func popToRootViewController(animated: Bool) {
        presenter.popToRootViewController(animated: animated)
    }
    
    func popToViewController(viewController: UIViewController, animated: Bool) {
        presenter.popToViewController(viewController, animated: animated)
    }
}

