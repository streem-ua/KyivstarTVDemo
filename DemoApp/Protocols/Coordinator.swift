//
//  Coordinator.swift
//  DemoApp
//
//  Created by Nik Dub on 06.07.2024.
//

import UIKit

protocol Coordinator<T> {
    associatedtype T: UIViewController
    var navigationController: UINavigationController { get set }
    func start() -> T
}
