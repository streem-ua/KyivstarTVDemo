//
//  ControllersFactory.swift
//  DemoApp
//
//  Created by Karpenko Bohdan on 04.06.2024.
//

import UIKit
import SwiftUI

enum ControllersFactory {
    case home(completionHandler: ((HomeViewController.Destination)->())?)
    case detail
    
    func makeController() -> UIViewController {
        switch self {
        case .home(let completionHandler):
            return HomeViewController(completionHandler: completionHandler)
        case .detail:
            return UIHostingController(rootView: DetailView())
        }
    }
}
