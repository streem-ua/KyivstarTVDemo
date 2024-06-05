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
    case detail(completionHandler: DetailDestination?)
    
    func makeController() -> UIViewController {
        switch self {
        case .home(let completionHandler):
            return HomeViewController(completionHandler: completionHandler)
        case .detail(let completionHandler):
            return UIHostingController(rootView: DetailView(completionHandler: completionHandler))
        }
    }
}
