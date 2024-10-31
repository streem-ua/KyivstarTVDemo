//
//  Coordinator.swift
//  DemoApp
//
//  Created by Alex Oliynyk on 24.10.2024.
//

import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    func start()
}
