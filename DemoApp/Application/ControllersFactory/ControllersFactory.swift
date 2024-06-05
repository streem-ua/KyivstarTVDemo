//
//  ControllersFactory.swift
//  DemoApp
//
//  Created by Karpenko Bohdan on 04.06.2024.
//

import UIKit
import SwiftUI

enum ControllersFactory {
    case home(completionHandler: HomeDestination?)
    case detail(model: DetailModel, completionHandler: DetailDestination?)
    case networkErrorAlert(completionHandler: EmptyClosure? = nil, title: String, message: String)
    
    func makeController() -> UIViewController {
        switch self {
        case .home(let completionHandler):
            return HomeViewController(completionHandler: completionHandler)
        case .detail(let model, let completionHandler):
            let viewModel = DetailViewModel(model: model)
            return UIHostingController(rootView: DetailView(completionHandler: completionHandler, viewModel: viewModel))
        case .networkErrorAlert(completionHandler: let completionHandler, title: let title, message: let message):
            return networkErrorAlert(completionHandler: completionHandler, title: title, message: message)
        }
    }
    
    //MARK: - Alerts
    
    func networkErrorAlert(completionHandler: EmptyClosure? = nil, title: String, message: String) -> UIAlertController {
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default) { _ in
            completionHandler?()
        }
        controller.addAction(action)
        return controller
    }
}
